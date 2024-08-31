import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/my_orders_model.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/enums/product_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_loader.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_product.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/checkout_view/checkout_view.dart';
import 'package:velveta_app/ui/views/my_order_view/my_order_controller.dart';

import 'my_order_view_widgets/custom_order.dart';

class MyOrderView extends StatelessWidget {
  MyOrderView({super.key});
  MyOrderController controller = Get.put(MyOrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Obx(
        () => controller.isLoading.value
            ? CustomLoader()
            : controller.myOrders.value.orders == null
                ? SizedBox()
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
                            title: tr("key_my_orders"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenWidth(20),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth(4),
                            left: screenWidth(25),
                            right: screenWidth(25)),
                        child: ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return CustomOrder(
                                    myOrder: controller
                                        .myOrders.value.orders![index]);
                              }),
                              itemCount:
                                  controller.myOrders.value.orders!.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      top: screenWidth(9),
                                      bottom: screenWidth(9)),
                                  width: screenWidth(1),
                                  height: 1,
                                  color: AppColors.grayColorOne,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
