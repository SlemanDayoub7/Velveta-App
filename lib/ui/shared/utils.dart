// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velveta_app/app/my_app_controller.dart';
import 'package:velveta_app/core/data/models/address_model.dart';
import 'package:velveta_app/core/data/models/send_order_model.dart';
import 'package:velveta_app/core/data/repository/shared_prefrence_repository.dart';
import 'package:velveta_app/core/services/cart_service.dart';
import 'package:velveta_app/core/services/connectivity_service.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:velveta_app/ui/views/main_view/favortie_view/favortie_controller.dart';
import 'package:velveta_app/ui/views/main_view/profile_view/profile_controller.dart';
import '../../core/translation/app_translation.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return tr("key_please_enter_email");
  }
  if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) return tr("key_please_enter_valid_email");
  return null;
}

String? customValidate(String? value, String message) {
  if (value == null || value.isEmpty) {
    return message;
  }
  return null;
}

String? validatePhoneNumber(String? value, String countryCode) {
  if (value!.isEmpty) {
    return tr("key_please_enter_your_phone");
  }
  if (!value.startsWith(countryCode)) {
    return '${tr("key_phone_number_not_valid")} ${countryCode}';
  }
  return null;
}

String? validateConfirmPassword(String? value, String? password) {
  if (value == null || value.isEmpty) {
    return tr('key_please_confirm_your_password');
  }
  if (value != password) return tr('key_password_not_complete_match');
  return null;
}

showWrongMessage(bool haveWrong) {
  if (haveWrong) CustomToast.showMeassge(message: tr("key_some_thing_wrong"));
}

Color convertColorStringToColor(String colorString) {
  String hexColor = colorString.replaceAll('#', '');
  int colorValue = int.parse('0xFF$hexColor');
  return Color(colorValue);
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return tr("key_please_enter_password");
  }
  if (value.length < 8) return tr('key_please_enter_valid_password');
  return null;
}

bool checkConnection() {
  if (!isOnline) CustomToast.showMeassge(message: tr("key_no_internet"));
  return isOnline;
}

launchCall(String phoneNumber) {
  launch("tel://" + phoneNumber);
}

launchEmail(String email) {
  launch("mailto:" + email);
}

double screenWidth(double percent) {
  BuildContext context = Get.context!;
  if (context.isPortrait)
    return Get.size.width / percent;
  else
    return Get.size.height / percent;
}

double screenHeight(double percent) {
  BuildContext context = Get.context!;
  if (context.isPortrait)
    return Get.size.height / percent;
  else
    return Get.size.width / percent;
}

Rx<ShippingAddress> selectedAddress = ShippingAddress().obs;
String baseImageUrl = "https://api.velveta.org/public/storage/";
SharedPrefrenceRepository get storage => Get.find<SharedPrefrenceRepository>();
CartService get cartService => Get.find<CartService>();
ConnectivitySerivce get connectivitySerivce => Get.find<ConnectivitySerivce>();
ProfileController get profile => Get.find<ProfileController>();
FavoriteController get favorite => Get.find<FavoriteController>();
MyAppController get baseController => Get.find<MyAppController>();
bool isOnline = true;
