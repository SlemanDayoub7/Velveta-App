import 'package:flutter/material.dart';
import 'package:velveta_app/ui/shared/utils.dart';

enum TextStyleType {
  TITLE,
  SUBTITLE,
  BODY,
  SMALL,
  CUSTOM,
}

class CustomText extends StatelessWidget {
  final String text;
  final int? max_lines;
  final TextStyleType? styleType;
  final Color? textColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  const CustomText({
    super.key,
    required this.text,
    this.styleType = TextStyleType.BODY,
    this.textColor,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight = FontWeight.w500,
    this.fontSize,
    this.max_lines,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Text(
      text,
      style: getStyle(size),
      textAlign: textAlign ?? TextAlign.justify,
      overflow: overflow,
      maxLines: max_lines,
    );
  }

  TextStyle getStyle(Size size) {
    TextStyle result = TextStyle();

    switch (styleType) {
      case TextStyleType.TITLE:
        result = TextStyle(
            fontSize: screenWidth(17),
            fontWeight: fontWeight ?? FontWeight.bold,
            color: textColor);
        break;
      case TextStyleType.SUBTITLE:
        result = TextStyle(
            fontSize: screenWidth(20),
            fontWeight: fontWeight ?? FontWeight.bold,
            color: textColor);
        break;
      case TextStyleType.BODY:
        result = TextStyle(
            fontSize: screenWidth(22),
            fontWeight: fontWeight ?? FontWeight.bold,
            color: textColor);
        break;
      case TextStyleType.SMALL:
        result = TextStyle(
            fontSize: screenWidth(27),
            fontWeight: fontWeight,
            color: textColor);
        break;
      case TextStyleType.CUSTOM:
        result = TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
        );
        break;

      default:
        result = TextStyle(
            fontSize: screenWidth(28),
            fontWeight: fontWeight,
            color: textColor);
        break;
    }

    return result;
  }
}
