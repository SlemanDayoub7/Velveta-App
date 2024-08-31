import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/user_model.dart';
import 'package:velveta_app/core/data/repository/auth_repository.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/otp_code_view/otp_code_view.dart';

class ForgetPasswordController extends GetxController {
  RxBool isLoading = false.obs;
  bool haveWrong = false;
  UserModel user = UserModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  sendEmail() async {
    if (!checkConnection()) return;
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await AuthRepository().forgotPassword(email: emailController.text).then(
          (value) => value.fold((l) => haveWrong = true, (r) => user = r));
      isLoading.value = false;
      if (haveWrong) {
        showWrongMessage(haveWrong);
        haveWrong = false;
      } else {
        storage.setResetInformation(['', '']);
        List<String> info = storage.getResetInformation();
        info[0] = emailController.text;
        storage.setResetInformation(info);
        Get.to(() => OtpCodeView());
      }
    }
  }
}
