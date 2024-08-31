import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:velveta_app/core/data/models/all_product_model.dart';
import 'package:velveta_app/core/data/models/product_detail_model.dart';
import 'package:velveta_app/core/data/repository/product_repository.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class ProductController extends GetxController {
  late Products product;
  RxInt currentImage = 0.obs;
  RxString boxName = ''.obs;
  Rx<ProductDetailModel> productDetail = ProductDetailModel().obs;
  RxBool isLoading = false.obs;
  RxBool isImagesLoading = false.obs;
  RxInt selectedColor = (-1).obs;
  RxInt selectedBox = (-1).obs;
  RxInt boxId = (-1).obs;
  RxBool isCandel = false.obs;
  RxInt qty = 1.obs;
  RxList<String> benefits = <String>[].obs;
  RxInt itemCount = 1.obs;
  final ScrollController scrollController = ScrollController();
  RxBool readMore = false.obs;
  RxBool addedToCart = false.obs;
  bool haveWrong = false;
  RxList<String> productImages = <String>[].obs;
  RxBool addedToFavorite = false.obs;
  RxDouble price = 0.0.obs;
  ProductController({required this.product});
  @override
  void onInit() async {
    await getProductDetail();
    checkIfFavorite();
    super.onInit();
  }

  checkIfFavorite() {
    addedToFavorite.value = favorite.isInFavorite[product.id] == null
        ? false
        : favorite.isInFavorite[product.id] == 1;
  }

  selectColor(int index) {
    if (selectedColor.value == index) {
      selectedColor.value = -1;
    } else {
      if (selectedBox.value == -1) {
        CustomToast.showMeassge(message: tr("key_select_box"));
      }
      selectedColor.value = index;
      currentImage.value = 0;
    }
    getImages();
  }

  selectBox(int index) {
    if (selectedBox.value == index) {
      selectedBox.value = -1;
    } else {
      selectedBox.value = index;
      if (selectedColor.value == -1) {
        CustomToast.showMeassge(message: tr("key_select_color"));
      }
      currentImage.value = 0;
    }
    getImages();
  }

  getImages() async {
    productImages.clear();
    boxId.value = -1;
    if (selectedBox.value != -1 && selectedColor.value != -1) {
      isImagesLoading.value = true;
      await ProductRepository()
          .getCustomImages(
              productDetail.value.product!.boxes![selectedBox.value],
              productDetail.value.product!.colors![selectedColor.value].id!,
              productDetail.value.product!.id!)
          .then((value) => value.fold((l) => showWrongMessage(true), (r) {
                boxId.value = r.boxes!.id!;
                productImages.addAll(r.boxes!.image!);
              }));

      isImagesLoading.value = false;
    } else {
      productImages.addAll(productDetail.value.product!.gallery!);
    }
    currentImage.value = 0;
  }

  getProductDetail() async {
    if (!checkConnection()) return;

    isLoading.value = true;
    final result = await ProductRepository().getProduct(product.id!);

    result.fold(
      (left) => haveWrong = true,
      (right) {
        productDetail.value = right;
        if (productDetail.value.product!.gallery != null) {
          productImages.addAll(productDetail.value.product!.gallery!);
          price.value = productDetail.value.product!.price!;
        }
        if (productDetail.value.product!.benefits != null) {
          String s = "", t = productDetail.value.product!.benefits!;
          for (int i = 0;
              i < productDetail.value.product!.benefits!.length;
              i++) {
            if (t[i] == ',') {
              benefits.add(s);
              s = "";
            } else {
              s += t[i];
            }
          }
        }
      },
    );

    showWrongMessage(haveWrong);
    isLoading.value = haveWrong = false;
  }

  changeQty(bool add) {
    if (add) {
      qty.value++;
    } else {
      if (qty > 1) qty--;
    }
    price.value = (productDetail.value.product!.price ?? 0) * qty.value;
  }

  addToCart(int value) {
    if (selectedBox.value == -1 || selectedColor.value == -1) {
      CustomToast.showMeassge(message: tr("key_select_box_and_color"));
      return;
    }
    if (isImagesLoading.value || boxId.value == -1) return;
    cartService.addToCart(
      model: product,
      qty: value,
      boxId: boxId.value,
      colorId: productDetail.value.product!.colors![selectedColor.value].id!,
      colorName: productDetail.value.product!.colors![selectedBox.value].name!,
      boxName: productDetail.value.product!.boxes![selectedBox.value],
      isCandel: isCandel.value,
    );
    addedToCart.value = true;
    qty.value = 1;
  }

  void addToFavorite() {
    addedToFavorite.value = !addedToFavorite.value;
    favorite.manageFavorite(item: product);
  }
}
