import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/order_detail_model.dart';
import 'package:velveta_app/core/data/repository/order_repository.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class MyOrderDetailController extends GetxController {
  RxBool isLoading = false.obs;
  bool haveWrong = false;
  late int orderId;
  Rx<MyOrderDetailModel> orderDetail = MyOrderDetailModel().obs;
  @override
  MyOrderDetailController(this.orderId);
  void onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    if (!checkConnection()) {
      return;
    }
    isLoading.value = true;
    await OrderRepository().getOrderDetail(orderId).then((value) =>
        value.fold((l) => haveWrong = true, (r) => orderDetail.value = r));
    print(orderDetail.value.orderDetails!.length);
    showWrongMessage(haveWrong);
    isLoading.value = haveWrong = false;
  }
}
