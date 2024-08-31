import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/splash_view/splash_controller.dart';

import '../landing_view/landing_view.dart';
import '../main_view/main_view.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backGroundColor,
        body: AnimatedSplashScreen(
            splashIconSize: screenWidth(1.5),
            backgroundColor: AppColors.backGroundColor,
            splashTransition: SplashTransition.fadeTransition,
            animationDuration: Duration(milliseconds: 1500),
            splash: Image.asset(
              "assets/images/pngs/logo.png",
              width: screenWidth(1.5),
              height: screenWidth(1.5),
              fit: BoxFit.contain,
            ),
            duration: 1000,
            nextScreen: storage.getLoggedIn() ? MainView() : LandingView()));
  }
}
