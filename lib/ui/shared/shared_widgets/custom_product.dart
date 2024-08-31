import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/all_product_model.dart';
import 'package:velveta_app/core/data/models/cart_model.dart';

import 'package:velveta_app/core/enums/product_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/proudct_view/proudct_view.dart';

class CustomProduct extends StatelessWidget {
  final Products? product;
  final CartModel? cartModel;
  final ProductType? productType;
  final Function? onPress;
  final Function? onAddToCart;
  final bool? isInFavorite;
  final double? bottomMargin;
  final Function? addToFavorite;

  const CustomProduct({
    super.key,
    this.productType,
    this.onPress,
    this.addToFavorite,
    this.isInFavorite,
    this.product,
    this.bottomMargin,
    this.cartModel,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return productType == ProductType.HOME
        ? Container(
            padding: EdgeInsets.all(screenWidth(25)),
            decoration: BoxDecoration(
              border: Border.all(
                  width: screenWidth(screenWidth(1)),
                  color: AppColors.grayColorTwo),
            ),
            width: screenWidth(1),
            height: screenWidth(1.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenWidth(2.5),
                  width: screenWidth(1),
                  child: Stack(
                    children: [
                      InkWell(
                          onTap: () {
                            onPress!();
                          },
                          child: CachedNetworkImage(
                            filterQuality: FilterQuality.high,
                            imageUrl: baseImageUrl + (product!.imageMain ?? ""),
                            width: screenWidth(1),
                            fit: BoxFit.fill,
                            height: screenWidth(2.5),
                            errorWidget: (context, error, stackTrace) {
                              return SizedBox();
                            },
                          )),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            margin: EdgeInsets.only(
                                top: screenWidth(60), right: screenWidth(60)),
                            padding: EdgeInsets.all(screenWidth(50)),
                            height: screenWidth(9),
                            width: screenWidth(9),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.blackColor),
                            child: Center(
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  addToFavorite!();
                                },
                                icon: Icon(
                                  isInFavorite!
                                      ? Icons.favorite_sharp
                                      : Icons.favorite_outline,
                                  size: screenWidth(15),
                                ),
                                color: AppColors.whiteColor,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {
                      onPress!();
                    },
                    child:
                        CustomText(text: product!.title ?? "", max_lines: 1)),
                InkWell(
                  onTap: () {
                    onPress!();
                  },
                  child: CustomText(
                      textColor: AppColors.grayColorOne,
                      styleType: TextStyleType.SMALL,
                      max_lines: 2,
                      text: (product!.descriptionMain ?? "")),
                ),
                CustomButton(
                  onPress: () {
                    Get.to(() => ProductView(product: product!));
                  },
                  height: screenWidth(9),
                  title: tr("key_add_to_cart"),
                )
              ],
            ),
          )
        : Container(
            key: key,
            decoration: BoxDecoration(color: AppColors.whiteColor, boxShadow: [
              (productType == ProductType.FAVORITE ||
                      productType == ProductType.ORDER)
                  ? BoxShadow(
                      offset: Offset(0, 1),
                      color: AppColors.grayColorTwo,
                      blurRadius: screenWidth(100))
                  : BoxShadow(color: AppColors.whiteColor)
            ]),
            width: screenWidth(1),
            margin: EdgeInsets.only(bottom: bottomMargin ?? screenWidth(40)),
            height: screenWidth(3),
            child: Stack(
              children: [
                productType == ProductType.CART
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            onPress!();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: screenWidth(50)),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 0),
                                              blurRadius: screenWidth(170),
                                              color: AppColors.grayColorOne)
                                        ]),
                                    width: screenWidth(13),
                                    height: screenWidth(13),
                                    child: Center(
                                      child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            cartService.changeQty(
                                                model: cartModel!,
                                                incress: true);
                                          },
                                          icon: Icon(Icons.add,
                                              color: AppColors.grayColorOne,
                                              size: screenWidth(17))),
                                    ),
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.blackColor,
                                          boxShadow: []),
                                      width: screenWidth(13),
                                      height: screenWidth(13),
                                      child: Center(
                                          child: CustomText(
                                        styleType: TextStyleType.SMALL,
                                        text: cartModel!.qty.toString(),
                                        textColor: AppColors.whiteColor,
                                      ))),
                                  cartModel!.qty != 1
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.whiteColor,
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(0, 0),
                                                    blurRadius:
                                                        screenWidth(170),
                                                    color:
                                                        AppColors.grayColorOne)
                                              ]),
                                          width: screenWidth(13),
                                          height: screenWidth(13),
                                          child: Center(
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                                  cartService.changeQty(
                                                      model: cartModel!,
                                                      incress: false);
                                                },
                                                icon: Icon(Icons.remove,
                                                    color:
                                                        AppColors.grayColorOne,
                                                    size: screenWidth(17))),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () {
                                            cartService
                                                .removeFromCartList(cartModel!);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius:
                                                          screenWidth(170),
                                                      color: AppColors
                                                          .grayColorOne)
                                                ]),
                                            width: screenWidth(13),
                                            height: screenWidth(13),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                "assets/images/svgs/icon_recycle.svg",
                                                width: screenWidth(18),
                                                height: screenWidth(18),
                                              ),
                                            ),
                                          ),
                                        )
                                ]),
                          ),
                        ),
                      )
                    : SizedBox(),
                productType == ProductType.FAVORITE
                    ? Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth(50), top: screenWidth(50)),
                          child: InkWell(
                            onTap: () {
                              addToFavorite!();
                            },
                            child: SvgPicture.asset(
                              "assets/images/svgs/icon_favorite_selected.svg",
                              width: screenWidth(22),
                              height: screenWidth(22),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
                InkWell(
                  onTap: () {
                    onPress!();
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                        imageUrl: baseImageUrl +
                            ((productType == ProductType.CART)
                                ? cartModel!.productModel!.imageMain!
                                : (product!.imageMain ?? "")),
                        fit: BoxFit.cover,
                        errorWidget: (context, error, stackTrace) {
                          return SizedBox(
                            width: screenWidth(3.6),
                            height: screenWidth(3.6),
                          );
                        },
                        width: screenWidth(3.6),
                        height: screenWidth(3.6),
                      ),
                      SizedBox(
                        width: screenWidth(30),
                      ),
                      SizedBox(
                        width: screenWidth(2.4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(
                              height: screenWidth(200),
                            ),
                            CustomText(
                              overflow: TextOverflow.ellipsis,
                              text: (productType == ProductType.CART)
                                  ? cartModel!.productModel!.title ?? ""
                                  : (product!.title ?? ""),
                              styleType: TextStyleType.SUBTITLE,
                            ),
                            SizedBox(
                              height: screenWidth(80),
                            ),
                            !(productType == ProductType.CART)
                                ? CustomText(
                                    text: product!.material ?? "",
                                    fontWeight: FontWeight.normal,
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: (productType == ProductType.CART)
                                  ? screenWidth(80)
                                  : 0,
                            ),
                            (productType == ProductType.CART)
                                ? CustomText(
                                    text: (tr("key_shape") +
                                        " : " +
                                        (cartModel!.boxName ?? "")),
                                    fontWeight: FontWeight.normal,
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: (productType == ProductType.CART)
                                  ? screenWidth(80)
                                  : 0,
                            ),
                            (productType == ProductType.CART)
                                ? CustomText(
                                    text: (tr("key_color") +
                                        " : " +
                                        (cartModel!.colorName ?? "")),
                                    fontWeight: FontWeight.normal,
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: screenWidth(80),
                            ),
                            CustomText(
                              text: (productType == ProductType.CART)
                                  ? cartModel!.totals.toString()
                                  : product!.price.toString(),
                              styleType: TextStyleType.SUBTITLE,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
