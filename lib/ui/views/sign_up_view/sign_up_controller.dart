import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/user_model.dart';
import 'package:velveta_app/core/data/repository/auth_repository.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/login_view/login_view.dart';

class SignUpController extends GetxController {
  RxBool showPassword = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UserModel userInfo = UserModel();
  RxBool isLoading = false.obs;
  bool haveWrong = false;
  @override
  void onInit() {
    super.onInit();
  }

  signUp() async {
    if (!checkConnection()) return;
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      await AuthRepository()
          .signUp(
              lastName: lastNameController.text,
              firstName: firstNameController.text,
              email: emailController.text,
              password: passwordController.text,
              passwordConfirmation: confirmPasswordController.text)
          .then((value) => value.fold((l) => haveWrong = true, (r) {
                haveWrong = !r;
              }));
      isLoading.value = false;
      if (haveWrong) {
        showWrongMessage(haveWrong);
        haveWrong = false;
        return;
      }
      Get.off(() => LoginView());
    }
  }
}
