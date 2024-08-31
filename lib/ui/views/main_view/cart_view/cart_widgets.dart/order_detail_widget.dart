import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenWidth(20)),
      decoration: BoxDecoration(
          border: Border.all(
              width: screenWidth(screenWidth(1)),
              color: AppColors.grayColorOne)),
      width: screenWidth(1),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomText(
                  text: tr("key_subtotal"),
                ),
                Spacer(),
                CustomText(text: cartService.subTotal.toString())
              ],
            ),
            SizedBox(
              height: screenWidth(20),
            ),
            Row(
              children: [
                CustomText(
                  text: tr("key_shipping"),
                ),
                Spacer(),
                CustomText(
                  text: "Calculated at the next step",
                  textColor: AppColors.grayColorOne,
                )
              ],
            ),
            SizedBox(
              height: screenWidth(20),
            ),
            Container(
              color: AppColors.blackColor,
              width: screenWidth(1),
              height: screenWidth(screenWidth(1)),
            ),
            SizedBox(
              height: screenWidth(20),
            ),
            Row(
              children: [
                CustomText(
                  styleType: TextStyleType.SUBTITLE,
                  text: tr("key_total"),
                ),
                Spacer(),
                CustomText(
                    styleType: TextStyleType.SUBTITLE,
                    text: cartService.total.toString())
              ],
            )
          ],
        ),
      ),
    );
  }
}
