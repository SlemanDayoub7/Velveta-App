import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/user_model.dart';
import 'package:velveta_app/core/data/repository/user_repository.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class editProfileController extends GetxController {
  RxBool showPassword = true.obs;
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  bool haveWrong = false;
  String message = "";
  var selectedImage = Rx<File?>(null);
  RxBool showOption = false.obs;
  RxString countryCode = ''.obs;
  @override
  void onInit() {
    UserModel user = UserModel();

    countryCode.value = '+963';
    selectedImage.value = storage.getFilePath();
    super.onInit();
  }

  editProfile() async {
    if (!checkConnection()) {
      return;
    }
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await UserRepository()
          .editProfile(
              city: cityController.text,
              phone: phoneController.text,
              message: messageController.text,
              firstName: firstNameController.text,
              lastName: lastNameController.text,
              state: stateController.text,
              zipCode: zipCodeController.text)
          .then((value) => value.fold((l) => print(l), (r) {
                profile.userInfo.value = r.user!;
                UserModel userModel = storage.getUserInfo();
                userModel.user = r.user;

                storage.setUserInfo(userModel);
              }));

      if (haveWrong) {
        CustomToast.showMeassge(message: tr("key_some_thing_wrong"));
      } else {
        CustomToast.showMeassge(message: tr("key_edit_profile_success"));
      }
      isLoading.value = haveWrong = false;
    }
  }
}
