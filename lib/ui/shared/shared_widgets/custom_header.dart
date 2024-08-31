import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class CustomHeader extends StatelessWidget {
  final TypeOfHeader typeOfHeader;
  final String? title;
  final bool? haveIconBack;
  final bool? haveLogo;
  final Widget? widget;
  const CustomHeader({
    super.key,
    required this.typeOfHeader,
    this.title,
    this.haveLogo = true,
    this.widget,
    this.haveIconBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return typeOfHeader == TypeOfHeader.ONE
        ? Container(
            height: screenWidth(6),
            width: screenWidth(1),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  !haveIconBack!
                      ? SizedBox()
                      : InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.blackColor,
                            size: screenWidth(15),
                          ),
                        ),
                  SizedBox(width: title != null ? screenWidth(60) : 0),
                  title != null
                      ? Container(
                          height: null,
                          width: screenWidth(2),
                          child: CustomText(
                              overflow: TextOverflow.ellipsis,
                              text: title!,
                              styleType: TextStyleType.TITLE),
                        )
                      : SizedBox(),
                  haveLogo! ? Spacer() : SizedBox(),
                  haveLogo!
                      ? Image.asset(
                          "assets/images/pngs/logo.png",
                          width: screenWidth(3.8),
                          height: screenWidth(8),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.fill,
                        )
                      : SizedBox(),
                  widget != null ? Spacer() : SizedBox(),
                  widget ?? SizedBox()
                ],
              ),
            ),
          )
        : Row(
            children: [],
          );
  }
}
