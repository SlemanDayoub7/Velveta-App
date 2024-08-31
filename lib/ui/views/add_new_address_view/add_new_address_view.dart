import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/enums/text_field_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text_field.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class AddNewAddressView extends StatelessWidget {
  const AddNewAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Stack(
        children: [
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
                title: tr("key_add_new_address"),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth(20),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenWidth(4),
                bottom: screenWidth(20),
                left: screenWidth(25),
                right: screenWidth(25)),
            child: ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                CustomText(text: tr("key_address_line")),
                SizedBox(
                  height: screenWidth(20),
                ),
                CustomTextField(
                    hintText: tr("key_address_line"),
                    typeOfTextField: TypeOfTextField.NORMAL,
                    obscureStatus: false),
                SizedBox(
                  height: screenWidth(15),
                ),
                CustomText(text: tr("key_city")),
                SizedBox(
                  height: screenWidth(20),
                ),
                CustomTextField(
                    hintText: tr("key_city"),
                    typeOfTextField: TypeOfTextField.NORMAL,
                    obscureStatus: false),
                SizedBox(
                  height: screenWidth(15),
                ),
                CustomText(text: tr("key_state")),
                SizedBox(
                  height: screenWidth(20),
                ),
                CustomTextField(
                    hintText: tr("key_state"),
                    typeOfTextField: TypeOfTextField.NORMAL,
                    obscureStatus: false),
                SizedBox(
                  height: screenWidth(15),
                ),
                CustomText(text: tr("key_zip_code")),
                SizedBox(
                  height: screenWidth(20),
                ),
                CustomTextField(
                    hintText: tr("key_zip_code"),
                    typeOfTextField: TypeOfTextField.NORMAL,
                    obscureStatus: false),
                SizedBox(
                  height: screenWidth(10),
                ),
                CustomButton(
                  onPress: () {
                    Get.to(() => AddNewAddressView());
                  },
                  title: tr("key_save"),
                  isDotted: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
