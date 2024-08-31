import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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
import 'package:velveta_app/ui/views/edit_profile_view/edit_profile_controller.dart';
import 'package:velveta_app/ui/views/forget_password_view/forget_password_view.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});
  editProfileController controller = Get.put(editProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Obx(
        () => controller.isLoading.value
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
                        title: tr("key_edit_profile"),
                      ),
                    ),
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
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: screenWidth(4),
                                  height: screenWidth(4),
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: screenWidth(4),
                                        height: screenWidth(4),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: controller
                                                        .selectedImage.value !=
                                                    null
                                                ? DecorationImage(
                                                    image: FileImage(controller
                                                        .selectedImage.value!),
                                                    fit: BoxFit.cover)
                                                : null),
                                        child: controller.selectedImage.value ==
                                                null
                                            ? Icon(Icons.image)
                                            : null,
                                      ),
                                      if (controller.selectedImage.value !=
                                          null)
                                        Align(
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          child: InkWell(
                                            onTap: () {
                                              controller.showOption.value =
                                                  true;
                                            },
                                            child: Container(
                                              width: screenWidth(15),
                                              height: screenWidth(15),
                                              decoration: BoxDecoration(
                                                  color: AppColors.grayColorTwo,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
                                              child: Center(
                                                  child: Icon(
                                                Icons.edit,
                                                size: screenWidth(25),
                                              )),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.camera)
                                            .then(
                                          (value) {
                                            if (value != null) {
                                              controller.selectedImage.value =
                                                  File(value.path);
                                              storage.setFilePath(
                                                  File(value.path));
                                            }
                                          },
                                        );

                                        controller.showOption.value = false;
                                      },
                                      child: CustomText(
                                        text: tr("key_camera"),
                                        styleType: TextStyleType.SMALL,
                                      ),
                                    ),
                                    SizedBox(
                                      width: screenWidth(30),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery)
                                            .then(
                                          (value) {
                                            if (value != null) {
                                              controller.selectedImage.value =
                                                  File(value.path);
                                              storage.setFilePath(
                                                  File(value.path));
                                            }

                                            controller.showOption.value = false;
                                          },
                                        );
                                      },
                                      child: CustomText(
                                        text: tr("key_gallery"),
                                        styleType: TextStyleType.SMALL,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenWidth(20),
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
                                return customValidate(value,
                                    tr('key_please_enter_your_last_name'));
                              },
                              controller: controller.lastNameController,
                              hintText: tr("key_last_name"),
                              typeOfTextField: TypeOfTextField.NORMAL,
                              obscureStatus: false),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomTextField(
                              label: tr("key_city"),
                              validator: (value) {
                                return customValidate(
                                    value, tr('key_please_enter_city'));
                              },
                              controller: controller.cityController,
                              hintText: tr("key_city"),
                              typeOfTextField: TypeOfTextField.NORMAL,
                              obscureStatus: false),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomTextField(
                              label: tr("key_state"),
                              validator: (value) {
                                return customValidate(
                                    value, tr('key_please_enter_state'));
                              },
                              controller: controller.stateController,
                              hintText: tr("key_state"),
                              typeOfTextField: TypeOfTextField.NORMAL,
                              obscureStatus: false),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomTextField(
                              label: tr("key_zip_code"),
                              validator: (value) {
                                return customValidate(
                                    value, tr("key_please_enter_zip_code"));
                              },
                              controller: controller.zipCodeController,
                              hintText: tr("key_zip_code"),
                              typeOfTextField: TypeOfTextField.NORMAL,
                              obscureStatus: false),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomText(
                            text: tr("key_phone_number"),
                            styleType: TextStyleType.SUBTITLE,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          Obx(
                            () {
                              print(controller.countryCode.value);
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: screenWidth(6.9),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width:
                                                  screenWidth(screenWidth(1)),
                                              color: AppColors.grayColorOne)),
                                      child: CountryCodePicker(
                                        padding: EdgeInsets.all(0),
                                        textStyle: TextStyle(
                                            fontSize: screenWidth(30),
                                            color: AppColors.blackColor),
                                        showFlag: true,

                                        flagWidth: screenWidth(30),

                                        backgroundColor: AppColors.whiteColor,
                                        showDropDownButton: true,
                                        onChanged: (CountryCode? code) {
                                          controller.countryCode.value =
                                              code.toString();
                                        },
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        initialSelection: '+974',

                                        // optional. Shows only country name and flag
                                        showCountryOnly: false,
                                        // optional. Shows only country name and flag when popup is closed.
                                        showOnlyCountryWhenClosed: false,
                                        // optional. aligns the flag and the Text left
                                        alignLeft: true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenWidth(40),
                                  ),
                                  CustomTextField(
                                    width: screenWidth(2),
                                    controller: controller.phoneController,
                                    validator: (value) {
                                      return validatePhoneNumber(
                                          value, controller.countryCode.value);
                                    },
                                    hintText: "999-999-999",
                                    typeOfTextField: TypeOfTextField.NORMAL,
                                    obscureStatus: false,
                                    textInputType: TextInputType.phone,
                                  )
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          CustomButton(
                            onPress: () async {
                              await controller.editProfile();
                            },
                            title: tr("key_send"),
                          ),
                          SizedBox(
                            height: screenWidth(25),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => ForgetPasswordView());
                            },
                            child: CustomText(
                              text: tr("key_reset_password"),
                              styleType: TextStyleType.SMALL,
                            ),
                          ),
                          SizedBox(
                            height: screenWidth(9),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
