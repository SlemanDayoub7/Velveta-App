import 'package:get/get.dart';

import '../../../core/data/models/address_model.dart';
import '../../../core/data/repository/user_repository.dart';
import '../../shared/utils.dart';

class AddressController extends GetxController {
  RxBool isAdderssLoading = false.obs;
  bool haveWrong = false;
  Rx<AllAddressModel> temp = AllAddressModel().obs;
  Rx<AllAddressModel> addressList = AllAddressModel().obs;
  Set<UserShippingAddress> filterdAdreess = {};
  RxInt selectedLocation = (-1).obs;
  @override
  void onInit() async {
    if (storage.getAddressModel() != null) {
      addressList.value = storage.getAddressModel()!;
    }
    await getAllAddress();
    super.onInit();
  }

  getAllAddress() async {
    if (!checkConnection()) return;
    isAdderssLoading.value = true;
    addressList.value = AllAddressModel();
    filterdAdreess.clear();
    await UserRepository().getAddress().then(
        (value) => value.fold((l) => haveWrong = true, (r) => temp.value = r));
    showWrongMessage(haveWrong);
    if (temp.value.userShippingAddress != null) {
      temp.value.userShippingAddress!.forEach((element) {
        print(element.addressLine ??
            "" +
                element.userId.toString() +
                element.city! +
                element.state! +
                element.zipCode!);
        filterdAdreess.add(element);
      });
    }
    print(filterdAdreess.length);
    isAdderssLoading.value = haveWrong = false;
  }
}
