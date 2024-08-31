import 'package:velveta_app/core/data/models/cart_model.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:get/get.dart';
import '../data/models/all_product_model.dart';

class CartService {
  RxList<CartModel> cartList = storage.getCartList().obs;
  RxInt cartCount = 0.obs;
  RxDouble subTotal = 0.0.obs;
  RxDouble taxAmount = 0.0.obs;
  RxDouble deliveryFees = 0.0.obs;
  RxDouble total = 0.0.obs;
  double taxPercent = 0.0;
  double deliveryPercent = 0.0;

  CartService() {
    calcCartCount();
    calcTotals();
  }
  bool isProductInCart(Products model, int boxId, int colorId) {
    return getCartModel(model, boxId, colorId) != null;
  }

  void addToCart(
      {required Products model,
      required int qty,
      required bool isCandel,
      required int boxId,
      required String colorName,
      required String boxName,
      required int colorId}) {
    if (getCartModel(model, boxId, colorId) != null) {
      int index = cartList.indexWhere((element) =>
          element.productModel!.id == model.id &&
          element.boxId == boxId &&
          element.colorId == colorId);
      print("f" + index.toString());
      cartList[index].qty = cartList[index].qty! + qty;
      cartList[index].totals =
          cartList[index].totals! + calaProductTotal(qty, model);
      cartList[index].boxId = boxId;
      cartList[index].colorId = colorId;
    } else {
      print("q");
      cartList.add(CartModel(
          isCandel: isCandel,
          productModel: model,
          qty: qty,
          totals: calaProductTotal(qty, model),
          boxName: boxName,
          colorName: colorName,
          colorId: colorId,
          boxId: boxId));
    }

    storage.setCartList(cartList);
    cartCount.value += qty;
    calcTotals();
  }

  void removeFromCartList(CartModel model) {
    cartList.remove(model);

    storage.setCartList(cartList);
    cartCount.value -= model.qty ?? 0;
    calcTotals();
  }

  void changeQty({
    required CartModel model,
    required bool incress,
  }) {
    CartModel? result =
        getCartModel(model.productModel!, model.boxId!, model.colorId!);

    if (result == null) {
      addToCart(
          isCandel: model.isCandel!,
          model: model.productModel!,
          qty: 1,
          boxId: model.boxId!,
          colorId: model.colorId!,
          colorName: model.colorName!,
          boxName: model.boxName!);
      return;
    }

    int index = cartList.indexWhere((element) =>
        element.productModel!.id == model.productModel!.id &&
        element.boxId == model.boxId &&
        element.colorId == model.colorId);

    if (incress) {
      result.totals = result.totals! + model.productModel!.price!;
      result.qty = result.qty! + 1;
      cartCount.value += 1;
    } else {
      if (result.qty == 1) return;
      result.totals = result.totals! - model.productModel!.price!;
      result.qty = result.qty! - 1;
      cartCount.value -= 1;
    }

    cartList.removeAt(index);
    cartList.insert(index, result);
    //  print(cartList.length);
    storage.setCartList(cartList);
    calcTotals();
  }

  double calaProductTotal(int qty, Products model) {
    return qty * model.price!;
  }

  void clearCart() {
    cartList.clear();
    storage.setCartList(cartList);
    cartCount.value = 0;
    calcTotals();
  }

  CartModel? getCartModel(Products model, int boxId, int colorId) {
    try {
      return cartList.firstWhere(
        (element) => (element.productModel!.id == model.id &&
            element.boxId == boxId &&
            element.colorId == colorId),
      );
    } catch (e) {
      return null;
    }
  }

  void calcCartCount() {
    // int result = 0;
    // cartList.forEach((element) {
    //   result += element.qty!;
    // });

    // cartCount.value = result;

    cartCount.value = cartList.fold(
        0, (previousValue, element) => (element.qty ?? 0) + previousValue);
  }

  void calcTotals() {
    subTotal.value = cartList.fold(
        0, (previousValue, element) => element.totals! + previousValue);
    taxAmount.value = subTotal.value * taxPercent;
    deliveryFees.value = subTotal.value * deliveryPercent;
    total.value = subTotal.value + taxAmount.value + deliveryFees.value;
  }
}
