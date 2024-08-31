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
import 'package:velveta_app/ui/views/forget_password_view/forget_password_view.dart';
import 'package:velveta_app/ui/views/login_view/login_controller.dart';
import 'package:velveta_app/ui/views/sign_up_view/sign_up_view.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                          title: tr("key_login"),
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
                            text: tr("key_welcome_back"),
                            styleType: TextStyleType.TITLE,
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomText(
                            text: tr("key_login_with_account"),
                            styleType: TextStyleType.SUBTITLE,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: screenWidth(10),
                          ),
                          CustomTextField(
                              label: tr("key_email"),
                              controller: controller.emailController,
                              validator: (value) {
                                return validateEmail(value);
                              },
                              hintText: tr("key_email"),
                              typeOfTextField: TypeOfTextField.NORMAL,
                              obscureStatus: false),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          Obx(
                            () => CustomTextField(
                                label: tr("key_password"),
                                controller: controller.passwordController,
                                validator: (value) {
                                  return validatePassword(value);
                                },
                                onPressVisibleIcon: () {
                                  controller.showPassword.value =
                                      !controller.showPassword.value;
                                },
                                hintText: tr("key_password"),
                                typeOfTextField: TypeOfTextField.PASSWORD,
                                obscureStatus: controller.showPassword.value),
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Container(
                                  height: screenWidth(10),
                                  width: screenWidth(10),
                                  child: Checkbox(
                                    checkColor: AppColors.whiteColor,
                                    activeColor: AppColors.blackColor,
                                    value: controller.rememberMe.value,
                                    onChanged: (value) {
                                      controller.rememberMe.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              CustomText(
                                text: tr("key_rememebr_me"),
                                styleType: TextStyleType.CUSTOM,
                                fontSize: screenWidth(30),
                                fontWeight: FontWeight.bold,
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  Get.to(() => ForgetPasswordView());
                                },
                                child: CustomText(
                                  text: tr("key_forgot_password") + " ?",
                                  styleType: TextStyleType.CUSTOM,
                                  fontSize: screenWidth(30),
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomButton(
                            onPress: () async {
                              await controller.login();
                            },
                            title: tr("key_login"),
                            backColor: AppColors.blackColor,
                            foreColor: AppColors.whiteColor,
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => SignUpView());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomText(
                                  text: tr("key_dont_have_account") + " ? ",
                                  styleType: TextStyleType.BODY,
                                  textColor: AppColors.grayColorOne,
                                ),
                                CustomText(
                                  text: tr("key_sign_up"),
                                  styleType: TextStyleType.BODY,
                                  textColor: AppColors.blackColor,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                        ],
                      ),
                    )
                  ]),
          ),
        ));
  }
}
