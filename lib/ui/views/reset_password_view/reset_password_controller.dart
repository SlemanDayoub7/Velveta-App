import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/user_model.dart';
import 'package:velveta_app/core/data/repository/auth_repository.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/login_view/login_view.dart';

class ResetPasswordController extends GetxController {
  RxBool showPassword = true.obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  bool haveWrong = false;
  @override
  void onInit() {
    super.onInit();
  }

  resetPassword() async {
    if (!checkConnection()) {
      return;
    }

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      await AuthRepository()
          .resetPassword(
            code: storage.getResetInformation()[1],
            newPasswordConfirmation: confirmPasswordController.text,
            newPassword: passwordController.text,
            email: storage.getResetInformation()[0],
          )
          .then((value) => value.fold((l) => haveWrong = true, (r) {
                haveWrong = r;
              }));
      isLoading.value = false;
      if (haveWrong) {
        showWrongMessage(haveWrong);
        haveWrong = false;
        return;
      }
      Get.offAll(() => LoginView());
    }
  }
}
