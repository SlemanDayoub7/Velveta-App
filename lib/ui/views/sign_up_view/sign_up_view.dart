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
import 'package:velveta_app/ui/views/login_view/login_view.dart';
import 'package:velveta_app/ui/views/sign_up_view/sign_up_controller.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  SignUpController controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Form(
          key: controller.formKey,
          child: Obx(
            () => controller.isLoading.value
                ? CustomLoader()
                : Stack(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth(13),
                            left: screenWidth(25),
                            right: screenWidth(25)),
                        child: CustomHeader(
                          typeOfHeader: TypeOfHeader.ONE,
                          title: tr("key_create_account"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenWidth(4.3),
                          left: screenWidth(25),
                          right: screenWidth(25)),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          CustomText(
                            text: tr("key_welcome") + " !",
                            styleType: TextStyleType.TITLE,
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomText(
                            text: tr("key_create_account_at_app") + " !",
                            styleType: TextStyleType.SUBTITLE,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: screenWidth(10),
                          ),
                          CustomTextField(
                              label: tr("key_first_name"),
                              validator: (value) {
                                return customValidate(
                                    value, tr('key_please_enter_your_name'));
                              },
                              controller: controller.firstNameController,
                              hintText: tr("key_first_name"),
                              typeOfTextField: TypeOfTextField.NORMAL,
                              obscureStatus: false),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomTextField(
                              label: tr("key_last_name"),
                              validator: (value) {
                                return customValidate(
                                    value, tr('key_please_enter_last_name'));
                              },
                              controller: controller.lastNameController,
                              hintText: tr("key_last_name"),
                              typeOfTextField: TypeOfTextField.NORMAL,
                              obscureStatus: false),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomTextField(
                              label: tr("key_email"),
                              validator: (value) {
                                return validateEmail(value);
                              },
                              controller: controller.emailController,
                              hintText: tr("key_email"),
                              typeOfTextField: TypeOfTextField.NORMAL,
                              obscureStatus: false),
                          SizedBox(
                            height: screenWidth(25),
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
                          Obx(() => CustomTextField(
                              label: tr("key_confirm_password"),
                              validator: (value) {
                                return validateConfirmPassword(
                                    value, controller.passwordController.text);
                              },
                              controller: controller.confirmPasswordController,
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
                              await controller.signUp();
                            },
                            title: tr("key_create_account"),
                            backColor: AppColors.blackColor,
                            foreColor: AppColors.whiteColor,
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          InkWell(
                            onTap: () {
                              Get.off(() => LoginView());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: tr("key_have_account") + " ? ",
                                  styleType: TextStyleType.BODY,
                                  textColor: AppColors.grayColorOne,
                                ),
                                CustomText(
                                  text: tr("key_login"),
                                  styleType: TextStyleType.BODY,
                                  textColor: AppColors.blackColor,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenWidth(10),
                          )
                        ],
                      ),
                    )
                  ]),
          ),
        ));
  }
}
