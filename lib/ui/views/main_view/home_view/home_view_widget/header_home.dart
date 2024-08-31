import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velveta_app/ui/views/main_view/home_view/home_controller.dart';

import '../../../../../core/translation/app_translation.dart';
import '../../../../shared/colors.dart';
import '../../../../shared/custom_widgets/custom_text.dart';
import '../../../../shared/utils.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    required this.controller,
    super.key,
  });

  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenWidth(4.6),
      padding: EdgeInsets.all(screenWidth(50)),
      margin: EdgeInsets.only(
          top: screenWidth(10), left: screenWidth(25), right: screenWidth(25)),
      width: screenWidth(1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: tr("key_hello") + " !",
                  styleType: TextStyleType.TITLE,
                ),
                Obx(() => !profile.isLoggedIn.value
                    ? SizedBox()
                    : CustomText(
                        text: profile.userInfo.value!.firstName ?? "",
                        styleType: TextStyleType.SUBTITLE,
                      )),
              ],
            ),
          ),
          Spacer(),
          Obx(
            () => PopupMenuButton(
              position: PopupMenuPosition.under,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.zero,
              color: AppColors.whiteColor,
              onSelected: (value) {
                print("ss");
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/svgs/icon_location.svg",
                    width: screenWidth(25),
                    fit: BoxFit.fill,
                    height: screenWidth(25),
                  ),
                  SizedBox(
                    width: screenWidth(50),
                  ),
                  controller.addressNames.length == 0
                      ? SizedBox()
                      : Container(
                          width: screenWidth(5),
                          child: CustomText(
                              styleType: TextStyleType.SMALL,
                              text: controller.addressNames[
                                  controller.selectedLocation.value]),
                        ),
                  SizedBox(
                    width: screenWidth(50),
                  ),
                  SvgPicture.asset(
                    "assets/images/svgs/icon_drop_down.svg",
                    width: screenWidth(30),
                    fit: BoxFit.fill,
                    height: screenWidth(30),
                  )
                ],
              ),
              itemBuilder: (context) {
                return [
                  ...List.generate(
                    controller.addressNames.length,
                    (index) => PopupMenuItem(
                      onTap: () {
                        controller.selectedLocation(index);
                      },
                      child: CustomText(
                        text: controller.addressNames[index],
                        styleType: TextStyleType.SMALL,
                      ),
                    ),
                  )
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
