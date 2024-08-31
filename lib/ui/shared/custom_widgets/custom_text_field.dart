import 'package:flutter/material.dart';
import 'package:velveta_app/core/enums/text_field_type.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool? isPassword;
  final double? width;
  final int? maxLines;
  final String? label;
  final TextInputType? textInputType;
  final int? maxLength;
  final TypeOfTextField typeOfTextField;
  final bool obscureStatus;
  final Function? onPressVisibleIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.isPassword,
      required this.typeOfTextField,
      required this.obscureStatus,
      this.onPressVisibleIcon,
      this.maxLines = 1,
      this.maxLength,
      this.textInputType,
      this.controller,
      this.validator,
      this.width,
      this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? SizedBox()
            : CustomText(
                text: label!,
                styleType: TextStyleType.SUBTITLE,
                fontWeight: FontWeight.normal,
              ),
        SizedBox(
          height: label != null ? screenWidth(25) : 0,
        ),
        Container(
          width: width,
          child: TextFormField(
            validator: validator,
            controller: controller,
            maxLength: maxLength,
            keyboardType: textInputType,
            maxLines: maxLines,
            obscureText: obscureStatus,
            cursorColor: AppColors.grayColorOne,
            cursorWidth: screenWidth(screenWidth(1)),
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: screenWidth(25),
            ),
            decoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                errorStyle: TextStyle(fontSize: screenWidth(25)),
                errorMaxLines: 2,
                contentPadding: EdgeInsets.all(screenWidth(23.5)),
                suffixIcon: typeOfTextField == TypeOfTextField.NORMAL
                    ? null
                    : IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          obscureStatus
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: screenWidth(15),
                          color: AppColors.grayColorOne,
                        ),
                        onPressed: () {
                          onPressVisibleIcon!();
                        }),
                hintText: hintText,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    color: AppColors.redColor,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    color: AppColors.redColor,
                  ),
                ),
                hintStyle: TextStyle(
                    color: AppColors.grayColorOne, fontSize: screenWidth(25)),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.zero),
                  borderSide: BorderSide(
                    color: AppColors.blackColor,
                  ),
                ),
                enabledBorder: outlineInputBorder),
          ),
        ),
      ],
    );
  }
}

TextStyle textStyle =
    TextStyle(color: AppColors.grayColorOne, fontSize: screenWidth(25));
OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.zero),
  borderSide: BorderSide(
    color: AppColors.grayColorOne,
  ),
);
