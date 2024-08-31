import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_loader.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/forget_password_view/forget_password_view.dart';
import 'package:velveta_app/ui/views/otp_code_view/otp_code_controller.dart';

final inputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.grey.shade400),
);

final inputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: screenWidth(9)),
  border: inputBorder,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black),
  ),
);

class OtpCodeView extends StatelessWidget {
  OtpCodeView({super.key});
  OtpCodeController controller = Get.put(OtpCodeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backGroundColor,
      body: Form(
        key: controller.formKey,
        child: Obx(
          () => controller.isLoading.value
              ? CustomLoader()
              : Stack(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth(13),
                            left: screenWidth(25),
                            right: screenWidth(25)),
                        child: CustomHeader(
                          haveLogo: true,
                          typeOfHeader: TypeOfHeader.ONE,
                          title: tr("key_opt_code"),
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
                              text: tr("key_opt_code"),
                              styleType: TextStyleType.TITLE,
                            ),
                            SizedBox(
                              height: screenWidth(25),
                            ),
                            CustomText(
                              text: tr("key_code_sent_to_email"),
                              styleType: TextStyleType.BODY,
                            ),
                            SizedBox(
                              height: screenWidth(30),
                            ),
                            InkWell(
                              onTap: () {
                                Get.off(() => ForgetPasswordView());
                              },
                              child: Row(
                                children: [
                                  CustomText(
                                    text: controller.email + "? ",
                                    styleType: TextStyleType.SMALL,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  CustomText(
                                    text: tr("key_change_it"),
                                    styleType: TextStyleType.SMALL,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenWidth(15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ...List.generate(5, (index) {
                                  return Obx(
                                    () => SizedBox(
                                      width: screenWidth(6),
                                      height: screenWidth(6),
                                      child: TextFormField(
                                        maxLength: 1,
                                        controller:
                                            controller.controllers[index],
                                        style: TextStyle(
                                            fontSize: screenWidth(26),
                                            fontWeight: FontWeight.bold),
                                        keyboardType: TextInputType.number,
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          counterText: "",
                                          filled: true,
                                          fillColor:
                                              controller.otpCodes[index].isEmpty
                                                  ? AppColors.grayColorTwo
                                                  : AppColors.whiteColor,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: screenWidth(9)),
                                          border: inputBorder,
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.blackColor),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.blackColor),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          controller.setOtpCode(index, value);
                                          if (value.isNotEmpty && index < 4) {
                                            FocusScope.of(context).nextFocus();
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                            SizedBox(
                              height: screenWidth(15),
                            ),
                            Column(
                              children: [
                                Obx(() => CustomButton(
                                      enabled: controller.filledAll.value,
                                      onPress: () async {
                                        await controller.sendCode();
                                      },
                                      title: tr("key_reset_password"),
                                      backColor: AppColors.blackColor,
                                      foreColor: controller.filledAll.value
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                    )),
                                SizedBox(
                                  height: screenWidth(25),
                                ),
                                InkWell(
                                  onTap: () async {
                                    controller.enableResend.value
                                        ? await controller.resendCode()
                                        : null;
                                  },
                                  child: CustomText(
                                    text: tr("key_resend_code") +
                                        "  0" +
                                        ((controller.secondsRemaining.value /
                                                    60)
                                                .toInt())
                                            .toString() +
                                        ":" +
                                        ((controller.secondsRemaining.value %
                                                    60) <
                                                10
                                            ? "0"
                                            : "") +
                                        ((controller.secondsRemaining.value %
                                                60))
                                            .toString(),
                                    fontWeight: FontWeight.bold,
                                    styleType: TextStyleType.SMALL,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: screenWidth(10),
                            ),
                          ],
                        ))
                  ],
                ),
        ),
      ),
    );
  }
}
