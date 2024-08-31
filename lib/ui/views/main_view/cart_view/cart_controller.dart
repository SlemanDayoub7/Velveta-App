import 'package:get/get.dart';

import '../../../../core/data/models/cart_model.dart';
import '../../../shared/utils.dart';

class CartController extends GetxController {
  List<CartModel> get cartList => cartService.cartList;

  @override
  void onInit() {
    super.onInit();
  }

  void checkout() {}
}
