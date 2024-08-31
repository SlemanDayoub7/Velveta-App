import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class SideItem extends StatelessWidget {
  final String image;
  final String text;
  final Function onTap;
  final bool? needClose;
  const SideItem(
      {super.key,
      this.needClose = false,
      required this.onTap,
      required this.image,
      required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          onTap();
          if (needClose!) Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 20),
          child: Row(
            children: [
              SizedBox(width: screenWidth(15)),
              SvgPicture.asset("assets/images/svgs/${image}.svg",
                  width: screenWidth(9), height: screenWidth(9)),
              SizedBox(width: screenWidth(10)),
              CustomText(
                text: text,
                styleType: TextStyleType.SUBTITLE,
              )
            ],
          ),
        ));
  }
}
