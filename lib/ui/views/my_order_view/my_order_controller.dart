import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/my_orders_model.dart';
import 'package:velveta_app/core/data/repository/order_repository.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class MyOrderController extends GetxController {
  RxBool isLoading = false.obs;
  bool haveWrong = false;
  Rx<MyOrdersModel> myOrders = MyOrdersModel().obs;
  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  getData() async {
    if (!checkConnection()) {
      return;
    }
    isLoading.value = true;
    await OrderRepository().getMyOrders().then((value) =>
        value.fold((l) => haveWrong = true, (r) => myOrders.value = r));
    showWrongMessage(haveWrong);
    isLoading.value = haveWrong = false;
  }
}
