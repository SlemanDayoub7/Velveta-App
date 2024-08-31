import 'package:dartz/dartz.dart';
import 'package:velveta_app/core/data/models/address_model.dart';
import 'package:velveta_app/core/data/models/all_product_model.dart';
import 'package:velveta_app/core/data/models/common_response.dart';
import 'package:velveta_app/core/data/models/contact_us_model.dart';
import 'package:velveta_app/core/data/models/profile_model.dart';

import 'package:velveta_app/core/data/models/user_model.dart';
import 'package:velveta_app/core/data/network/network_config.dart';
import 'package:velveta_app/core/enums/request_type.dart';
import 'package:velveta_app/core/utils/network_util.dart';

class UserRepository {
  Future<Either<String, UserModel>> editProfile({
    required String firstName,
    required String lastName,
    required String state,
    required String zipCode,
    required String phone,
    required String message,
    required String city,
  }) async {
    try {
      return NetworkUtil.sendRequest(
              type: RequestType.POST,
              route: 'api/user/profile_completed',
              body: {
                "first_name": firstName,
                "last_name": lastName,
                "state": state,
                "city": city,
                "zipCode": zipCode,
                "message": message,
                "phone": phone
              },
              headers: NetworkConfig.getHeaders(
                  type: RequestType.POST, needAuth: true))
          .then((value) {
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

  Future<Either<String, AllAddressModel>> getAddress() async {
    try {
      return NetworkUtil.sendRequest(
              type: RequestType.GET,
              route: 'api/user/all/shipping_address',
              headers: NetworkConfig.getHeaders(
                  type: RequestType.GET, needAuth: true))
          .then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(AllAddressModel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ContactUsModel>> contactUs(
      {required String fullName,
      required String phone,
      required String message,
      required String email}) async {
    try {
      return NetworkUtil.sendRequest(
              type: RequestType.POST,
              route: 'api/user/send_email/contact_us',
              body: {
                "email": email,
                "full_name": fullName,
                "message": message,
                "phone": phone
              },
              headers: NetworkConfig.getHeaders(
                  type: RequestType.POST, needAuth: true))
          .then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(ContactUsModel.fromJson(commonResponse.data ?? {}));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
