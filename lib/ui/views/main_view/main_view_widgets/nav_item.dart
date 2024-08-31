import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class NavItem extends StatelessWidget {
  final IconData? icon;
  final String iconName;
  final bool isSelected;
  final Function onTap;
  final String title;
  NavItem(
      {super.key,
      this.icon,
      required this.isSelected,
      required this.onTap,
      required this.title,
      required this.iconName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          //     border: isSelected ? Border.all(color: AppColors.borderColor) : null,
          borderRadius: BorderRadius.circular(20),
          //     color: isSelected ? AppColors.thirdColor : null,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/svgs/${iconName}" + ".svg",
                width: screenWidth(20),
                height: screenWidth(20),
              ),
              SizedBox(
                height: screenWidth(70),
              ),
              CustomText(
                fontSize: screenWidth(27),
                styleType: TextStyleType.CUSTOM,
                text: title,
                textColor:
                    !isSelected ? AppColors.grayColorTwo : AppColors.blackColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
