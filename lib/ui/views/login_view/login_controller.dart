import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/ui/shared/utils.dart';

import '../../../core/data/models/user_model.dart';
import '../../../core/data/repository/auth_repository.dart';
import '../../../core/translation/app_translation.dart';
import '../../shared/custom_widgets/custom_toast.dart';
import '../main_view/main_view.dart';

class LoginController extends GetxController {
  RxBool rememberMe = false.obs;
  RxBool showPassword = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserModel userInfo = UserModel();
  RxBool isLoading = false.obs;
  bool haveWrong = false;

  @override
  void onInit() {
    isSaved();
    super.onInit();
  }

  isSaved() {
    final loginInfo = storage.getLoginInfo();
    emailController.text = loginInfo[0];
    passwordController.text = loginInfo[1];
  }

  login() async {
    if (!checkConnection()) return;

    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      var result = await AuthRepository().login(
        email: emailController.text,
        password: passwordController.text,
      );

      result.fold(
        (l) => haveWrong = true,
        (r) => userInfo = r,
      );

      isLoading.value = false;
      if (haveWrong) {
        haveWrong = false;
        CustomToast.showMeassge(message: tr("key_some_thing_wrong"));
        return;
      }

      if (rememberMe.value) {
        storage.setLoginInfo([emailController.text, passwordController.text]);
      } else {
        storage.setLoginInfo(['', '']);
      }
      storage.setUserInfo(userInfo);
      storage.setLoggedIn(true);
      profile.userInfo.value = userInfo.user!;
      profile.isLoggedIn.value = true;
      CustomToast.showMeassge(message: tr("key_login_success"));
      Get.off(() => MainView());
    }
  }
}
