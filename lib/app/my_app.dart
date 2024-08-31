import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/services.dart';
import 'package:velveta_app/app/my_app_controller.dart';
import 'package:velveta_app/core/enums/connectivityStatus.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/edit_profile_view/edit_profile_view.dart';
import 'package:velveta_app/ui/views/landing_view/landing_view.dart';
import 'package:velveta_app/ui/views/main_view/home_view/home_view.dart';
import 'package:velveta_app/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velveta_app/ui/views/main_view/profile_view/profile_view.dart';
import 'package:velveta_app/ui/views/otp_code_view/otp_code_view.dart';
import 'package:velveta_app/ui/views/proudct_view/proudct_view.dart';
import 'package:velveta_app/ui/views/splash_view/splash_view.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ));
    return GetMaterialApp(
        defaultTransition: Transition.upToDown,
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        locale: getLocal(),
        translations: AppTranslation(),
        navigatorObservers: [BotToastNavigatorObserver()],
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashView());
  }
}

Locale getLocal() {
  String langCode = storage.getAppLanguage();
  return Locale('en', 'US');
  // if (langCode == 'ar')
  //   return Locale('ar', 'SA');
  // else if (langCode == 'en')
  //   return Locale('en', 'US');
  // else if (langCode == 'tr')
  //   return Locale('tr', 'TR');
  // else
  //   return Locale('fr', 'FR');
}
