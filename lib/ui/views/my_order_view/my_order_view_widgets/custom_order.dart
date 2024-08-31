import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/ui/views/my_order_detail_view/my_order_detail_view.dart';
import '../../../../core/data/models/my_orders_model.dart';
import '../../../../core/translation/app_translation.dart';
import '../../../shared/colors.dart';
import '../../../shared/custom_widgets/custom_text.dart';
import '../../../shared/utils.dart';

class CustomOrder extends StatelessWidget {
  final Orders myOrder;
  const CustomOrder({
    super.key,
    required this.myOrder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => MyOrderDetail(orderId: myOrder.id!));
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: tr("key_payment_method") +
                        " : " +
                        myOrder.paymentMethod),
                Spacer(),
                Container(
                    width: screenWidth(5.4),
                    height: screenWidth(12),
                    color: AppColors.blackColor,
                    child: Center(
                        child: FittedBox(
                      child: CustomText(
                        styleType: TextStyleType.SMALL,
                        text: myOrder.status!,
                        textColor: AppColors.whiteColor,
                      ),
                    )))
              ],
            ),
            CustomText(
                text: tr("key_date") +
                    " : " +
                    myOrder.createdAt!.day +
                    "-" +
                    myOrder.createdAt!.month +
                    "-" +
                    myOrder.createdAt!.year),
            SizedBox(
              height: screenWidth(20),
            ),
            CustomText(
                text: tr("key_time") +
                    " : " +
                    myOrder.createdAt!.hour +
                    ":" +
                    myOrder.createdAt!.minute),
            SizedBox(
              height: screenWidth(20),
            ),
            Container(
              padding: EdgeInsets.all(screenWidth(20)),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: screenWidth(screenWidth(1)),
                      color: AppColors.grayColorOne)),
              width: screenWidth(1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomText(
                        text: tr("key_subtotal"),
                      ),
                      Spacer(),
                      CustomText(text: myOrder.priceTotal.toString())
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
                        text: myOrder.priceTotal.toString(),
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
                          text: myOrder.priceTotal.toString())
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
