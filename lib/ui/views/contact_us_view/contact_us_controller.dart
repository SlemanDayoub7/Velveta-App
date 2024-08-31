import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/user_model.dart';
import 'package:velveta_app/core/data/repository/auth_repository.dart';
import 'package:velveta_app/core/data/repository/user_repository.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/login_view/login_view.dart';

class ContactUsController extends GetxController {
  RxBool showPassword = true.obs;
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  bool HaveWrong = false;
  String message = "";
  @override
  void onInit() {
    super.onInit();
  }

  contactUs() async {
    if (!isOnline) {
      CustomToast.showMeassge(message: tr("key_no_internet"));
      return;
    }

    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await UserRepository()
          .contactUs(
              fullName:
                  firstNameController.text + " " + lastNameController.text,
              phone: phoneController.text,
              message: messageController.text,
              email: emailController.text)
          .then((value) => value.fold(
              (l) => HaveWrong = true, (r) => message = r.message ?? "sended"));

      if (HaveWrong) {
        CustomToast.showMeassge(message: tr("key_some_thing_wrong"));
      } else {
        CustomToast.showMeassge(message: message);
      }
      isLoading.value = false;
    }
  }
}
