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
import 'package:velveta_app/ui/views/forget_password_view/forget_password_controller.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({super.key});
  ForgetPasswordController controller = Get.put(ForgetPasswordController());
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
                            title: tr("key_forgot_password"),
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
                              text: tr("key_dont_worry"),
                              styleType: TextStyleType.TITLE,
                            ),
                            SizedBox(
                              height: screenWidth(25),
                            ),
                            CustomText(
                              text: tr("key_write_email_to_send_code"),
                              styleType: TextStyleType.SMALL,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              height: screenWidth(10),
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
                            CustomButton(
                              onPress: () async {
                                await controller.sendEmail();
                              },
                              backColor: AppColors.blackColor,
                              foreColor: AppColors.whiteColor,
                              title: tr("key_send_code"),
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
