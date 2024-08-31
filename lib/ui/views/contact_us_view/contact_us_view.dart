import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:velveta_app/ui/views/contact_us_view/contact_us_controller.dart';

class ContactUsView extends StatelessWidget {
  ContactUsView({super.key});
  ContactUsController controller = Get.put(ContactUsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: controller.isLoading.value
          ? CustomLoader()
          : Stack(
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
                      title: tr("key_contact_us"),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenWidth(20),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: screenWidth(4),
                      left: screenWidth(25),
                      right: screenWidth(25)),
                  child: Form(
                    key: controller.formKey,
                    child: ListView(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      children: [
                        CustomText(
                          text: tr("key_contact_information") + " :",
                          styleType: TextStyleType.SUBTITLE,
                        ),
                        SizedBox(
                          height: screenWidth(25),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/svgs/${"icon_phone"}" + ".svg",
                              width: screenWidth(16),
                              height: screenWidth(16),
                            ),
                            SizedBox(
                              width: screenWidth(25),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  launchCall('+97430102277');
                                },
                                child: CustomText(
                                  text: "+974 30102277",
                                  styleType: TextStyleType.SMALL,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth(30),
                            ),
                            SvgPicture.asset(
                              "assets/images/svgs/${"icon_email"}" + ".svg",
                              width: screenWidth(16),
                              height: screenWidth(16),
                            ),
                            SizedBox(
                              width: screenWidth(25),
                            ),
                            Expanded(
                              child: CustomText(
                                text: "info@velveta.org",
                                styleType: TextStyleType.SMALL,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenWidth(30),
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/images/svgs/${"icon_location_1"}" +
                                  ".svg",
                              width: screenWidth(16),
                              height: screenWidth(16),
                            ),
                            SizedBox(
                              width: screenWidth(25),
                            ),
                            Expanded(
                              child: CustomText(
                                text: "CITY , STREET , LOCATION  DETAILS HERE",
                                styleType: TextStyleType.SMALL,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenWidth(10),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: AppColors.blackColor,
                                height: screenWidth(screenWidth(1)),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth(8),
                            ),
                            CustomText(text: tr("key_or")),
                            SizedBox(
                              width: screenWidth(8),
                            ),
                            Expanded(
                              child: Container(
                                color: AppColors.blackColor,
                                height: screenWidth(screenWidth(1)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screenWidth(9),
                        ),
                        CustomTextField(
                            label: tr("key_email"),
                            validator: (value) {
                              return validateEmail(value);
                            },
                            controller: controller.emailController,
                            hintText: tr("key_your_email"),
                            typeOfTextField: TypeOfTextField.NORMAL,
                            obscureStatus: false),
                        SizedBox(
                          height: screenWidth(25),
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
                                  value, tr('key_please_enter_your_last_name'));
                            },
                            controller: controller.lastNameController,
                            hintText: tr("key_last_name"),
                            typeOfTextField: TypeOfTextField.NORMAL,
                            obscureStatus: false),
                        SizedBox(
                          height: screenWidth(25),
                        ),
                        CustomTextField(
                            label: tr("key_phone"),
                            validator: (value) {
                              return customValidate(
                                  value, tr("key_please_enter_your_phone"));
                            },
                            controller: controller.phoneController,
                            textInputType: TextInputType.phone,
                            hintText: "999-999-999",
                            typeOfTextField: TypeOfTextField.NORMAL,
                            obscureStatus: false),
                        SizedBox(
                          height: screenWidth(25),
                        ),
                        CustomText(
                          text: tr("key_message"),
                          styleType: TextStyleType.SUBTITLE,
                          fontWeight: FontWeight.normal,
                        ),
                        SizedBox(
                          height: screenWidth(25),
                        ),
                        CustomTextField(
                            validator: (value) {
                              return customValidate(
                                  value, tr("key_type_message"));
                            },
                            controller: controller.messageController,
                            maxLines: 8,
                            maxLength: 500,
                            hintText: tr("key_your_message"),
                            typeOfTextField: TypeOfTextField.NORMAL,
                            obscureStatus: false),
                        SizedBox(
                          height: screenWidth(15),
                        ),
                        CustomButton(
                          onPress: () async {
                            await controller.contactUs();
                          },
                          title: tr("key_send"),
                        ),
                        SizedBox(
                          height: screenWidth(25),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
