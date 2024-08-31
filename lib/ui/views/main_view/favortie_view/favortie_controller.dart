import 'package:get/get.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_toast.dart';

import '../../../../core/data/models/all_product_model.dart';
import '../../../../core/data/repository/product_repository.dart';
import '../../../../core/translation/app_translation.dart';
import '../../../shared/utils.dart';

class FavoriteController extends GetxController {
  RxBool isLoading = false.obs;
  bool haveWrong = false;
  RxList<String> productsId = <String>[].obs;
  AllProductModel allProductModel = AllProductModel();
  RxList<Products> favoriteList = <Products>[].obs;
  RxMap isInFavorite = {}.obs;

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
    favoriteList.clear();
    productsId.clear();
    productsId.addAll(storage.getFavoriteList());
    await ProductRepository().getAllProduct().then((value) =>
        value.fold((l) => haveWrong = true, (r) => allProductModel = r));
    if (haveWrong) {
      CustomToast.showMeassge(message: tr("key_some_thing_wrong"));
    } else {
      productsId.forEach((e1) {
        var x = allProductModel.products!.firstWhere(
            (e2) => e2.id.toString() == e1,
            orElse: () => Products(id: -1));
        if (x.id != -1) {
          favoriteList.add(x);
          isInFavorite[x.id] = 1;
        } else {
          isInFavorite[x.id] = 0;
        }
      });
    }
    isLoading.value = haveWrong = false;
  }

  bool isProductInFavorite(Products product) {
    return favoriteList.contains(product);
  }

  void reorderFavorites(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item = favoriteList.removeAt(oldIndex);
    favoriteList.insert(newIndex, item);
  }

  manageFavorite({required Products item}) {
    if (isProductInFavorite(item)) {
      isInFavorite[item.id] = 0;
      productsId.removeWhere((element) => element == item.id.toString());
      favoriteList.removeWhere((element) => element.id == item.id);
    } else {
      isInFavorite[item.id] = 1;
      productsId.add(item.id.toString());
      favoriteList.add(item);
    }
    storage.setFavoriteList(productsId);
  }
}
