import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:velveta_app/core/enums/dialog_type.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/enums/pay_way.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_dialog.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/checkout_view/checkout_controller.dart';
import 'package:velveta_app/ui/views/address_view/address_view.dart';
import 'package:velveta_app/ui/views/main_view/cart_view/cart_widgets.dart/order_detail_widget.dart';

class CheckOutView extends StatelessWidget {
  CheckOutView({super.key});
  CheckoutController controller = Get.put(CheckoutController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Stack(
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
                title: tr("key_checkout"),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth(20),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenWidth(4),
                bottom: screenWidth(1.45),
                left: screenWidth(25),
                right: screenWidth(25)),
            child: ListView(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                Container(
                  width: screenWidth(1),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/images/svgs/icon_location.svg",
                        width: screenWidth(14),
                        height: screenWidth(14),
                      ),
                      SizedBox(
                        width: screenWidth(20),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: tr("key_delivery_to")),
                            SizedBox(
                              height: screenWidth(40),
                            ),
                            CustomText(text: tr("key_location"))
                          ],
                        ),
                      ),
                      // Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(() => AddressView());
                        },
                        child: Container(
                          height: screenWidth(15),
                          width: screenWidth(6),
                          decoration: BoxDecoration(
                              color: AppColors.grayColorTwo,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: CustomText(
                              text: tr("key_change"),
                              styleType: TextStyleType.SMALL,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: screenWidth(15),
                ),
                CustomText(
                  text: tr("key_payment_method") + " :",
                  styleType: TextStyleType.SUBTITLE,
                ),
                SizedBox(
                  height: screenWidth(20),
                ),
                Obx(
                  () => CustomPayWay(
                    payWay: PayWay.CASH,
                    isSelected: controller.byCash.value,
                    onTap: () {
                      controller.selectCash();
                    },
                  ),
                ),
                SizedBox(
                  height: screenWidth(30),
                ),
                Obx(
                  () => CustomPayWay(
                    payWay: PayWay.CARD,
                    isSelected: controller.byCard.value,
                    onTap: () {
                      controller.selectCard();
                    },
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: screenWidth(22),
                  left: screenWidth(25),
                  right: screenWidth(25)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  OrderDetail(),
                  SizedBox(
                    height: screenWidth(15),
                  ),
                  CustomButton(
                    onPress: () {
                      CustomDialog.showDialog(DialogType.PAYMENT);
                    },
                    title: tr("key_pay"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomPayWay extends StatelessWidget {
  const CustomPayWay({
    super.key,
    required this.payWay,
    required this.onTap,
    required this.isSelected,
  });

  final PayWay payWay;
  final Function onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenWidth(50)),
      decoration: BoxDecoration(
          border: isSelected
              ? Border.all(
                  width: screenWidth(screenWidth(1)),
                  color: AppColors.grayColorTwo)
              : null),
      height: screenWidth(7),
      width: screenWidth(1),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            payWay == PayWay.CASH
                ? SvgPicture.asset(
                    "assets/images/svgs/icon_cash.svg",
                    width: screenWidth(14),
                    height: screenWidth(14),
                  )
                : SvgPicture.asset(
                    "assets/images/svgs/icon_card.svg",
                    width: screenWidth(14),
                    height: screenWidth(14),
                  ),
            SizedBox(
              width: screenWidth(20),
            ),
            payWay == PayWay.CASH
                ? CustomText(text: tr("key_cash"))
                : CustomText(text: tr("key_card")),
            Spacer(),
            InkWell(
              onTap: () {
                onTap();
              },
              child: isSelected
                  ? SvgPicture.asset(
                      "assets/images/svgs/icon_selected_circle.svg",
                      width: screenWidth(14),
                      height: screenWidth(14),
                    )
                  : SvgPicture.asset(
                      "assets/images/svgs/icon_unselected_circle.svg",
                      width: screenWidth(14),
                      height: screenWidth(14),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
