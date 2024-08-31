import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/landing_view/landing_controller.dart';
import 'package:velveta_app/ui/views/login_view/login_view.dart';
import 'package:velveta_app/ui/views/main_view/main_view.dart';

class LandingView extends StatelessWidget {
  LandingView({super.key});
  LandingController controller = Get.put(LandingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox.expand(
          child: Image.asset(
        "assets/images/pngs/intro_background.png",
        width: screenWidth(1),
        height: screenHeight(1),
        fit: BoxFit.cover,
      )),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Container(
          color: AppColors.backGroundColor.withOpacity(0.4),
          alignment: Alignment.center,
        ),
      ),
      Padding(
          padding: EdgeInsets.only(
            top: screenWidth(2),
          ),
          child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth(25), right: screenWidth(25)),
                  child: Image.asset(
                    "assets/images/pngs/welcome_logo.png",
                    width: screenWidth(1.5),
                    height: screenHeight(4),
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: screenWidth(4),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth(25), right: screenWidth(25)),
                  child: CustomButton(
                    onPress: () {
                      Get.to(
                        () => LoginView(),
                      );
                    },
                    title: tr("key_login"),
                    foreColor: AppColors.whiteColor,
                    backColor: AppColors.blackColor,
                  ),
                ),
                SizedBox(height: screenWidth(10)),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: screenWidth(screenWidth(1)),
                        color: AppColors.blackColor,
                      ),
                    ),
                    SizedBox(width: screenWidth(90)),
                    CustomText(text: tr("key_first_time_using")),
                    SizedBox(width: screenWidth(90)),
                    Expanded(
                      child: Container(
                        height: screenWidth(screenWidth(1)),
                        color: AppColors.blackColor,
                      ),
                    )
                  ],
                ),
                SizedBox(height: screenWidth(10)),
                Padding(
                  padding: EdgeInsets.only(
                      left: screenWidth(25), right: screenWidth(25)),
                  child: CustomButton(
                    onPress: () {
                      Get.off(() => MainView());
                    },
                    title: tr("key_vesitor"),
                    foreColor: AppColors.blackColor,
                    backColor: AppColors.transparentColor,
                  ),
                ),
                SizedBox(
                  height: screenWidth(10),
                )
              ]))
    ]));
  }
}
