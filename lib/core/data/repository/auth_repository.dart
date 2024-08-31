import 'package:dartz/dartz.dart';
import 'package:velveta_app/core/data/models/common_response.dart';

import 'package:velveta_app/core/data/models/user_model.dart';
import 'package:velveta_app/core/enums/request_type.dart';
import 'package:velveta_app/core/utils/network_util.dart';

class AuthRepository {
  Future<Either<String, UserModel>> login({
    required String password,
    required String email,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: 'api/login',
        body: {
          'email': email,
          'password': password,
        },
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);
        print(commonResponse.data);
        if (commonResponse.getStatus) {
          return Right(UserModel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> signUp({
    required String password,
    required String passwordConfirmation,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: 'api/register',
        body: {
          'email': email,
          'password_confirmation': passwordConfirmation,
          'first_name': firstName,
          'last_name': lastName,
          'password': password,
        },
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);
        print(commonResponse.data);
        if (commonResponse.getStatus) {
          return Right(true);
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> forgotPassword({
    required String email,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: 'api/user/forgot_password',
        body: {
          'email': email,
        },
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(UserModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> checkToken({
    required String code,
  }) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: 'api/user/reset_password/check_token',
        body: {
          'code': code,
        },
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(false);
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> resetPassword(
      {required String code,
      required String newPasswordConfirmation,
      required String email,
      required String newPassword}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: 'api/user/reset_password',
        body: {
          'code': code,
          'new_password_confirmation': newPasswordConfirmation,
          'new_password': newPassword,
          'email': email
        },
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(false);
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
