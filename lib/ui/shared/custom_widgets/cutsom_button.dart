import 'package:flutter/material.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Color? backColor;
  final Color? foreColor;
  final Function? onPress;
  final bool? isDotted;
  final bool? enabled;
  final double? width;
  final TextStyleType? textStyleType;
  final bool? isFlexible;
  final Widget? widget;
  final double? height;
  const CustomButton({
    super.key,
    this.title,
    this.backColor,
    this.foreColor,
    this.onPress,
    this.widget,
    this.isDotted = false,
    this.height,
    this.enabled = true,
    this.width,
    this.isFlexible = false,
    this.textStyleType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? screenWidth(7),
      width: isFlexible! ? null : width ?? screenWidth(1),
      child: ElevatedButton(
          onPressed: enabled!
              ? () async {
                  await onPress!();
                }
              : null,
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: backColor ?? AppColors.blackColor,
              foregroundColor: foreColor ?? AppColors.whiteColor,
              elevation: 0,
              shape: BeveledRectangleBorder(),
              side: isDotted!
                  ? null
                  : BorderSide(
                      width: screenWidth(screenWidth(1)),
                      color: Colors.black,
                    )),
          child: widget ??
              CustomText(
                text: title ?? "",
                textColor: foreColor,
                fontWeight: FontWeight.normal,
                styleType: textStyleType ?? TextStyleType.SUBTITLE,
              )),
    );
  }
}
