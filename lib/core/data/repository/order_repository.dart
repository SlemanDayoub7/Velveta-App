import 'package:dartz/dartz.dart';
import 'package:velveta_app/core/data/models/my_orders_model.dart';
import 'package:velveta_app/core/data/models/order_detail_model.dart';
import 'package:velveta_app/ui/views/main_view/cart_view/cart_widgets.dart/order_detail_widget.dart';
import 'package:velveta_app/ui/views/my_order_detail_view/my_order_detail_view.dart';

import '../../enums/request_type.dart';
import '../../utils/network_util.dart';
import '../models/common_response.dart';
import '../network/network_config.dart';

class OrderRepository {
  Future<Either<String, MyOrdersModel>> getMyOrders() async {
    try {
      return NetworkUtil.sendRequest(
              type: RequestType.GET,
              route: 'api/user/all/order',
              headers: NetworkConfig.getHeaders(
                  type: RequestType.GET, needAuth: true))
          .then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(MyOrdersModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, MyOrderDetailModel>> getOrderDetail(int id) async {
    try {
      return NetworkUtil.sendRequest(
              type: RequestType.POST,
              route: 'api/user/all/order_detail',
              body: {'order_id': id.toString()},
              headers: NetworkConfig.getHeaders(
                  type: RequestType.POST, needAuth: true))
          .then((value) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(value);

        if (commonResponse.getStatus) {
          return Right(MyOrderDetailModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
