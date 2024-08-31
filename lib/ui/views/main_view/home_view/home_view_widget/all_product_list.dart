import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/views/contact_us_view/contact_us_view.dart';

import '../../../../../core/enums/product_type.dart';
import '../../../../shared/shared_widgets/custom_product.dart';
import '../../../../shared/utils.dart';
import '../../../proudct_view/proudct_view.dart';
import '../home_controller.dart';

class AllProductListView extends StatelessWidget {
  const AllProductListView({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: screenWidth(25), right: screenWidth(25)),
        child: Scrollbar(
          child: AnimationLimiter(
            child: Obx(
              () => controller.selectedCategory.value == 2
                  ? Column(
                      children: [
                        SizedBox(
                          height: screenWidth(20),
                        ),
                        CustomText(text: tr("key_to_make_your_customer_order")),
                        SizedBox(
                          height: screenWidth(20),
                        ),
                        CustomButton(
                          onPress: () {
                            Get.to(() => ContactUsView());
                          },
                          width: screenWidth(1.6),
                          title: tr("key_call_us"),
                        ),
                        SizedBox(
                          height: screenWidth(20),
                        ),
                        controller.products.length == 0
                            ? SizedBox()
                            : Container(
                                width: screenWidth(1),
                                child: CustomText(
                                  text: tr("key_samples"),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                        SizedBox(
                          height: screenWidth(20),
                        ),
                        Container(
                          height: screenWidth(3),
                          width: screenWidth(1),
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 800),
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      curve: Curves.bounceOut,
                                      child: Obx(() => CachedNetworkImage(
                                            filterQuality: FilterQuality.high,
                                            imageUrl: baseImageUrl +
                                                (controller.products[index]
                                                        .imageMain ??
                                                    ""),
                                            width: screenWidth(3),
                                            fit: BoxFit.fill,
                                            height: screenWidth(3),
                                            errorWidget:
                                                (context, error, stackTrace) {
                                              return SizedBox();
                                            },
                                          )),
                                    ),
                                  ),
                                );
                              }),
                              separatorBuilder: ((context, index) {
                                return SizedBox(
                                  width: screenWidth(25),
                                );
                              }),
                              itemCount: controller.products.length),
                        ),
                      ],
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 800),
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              curve: Curves.bounceOut,
                              child: Obx(
                                () => CustomProduct(
                                  isInFavorite: favorite.isInFavorite[
                                              controller.products[index].id] !=
                                          null
                                      ? favorite.isInFavorite[controller
                                                  .products[index].id] ==
                                              1
                                          ? true
                                          : false
                                      : false,
                                  addToFavorite: () {
                                    favorite.manageFavorite(
                                        item: controller.products[index]);
                                  },
                                  product: controller.products[index],
                                  onPress: () {
                                    Get.to(() => ProductView(
                                          product: controller.products[index],
                                        ));
                                  },
                                  productType: ProductType.HOME,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      separatorBuilder: ((context, index) {
                        return SizedBox(
                          height: screenWidth(25),
                        );
                      }),
                      itemCount: controller.products.length),
            ),
          ),
        ));
  }
}
