import 'package:dartz/dartz.dart';
import 'package:velveta_app/core/data/models/all_product_model.dart';
import 'package:velveta_app/core/data/models/box_model.dart';
import 'package:velveta_app/core/data/models/common_response.dart';
import 'package:velveta_app/core/data/models/product_detail_model.dart';

import 'package:velveta_app/core/data/models/slider_model.dart';
import 'package:velveta_app/core/enums/request_type.dart';
import 'package:velveta_app/core/utils/network_util.dart';

class ProductRepository {
  Future<Either<String, AllProductModel>> getAllProduct() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: 'api/all/products',
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(AllProductModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SliderModel>> getSlider() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        route: 'api/slider',
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(SliderModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, BoxModel>> getCustomImages(
      String boxName, int colorId, int productId) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          route: 'api/images/box',
          body: {
            'box_name': boxName,
            'color_id': colorId.toString(),
            'product_id': productId.toString()
          }).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(BoxModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, AllProductModel>> getMyOrders() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        route: 'api/user/all/order',
      ).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(AllProductModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductDetailModel>> getProduct(int id) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          route: 'api/product',
          body: {'product_id': id.toString()}).then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(ProductDetailModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
  // Future<Either<String, List<Products>>> getProductByCategory(
  //     String category) async {
  //   try {
  //     return NetworkUtil.sendRequest(
  //       type: RequestType.GET,
  //       route: 'products/category/$category',
  //     ).then((value) {
  //       CommonResponse<List<dynamic>> commonResponse =
  //           CommonResponse.fromJson(value);

  //       if (commonResponse.getStatus) {
  //         List<Products> result = [];
  //         // commonResponse.data!.forEach(
  //         //   (element) {
  //         //     result.add(ProductModel.fromJson(element));
  //         //   },
  //         // );
  //         return Right(result);
  //       } else {
  //         return Left(commonResponse.message);
  //       }
  //     });
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }
}
