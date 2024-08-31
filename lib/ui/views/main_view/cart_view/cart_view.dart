import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/enums/product_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_product.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/checkout_view/checkout_view.dart';
import 'package:velveta_app/ui/views/main_view/cart_view/cart_controller.dart';
import 'package:velveta_app/ui/views/main_view/cart_view/cart_widgets.dart/order_detail_widget.dart';
import 'package:velveta_app/ui/views/proudct_view/proudct_view.dart';

class CartView extends StatelessWidget {
  final bool haveBackIcon;
  CartView({super.key, this.haveBackIcon = false});
  CartController controller = Get.put(CartController());
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
                haveIconBack: haveBackIcon,
                haveLogo: false,
                typeOfHeader: TypeOfHeader.ONE,
                title: tr("key_cart"),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth(20),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenWidth(4),
                bottom: screenWidth(1.4),
                left: screenWidth(25),
                right: screenWidth(25)),
            child: Scrollbar(
              thickness: screenWidth(100),
              radius: Radius.circular(30),
              child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Obx(
                    () => ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) {
                          return Obx(() {
                            print(cartService.total);
                            return CustomProduct(
                              onPress: () {},
                              cartModel: controller.cartList[index],
                              productType: ProductType.CART,
                            );
                          });
                        }),
                        separatorBuilder: ((context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                top: screenWidth(30), bottom: screenWidth(30)),
                            color: AppColors.grayColorTwo,
                            width: screenWidth(1),
                            height: screenWidth(screenWidth(1)),
                          );
                        }),
                        itemCount: controller.cartList.length),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: screenWidth(25),
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
                      //Get.to(() => CheckOutView());
                    },
                    title: tr("key_continue_to_checkout"),
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
