import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:velveta_app/core/data/models/address_model.dart';
import 'package:velveta_app/core/data/models/all_product_model.dart';
import 'package:velveta_app/core/data/models/slider_model.dart';
import 'package:velveta_app/core/data/repository/product_repository.dart';
import 'package:velveta_app/core/data/repository/user_repository.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class HomeController extends GetxController {
  RxBool isProductLoading = false.obs;
  RxBool isAdderssLoading = false.obs;
  RxBool isSliderLoading = false.obs;
  CarouselController carouselController = CarouselController();
  RxInt current_index = 0.obs;
  RxList<String> addressNames = <String>[].obs;
  Rx<AllAddressModel> addressList = AllAddressModel().obs;
  bool haveWrong = false;
  RxInt selectedLocation = 0.obs;
  RxInt selectedCategory = 0.obs;
  RxList<String> categories = <String>["Luxury", "Retail", "Customized"].obs;
  Rx<AllProductModel> allProducts = AllProductModel().obs;
  Rx<SliderModel> slider = SliderModel().obs;
  RxList<Products> products = <Products>[].obs;
  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  selectLoaction(int index) {
    selectedLocation.value = index;
  }

  selectCategory(int index) {
    selectedCategory.value = index;
    products.clear();
    if (index == 0) {
      products.addAll(allProducts.value.products!);
      return;
    }
    allProducts.value.products!.forEach((element) {
      if (element.type == categories[selectedCategory.value])
        products.add(element);
    });
  }

  getAllAddress() async {
    if (!checkConnection()) return;
    isAdderssLoading.value = true;
    await UserRepository().getAddress().then((value) =>
        value.fold((l) => haveWrong = true, (r) => addressList.value = r));

    showWrongMessage(haveWrong);
    addressNames.clear();
    if (!haveWrong) {
      int lenght = addressList.value.userShippingAddress!.length;
      storage.saveAddressModel(addressList.value);
      addressNames.addAll([
        ...List.generate(
            lenght, (index) => "Location " + (index + 1).toString())
      ]);
    }

    print(addressList.value.userShippingAddress!.length);
    isAdderssLoading.value = haveWrong = false;
  }

  getProducts() async {
    if (!checkConnection()) return;
    isProductLoading.value = true;
    allProducts.value = AllProductModel();
    products.clear();
    await ProductRepository().getAllProduct().then((value) =>
        value.fold((l) => haveWrong = true, (r) => allProducts.value = r));
    if (!haveWrong && allProducts.value.products != null)
      allProducts.value.products!.forEach((element) {
        products.add(element);
      });

    showWrongMessage(haveWrong);
    isProductLoading.value = haveWrong = false;
  }

  getSlider() async {
    if (!checkConnection()) return;
    isSliderLoading.value = true;
    slider.value = SliderModel();
    await ProductRepository().getSlider().then((value) =>
        value.fold((l) => haveWrong = true, (r) => slider.value = r));
    showWrongMessage(haveWrong);
    isSliderLoading.value = haveWrong = false;
  }

  getData() async {
    if (!checkConnection()) return;
    selectedCategory.value = 0;
    isSliderLoading.value =
        isProductLoading.value = isAdderssLoading.value = true;
    if (storage.getLoggedIn()) await getAllAddress();
    await getSlider();
    await getProducts();
  }

  moveToRight() {
    carouselController.nextPage();
  }

  moveToLeft() {
    carouselController.previousPage();
  }
}
