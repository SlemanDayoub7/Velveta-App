import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/views/my_order_detail_view/my_order_detail_controller.dart';
import 'package:velveta_app/ui/views/my_order_view/my_order_controller.dart';

import '../../../core/enums/header_type.dart';
import '../../../core/translation/app_translation.dart';
import '../../shared/colors.dart';
import '../../shared/shared_widgets/custom_header.dart';
import '../../shared/shared_widgets/custom_loader.dart';
import '../../shared/utils.dart';

class MyOrderDetail extends StatelessWidget {
  final MyOrderDetailController controller;
  final int orderId;
  MyOrderDetail({super.key, required this.orderId})
      : controller = Get.put(MyOrderDetailController(orderId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Obx(
        () => controller.isLoading.value
            ? CustomLoader()
            : Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: screenWidth(13),
                          left: screenWidth(25),
                          right: screenWidth(25)),
                      child: CustomHeader(
                        haveIconBack: true,
                        haveLogo: false,
                        typeOfHeader: TypeOfHeader.ONE,
                        title: tr("key_my_order"),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenWidth(20),
                  ),
                  controller.orderDetail.value.orderDetails == null
                      ? SizedBox()
                      : Padding(
                          padding: EdgeInsets.only(
                              top: screenWidth(4),
                              left: screenWidth(25),
                              right: screenWidth(25)),
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: screenWidth(20),
                              );
                            },
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return CustomText(
                                  text: controller.orderDetail.value
                                      .orderDetails![index].price
                                      .toString());
                            },
                            itemCount: controller
                                .orderDetail.value.orderDetails!.length,
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
