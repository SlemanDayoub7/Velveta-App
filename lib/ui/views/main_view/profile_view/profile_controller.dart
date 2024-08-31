import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/language_model.dart';
import 'package:velveta_app/core/data/models/user_model.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_dialog.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/login_view/login_view.dart';

class ProfileController extends GetxController {
  var selectedImage = Rx<File?>(null);

  RxBool isSelect = true.obs;
  RxBool isLoggedIn = false.obs;
  RxInt selectedLanguageIndex = 0.obs;
  RxBool showOption = false.obs, changeInformation = false.obs;
  Rx<User> userInfo = User().obs;
  RxList<Language> languages = <Language>[
    Language('English', 'en', 'US'),
  ].obs;
  @override
  void onInit() async {
    selectedImage.value = storage.getFilePath();
    userInfo.value = storage.getUserInfo().user!;
    isLoggedIn.value = storage.getLoggedIn();
    super.onInit();
  }

  refresh() {
    selectedImage.value = storage.getFilePath();
    userInfo.value = storage.getUserInfo().user!;
  }

  void changeLanguage() {
    Get.updateLocale(Locale(languages[selectedLanguageIndex.value].code,
        languages[selectedLanguageIndex.value].countryCode));
    Get.back();
  }

  bool checkIsLoggedIn() {
    if (!isLoggedIn.value) {
      CustomToast.showMeassge(message: tr("key_you_must_login"));
      return false;
    }
    return true;
  }

  logOut() {
    Get.defaultDialog(
      radius: BorderSide.strokeAlignCenter,
      contentPadding: EdgeInsets.all(screenWidth(30)),
      title: tr("key_alert"),
      backgroundColor: AppColors.backGroundColor,
      middleText: tr("key_log_out_alert"),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CustomButton(
                title: tr("key_cancel"),
                onPress: () {
                  Get.back();
                },
              ),
            ),
            SizedBox(
              width: screenWidth(20),
            ),
            Expanded(
              child: CustomButton(
                title: tr("key_log_out"),
                onPress: () {
                  storage.setLoggedIn(false);
                  isLoggedIn.value = false;
                  userInfo.value = UserModel().user!;
                  storage.setUserInfo(UserModel());
                  RxList<String> list = <String>[].obs;
                  storage.setFavoriteList(list);
                  Get.back();
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  logIn() {
    Get.to(() => LoginView());
  }
}
