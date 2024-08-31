import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/repository/auth_repository.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/reset_password_view/reset_password_view.dart';

class OtpCodeController extends GetxController {
  RxList<String> otpCodes = List<String>.filled(5, '').obs;
  RxBool filledAll = false.obs;
  RxString email = "".obs;
  RxInt secondsRemaining = 120.obs;

  RxBool enableResend = false.obs;
  late Timer timer;
  final List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  bool haveWrong = false;
  RxBool isLoading = false.obs;
  GlobalKey formKey = GlobalKey();
  @override
  void onInit() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        secondsRemaining.value--;
      } else {
        enableResend.value = true;
      }
    });

    email.value = storage.getResetInformation()[0];
    super.onInit();
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  resendCode() async {
    enableResend.value = false;
    secondsRemaining.value = 120;
    await AuthRepository()
        .forgotPassword(email: email.value)
        .then((value) => value.fold((l) => haveWrong = true, (r) => null));
    showWrongMessage(haveWrong);
    haveWrong = false;
  }

  setOtpCode(int index, String code) {
    otpCodes[index] = code;
    int numberCount = 0;
    otpCodes.forEach((element) {
      if (element != '') numberCount++;
    });
    filledAll.value = numberCount == 5;
    numberCount = 0;
  }

  sendCode() async {
    if (!checkConnection()) {
      return;
    }
    String combinedOTP = otpCodes.join('');
    filledAll.value = false;
    isLoading.value = true;
    await AuthRepository().checkToken(code: combinedOTP).then(
        (value) => value.fold((l) => haveWrong = true, (r) => haveWrong = r));
    filledAll.value = true;
    isLoading.value = false;
    if (haveWrong) {
      showWrongMessage(haveWrong);
      haveWrong = false;
      return;
    }
    List<String> info = storage.getResetInformation();
    info[1] = combinedOTP;
    storage.setResetInformation(info);
    Get.to(() => ResetPasswordView());
  }
}
