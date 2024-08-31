import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class AboutUsView extends StatelessWidget {
  AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: screenWidth(30)),
              child: CustomText(text: "© Copyright 2024 - Velveta"),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenWidth(13),
                  left: screenWidth(25),
                  right: screenWidth(25)),
              child: CustomHeader(
                haveLogo: false,
                typeOfHeader: TypeOfHeader.ONE,
                title: tr("key_about_us"),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth(20),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: screenWidth(4),
            ),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth(40)),
                  color: AppColors.grayColorTwo,
                  width: screenWidth(1),
                  child: Center(
                    child: Column(children: [
                      Image.asset(
                        "assets/images/pngs/logo.png",
                        width: screenWidth(1.7),
                        height: screenWidth(4),
                      ),
                      SizedBox(
                        height: screenWidth(30),
                      ),
                      CustomText(text: "velveta for mobile V 0.1")
                    ]),
                  ),
                ),
                SizedBox(
                  height: screenWidth(9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
