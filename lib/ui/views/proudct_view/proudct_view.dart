import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/all_product_model.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_loader.dart';
import 'package:velveta_app/ui/shared/shared_widgets/image_slider.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/proudct_view/product_controller.dart';

import '../main_view/cart_view/cart_view.dart';

class ProductView extends StatelessWidget {
  final Products product;
  final ProductController controller;
  ProductView({super.key, required this.product})
      : controller = Get.put(ProductController(product: product));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SizedBox(
          height: screenHeight(1),
          width: screenWidth(1),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.grayColorTwo,
                      border: Border(
                          bottom: BorderSide(
                        color: AppColors.grayColorOne,
                      ))),
                  margin: EdgeInsets.only(top: screenWidth(10)),
                  height: screenWidth(1.3),
                  width: screenWidth(1),
                  child: Stack(
                    children: [
                      Obx(() => controller.isImagesLoading.value
                          ? CustomLoader()
                          : controller.productImages.length == 0
                              ? SizedBox()
                              : ImageSlider(
                                  onChanged: () {},
                                  imageUrls: [...controller.productImages],
                                ))
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenHeight(50),
                        right: screenWidth(20),
                        top: screenWidth(9)),
                    child: CustomHeader(
                      typeOfHeader: TypeOfHeader.ONE,
                      haveLogo: false,
                      widget: Obx(
                        () => InkWell(
                          onTap: () {
                            controller.addToFavorite();
                          },
                          child: Container(
                              padding: EdgeInsets.all(screenWidth(50)),
                              height: screenWidth(8),
                              width: screenWidth(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.blackColor),
                              child: Center(
                                child: Icon(
                                  controller.addedToFavorite.value
                                      ? Icons.favorite_sharp
                                      : Icons.favorite_outline,
                                  color: AppColors.whiteColor,
                                  size: screenWidth(13),
                                ),
                              )
                              //   SvgPicture.asset(
                              //   "assets/images/svgs/icon_heart.svg",
                              //   width: screenWidth(11),
                              //   fit: BoxFit.fill,
                              //   height: screenWidth(11),
                              // ),
                              ),
                        ),
                      ),
                    ),
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Obx(
                  () => Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth(20), right: screenWidth(20)),
                    child: controller.addedToCart.value
                        ? CustomButton(
                            onPress: () {
                              Get.off(() => CartView(
                                    haveBackIcon: true,
                                  ));
                            },
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: CustomText(
                                      styleType: TextStyleType.SMALL,
                                      textAlign: TextAlign.left,
                                      text: cartService.cartCount.toString() +
                                          " " +
                                          tr("key_item")),
                                ),
                                Expanded(
                                    child: Center(
                                  child: CustomText(
                                    textAlign: TextAlign.center,
                                    text: tr("key_view_cart"),
                                  ),
                                )),
                                Expanded(
                                  child: CustomText(
                                    textAlign: TextAlign.right,
                                    text: cartService.total.toString(),
                                    styleType: TextStyleType.SMALL,
                                  ),
                                ),
                              ],
                            ),
                            backColor: AppColors.blackColor,
                            foreColor: AppColors.whiteColor,
                          )
                        : Container(
                            height: screenWidth(6),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: CustomButton(
                                    onPress: () {
                                      controller
                                          .addToCart(controller.qty.value);
                                    },
                                    title: tr("key_add_to_cart"),
                                    backColor: AppColors.blackColor,
                                    foreColor: AppColors.whiteColor,
                                  ),
                                ),
                                SizedBox(width: screenWidth(100)),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        child: Center(
                                            child: CustomText(
                                      text: controller.price.value.toString(),
                                      styleType: TextStyleType.BODY,
                                    ))))
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              Obx(
                () => controller.isLoading.value
                    ? CustomLoader()
                    : Padding(
                        padding: EdgeInsets.only(
                            top: screenWidth(1.1),
                            bottom: screenWidth(6),
                            left: screenWidth(25),
                            right: screenWidth(25)),
                        child: controller.productDetail.value.product == null
                            ? SizedBox()
                            : ListView(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: screenWidth(2),
                                        child: CustomText(
                                          overflow: TextOverflow.visible,
                                          text: (controller.productDetail.value
                                                  .product!.title ??
                                              ""),
                                          styleType: TextStyleType.SUBTITLE,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      AppColors.grayColorTwo)),
                                          child: Center(
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  controller.changeQty(false);
                                                },
                                                icon: Icon(
                                                  Icons.remove,
                                                  size: screenWidth(12),
                                                )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: screenWidth(30),
                                      ),
                                      Container(
                                        width: screenWidth(6),
                                        child: CustomText(
                                            textAlign: TextAlign.center,
                                            text: controller.qty.toString()),
                                      ),
                                      SizedBox(
                                        width: screenWidth(30),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      AppColors.grayColorTwo)),
                                          child: Center(
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  controller.changeQty(true);
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  size: screenWidth(12),
                                                )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: screenWidth(30)),
                                  CustomText(
                                    text: tr("key_material") +
                                        " : ${controller.productDetail.value.product!.material ?? ""}",
                                    styleType: TextStyleType.SMALL,
                                    textColor: AppColors.grayColorOne,
                                  ),
                                  SizedBox(
                                    height: screenWidth(16),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                          styleType: TextStyleType.SUBTITLE,
                                          text: tr("key_with_candel") + " : "),
                                      SizedBox(
                                        width: screenWidth(10),
                                      ),
                                      Switch(
                                        inactiveThumbColor:
                                            AppColors.grayColorOne,
                                        activeColor: AppColors.greenColor,
                                        value: controller.isCandel.value,
                                        onChanged: (value) {
                                          controller.isCandel.value =
                                              !controller.isCandel.value;
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: screenWidth(16),
                                  ),
                                  controller.productDetail.value.product!
                                              .boxes ==
                                          null
                                      ? SizedBox()
                                      : CustomText(
                                          text: tr("key_box_shape") + " :",
                                          styleType: TextStyleType.SUBTITLE,
                                        ),
                                  SizedBox(
                                    height: screenWidth(20),
                                  ),
                                  controller.productDetail.value.product!
                                              .boxes ==
                                          null
                                      ? SizedBox()
                                      : Container(
                                          width: screenWidth(1),
                                          height: screenWidth(11),
                                          child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                width: screenWidth(10),
                                              );
                                            },
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller.productDetail
                                                .value.product!.boxes!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Obx(
                                                () => InkWell(
                                                  onTap: () {
                                                    controller.selectBox(index);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        screenWidth(80)),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: controller
                                                                        .selectedBox
                                                                        .value ==
                                                                    index
                                                                ? AppColors
                                                                    .grayColorOne
                                                                : AppColors
                                                                    .backGroundColor)),
                                                    child: Center(
                                                      child: CustomText(
                                                          text: controller
                                                              .productDetail
                                                              .value
                                                              .product!
                                                              .boxes![index]),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                  SizedBox(
                                    height: screenWidth(20),
                                  ),
                                  controller.productDetail.value.product!
                                              .colors !=
                                          null
                                      ? controller.productDetail.value.product!
                                                  .colors!.length ==
                                              0
                                          ? SizedBox()
                                          : CustomText(
                                              text:
                                                  "Color : ${controller.selectedColor.value == -1 ? "" : controller.productDetail.value.product!.colors![controller.selectedColor.value].name} ",
                                              styleType: TextStyleType.SUBTITLE,
                                            )
                                      : SizedBox(),
                                  SizedBox(
                                    height: screenWidth(30),
                                  ),
                                  controller.productDetail.value.product!
                                              .colors ==
                                          null
                                      ? SizedBox()
                                      : Container(
                                          width: screenWidth(1),
                                          height: screenWidth(8),
                                          child: ListView.separated(
                                            separatorBuilder: (context, index) {
                                              return SizedBox(
                                                width: screenWidth(20),
                                              );
                                            },
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: controller.productDetail
                                                .value.product!.colors!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Obx(
                                                () => InkWell(
                                                  onTap: () {
                                                    controller
                                                        .selectColor(index);
                                                  },
                                                  child: Container(
                                                    height: screenWidth(11),
                                                    width: screenWidth(11),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: convertColorStringToColor(
                                                            controller
                                                                    .productDetail
                                                                    .value
                                                                    .product!
                                                                    .colors![
                                                                        index]
                                                                    .color ??
                                                                "")),
                                                    child: Stack(children: [
                                                      controller.selectedColor
                                                                  .value !=
                                                              index
                                                          ? SizedBox()
                                                          : Center(
                                                              child: Container(
                                                                width:
                                                                    screenWidth(
                                                                        14),
                                                                height:
                                                                    screenWidth(
                                                                        14),
                                                                padding: EdgeInsets.all(
                                                                    screenWidth(
                                                                        60)),
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: AppColors
                                                                            .whiteColor,
                                                                        width: screenWidth(
                                                                            screenWidth(1)))),
                                                                child:
                                                                    SvgPicture
                                                                        .asset(
                                                                  "assets/images/svgs/icon_select.svg",
                                                                  width:
                                                                      screenWidth(
                                                                          24),
                                                                  height:
                                                                      screenWidth(
                                                                          24),
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                              ),
                                                            ),
                                                    ]),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                  SizedBox(
                                    height: screenWidth(20),
                                  ),
                                  Container(
                                    height: screenWidth(screenWidth(1)),
                                    color: AppColors.grayColorTwo,
                                    width: screenWidth(1),
                                  ),
                                  SizedBox(
                                    height: screenWidth(20),
                                  ),
                                  CustomText(
                                    text: tr("key_description"),
                                    styleType: TextStyleType.SUBTITLE,
                                  ),
                                  SizedBox(
                                    height: screenWidth(25),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.readMore.value =
                                          !controller.readMore.value;
                                    },
                                    child: Obx(
                                      () => new RichText(
                                        text: new TextSpan(
                                          // Note: Styles for TextSpans must be explicitly defined.
                                          // Child text spans will inherit styles from parent
                                          style: new TextStyle(
                                            fontSize: screenWidth(22),
                                            color: AppColors.grayColorOne,
                                          ),
                                          children: <TextSpan>[
                                            new TextSpan(
                                                text: controller
                                                        .productDetail
                                                        .value
                                                        .product!
                                                        .descriptionMain ??
                                                    ""),
                                            new TextSpan(
                                                text: controller.readMore.value
                                                    ? ""
                                                    : (" " +
                                                        tr("key_read_more") +
                                                        ". . ."),
                                                style: new TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColors.blackColor)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenWidth(25),
                                  ),
                                  Obx(() => controller.readMore.value
                                      ? CustomText(text: tr("key_benefits"))
                                      : SizedBox()),
                                  SizedBox(
                                    height: screenWidth(25),
                                  ),
                                  Obx(() => controller.readMore.value
                                      ? ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: controller.benefits.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return ListTile(
                                                minLeadingWidth:
                                                    screenWidth(12),
                                                titleAlignment:
                                                    ListTileTitleAlignment.top,
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                leading: Container(
                                                  padding: EdgeInsets.all(
                                                      screenWidth(60)),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors
                                                          .grayColorTwo),
                                                  width: screenWidth(12),
                                                  height: screenWidth(12),
                                                  child: SvgPicture.asset(
                                                    "assets/images/svgs/icon_select_black.svg",
                                                    width: screenWidth(24),
                                                    height: screenWidth(24),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                                title: Container(
                                                  child: CustomText(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    styleType:
                                                        TextStyleType.BODY,
                                                    text: controller
                                                        .benefits[index],
                                                    overflow:
                                                        TextOverflow.visible,
                                                  ),
                                                ));
                                          },
                                        )
                                      : SizedBox())
                                ],
                              ),
                      ),
              )
            ],
          ),
        ));
  }
}
