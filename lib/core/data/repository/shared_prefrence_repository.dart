import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velveta_app/core/data/models/address_model.dart';

import 'package:velveta_app/core/data/models/cart_model.dart';
import 'package:velveta_app/core/data/models/user_model.dart';

import 'package:velveta_app/core/enums/data_type.dart';

class SharedPrefrenceRepository {
  SharedPreferences pref = Get.find<SharedPreferences>();

  //!---- Keys  ------

  String PREF_FIRST_LUNCH = 'first_lunch';
  String PREF_LOCATION = 'location';
  String PREF_IS_LOGGED = 'logged_in';
  String PREF_LOGIN_INFO = 'login_info';
  String PREF_FAVORTIE_LIST = 'favorite_list';
  String PREF_TOKEN_INFO = 'token_info';
  String PREF_APP_LANG = 'app_language';
  String PREF_CART_LIST = 'cart_list';
  String PREF_USER_INFO = 'user_info';
  String PREF_MODE = 'mode';
  String PREF_RESET_INFORMATION = 'reset_information';
  String PREF_IMAGE_FILE = "FILE_PATH";
  String PREF_ADDRESS = 'user_shipping_address';

  void saveAddressModel(AllAddressModel addressModel) {
    String json = jsonEncode(addressModel.toJson());
    setPrefrenc(type: DataType.STRING, key: PREF_ADDRESS, value: json);
  }

  AllAddressModel? getAddressModel() {
    String? json = getPrefrence(PREF_ADDRESS);
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      return AllAddressModel.fromJson(map);
    }
    return null;
  }

  void setFilePath(File file) {
    setPrefrenc(type: DataType.STRING, key: PREF_IMAGE_FILE, value: file.path);
  }

  File? getFilePath() {
    if (pref.containsKey(PREF_IMAGE_FILE)) {
      return File(getPrefrence(PREF_IMAGE_FILE));
    } else
      return null;
  }

  void setResetInformation(List<String> value) {
    setPrefrenc(
        type: DataType.LISTSTRING, key: PREF_RESET_INFORMATION, value: value);
  }

  List<String> getResetInformation() {
    if (pref.containsKey(PREF_RESET_INFORMATION)) {
      List<Object?> result = getPrefrence(PREF_RESET_INFORMATION);

      List<String> info = [];

      result.forEach((element) {
        info.add(element.toString());
      });
      return info;
    } else
      return ['', ''];
  }

  setUserInfo(UserModel userModel) {
    setPrefrenc(
        type: DataType.STRING,
        key: PREF_USER_INFO,
        value: json.encode(userModel.toJson()));
  }

  UserModel getUserInfo() {
    if (pref.containsKey(PREF_USER_INFO)) {
      return UserModel.fromJson(json.decode(getPrefrence(PREF_USER_INFO)));
    } else {
      return UserModel();
    }
  }

  void setFavoriteList(RxList<String> value) {
    setPrefrenc(
        type: DataType.LISTSTRING, key: PREF_FAVORTIE_LIST, value: value);
  }

  List<String> getFavoriteList() {
    if (pref.containsKey(PREF_FAVORTIE_LIST)) {
      List<Object?> result = getPrefrence(PREF_FAVORTIE_LIST);
      List<String> favoriteList = [];
      result.forEach((element) {
        favoriteList.add(element.toString());
      });
      return favoriteList;
    } else
      return [];
  }

  void setLoginInfo(List<String> value) {
    setPrefrenc(type: DataType.LISTSTRING, key: PREF_LOGIN_INFO, value: value);
  }

  List<String> getLoginInfo() {
    if (pref.containsKey(PREF_LOGIN_INFO)) {
      List<Object?> result = getPrefrence(PREF_LOGIN_INFO);

      List<String> info = [];

      result.forEach((element) {
        info.add(element.toString());
      });
      return info;
    } else
      return ['', ''];
  }

  void setLoggedIn(bool value) {
    setPrefrenc(type: DataType.BOOL, key: PREF_IS_LOGGED, value: value);
  }

  bool getLoggedIn() {
    if (pref.containsKey(PREF_IS_LOGGED))
      return getPrefrence(PREF_IS_LOGGED);
    else
      return false;
  }

  void setFirstLunch(bool value) {
    setPrefrenc(type: DataType.BOOL, key: PREF_FIRST_LUNCH, value: value);
  }

  bool getFirstLunch() {
    if (pref.containsKey(PREF_FIRST_LUNCH))
      return getPrefrence(PREF_FIRST_LUNCH);
    else
      return true;
  }

  void setTokenInfo(String token) {
    setPrefrenc(
        type: DataType.STRING, key: PREF_TOKEN_INFO, value: jsonEncode(token));
  }

  String getTokenInfo() {
    return (jsonDecode(getPrefrence(PREF_TOKEN_INFO)));
  }

  void setAppLanguage(String code) {
    setPrefrenc(type: DataType.STRING, key: PREF_APP_LANG, value: code);
  }

  String getAppLanguage() {
    if (pref.containsKey(PREF_APP_LANG)) {
      return getPrefrence(PREF_APP_LANG);
    } else {
      return 'en';
    }
  }

  void setCartList(List<CartModel> list) {
    setPrefrenc(
        type: DataType.STRING,
        key: PREF_CART_LIST,
        value: CartModel.encode(list));
  }

  List<CartModel> getCartList() {
    if (pref.containsKey(PREF_CART_LIST))
      return CartModel.decode(getPrefrence(PREF_CART_LIST));
    else
      return [];
  }

  //*====================================

  void setPrefrenc({
    required DataType type,
    required String key,
    required dynamic value,
  }) async {
    switch (type) {
      case DataType.INT:
        await pref.setInt(key, value);
        break;
      case DataType.STRING:
        await pref.setString(key, value);
        break;
      case DataType.BOOL:
        await pref.setBool(key, value);
        break;
      case DataType.DOUBLE:
        await pref.setDouble(key, value);
        break;
      case DataType.LISTSTRING:
        await pref.setStringList(key, value);
        break;
    }
  }

  dynamic getPrefrence(String key) {
    return pref.get(key);
  }
}
