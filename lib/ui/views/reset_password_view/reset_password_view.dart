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
import 'package:velveta_app/ui/shared/shared_widgets/custom_loader.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/reset_password_view/reset_password_controller.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});
  ResetPasswordController controller = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Obx(() => Form(
              key: controller.formKey,
              child: controller.isLoading.value
                  ? CustomLoader()
                  : Stack(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth(13),
                            left: screenWidth(25),
                            right: screenWidth(25)),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: [
                            CustomHeader(
                              typeOfHeader: TypeOfHeader.ONE,
                              title: tr("key_reset_password"),
                            ),
                            SizedBox(
                              height: screenWidth(13),
                            ),
                            CustomText(
                              text: tr("key_reset_password"),
                              styleType: TextStyleType.TITLE,
                            ),
                            SizedBox(
                              height: screenWidth(25),
                            ),
                            CustomText(
                              text: tr(
                                  "key_enter_new_password_and_dont_forget_it"),
                              styleType: TextStyleType.SUBTITLE,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              height: screenWidth(10),
                            ),
                            Obx(() => CustomTextField(
                                label: tr("key_password"),
                                validator: (value) {
                                  return validatePassword(value);
                                },
                                controller: controller.passwordController,
                                onPressVisibleIcon: () {
                                  controller.showPassword.value =
                                      !controller.showPassword.value;
                                },
                                hintText: tr("key_password"),
                                typeOfTextField: TypeOfTextField.PASSWORD,
                                obscureStatus: controller.showPassword.value)),
                            SizedBox(
                              height: screenWidth(25),
                            ),
                            CustomText(
                              text: tr("key_confirm_password"),
                              styleType: TextStyleType.SUBTITLE,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              height: screenWidth(25),
                            ),
                            Obx(() => CustomTextField(
                                validator: (value) {
                                  return validateConfirmPassword(value,
                                      controller.passwordController.text);
                                },
                                controller:
                                    controller.confirmPasswordController,
                                onPressVisibleIcon: () {
                                  controller.showPassword.value =
                                      !controller.showPassword.value;
                                },
                                hintText: tr("key_confirm_password"),
                                typeOfTextField: TypeOfTextField.PASSWORD,
                                obscureStatus: controller.showPassword.value)),
                            SizedBox(
                              height: screenWidth(25),
                            ),
                            CustomButton(
                              onPress: () async {
                                await controller.resetPassword();
                              },
                              title: tr("key_reset_password"),
                              backColor: AppColors.blackColor,
                              foreColor: AppColors.whiteColor,
                            ),
                            SizedBox(
                              height: screenWidth(10),
                            )
                          ],
                        ),
                      )
                    ]),
            )));
  }
}
