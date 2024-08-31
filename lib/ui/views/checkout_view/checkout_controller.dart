import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/send_order_model.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class CheckoutController extends GetxController {
  RxBool byCash = true.obs;
  RxBool byCard = false.obs;
  Rx<SendOrderModel> order = SendOrderModel().obs;
  @override
  void onInit() {
    cartService.cartList.forEach((element) {
      order.value.orderDetails!.add(OrderDetails(
          productId: element.productModel!.id,
          isCandle: element.isCandel ?? false,
          colorId: element.colorId,
          boxId: element.boxId));
    });

    super.onInit();
  }

  selectCash() {
    byCash.value = true;
    order.value.paymentMethod = "cash";
    byCard.value = false;
  }

  selectCard() {
    byCard.value = true;
    order.value.paymentMethod = "card";
    byCash.value = false;
  }
}
