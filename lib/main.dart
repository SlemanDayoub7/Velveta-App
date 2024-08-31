import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:velveta_app/app/my_app.dart';
import 'package:velveta_app/app/my_app_controller.dart';
import 'package:velveta_app/core/data/repository/shared_prefrence_repository.dart';
import 'package:velveta_app/core/services/connectivity_service.dart';
import 'core/services/cart_service.dart';
import 'ui/views/main_view/profile_view/profile_controller.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Get.lazyPut(
    () => SharedPrefrenceRepository(),
  );

  await Get.putAsync<SharedPreferences>(
    () async {
      return await SharedPreferences.getInstance();
    },
  );
  Get.put(ConnectivitySerivce());
  await Get.putAsync<MyAppController>(
    () async {
      return await MyAppController();
    },
  );

  Get.put(ProfileController());

  Get.put(CartService());

  runApp(MyApp());
}
