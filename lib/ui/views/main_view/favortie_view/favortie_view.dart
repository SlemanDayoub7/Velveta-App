import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/enums/product_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_loader.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_product.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_shimmer.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/main_view/favortie_view/favorite_view_widgets/favorite_shimmer.dart';
import 'package:velveta_app/ui/views/main_view/favortie_view/favortie_controller.dart';
import 'package:velveta_app/ui/views/proudct_view/proudct_view.dart';

class FavoriteView extends StatelessWidget {
  FavoriteView({super.key});

  FavoriteController controller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                haveIconBack: false,
                typeOfHeader: TypeOfHeader.ONE,
                title: tr("key_favorite"),
              ),
            ),
          ),
          SizedBox(
            height: screenWidth(20),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenWidth(4),
                bottom: screenWidth(5.1),
                left: screenWidth(25),
                right: screenWidth(25)),
            child: Obx(
              () => RefreshIndicator(
                color: AppColors.blackColor,
                onRefresh: () async {
                  controller.getData();
                },
                child: ListView(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    controller.isLoading.value
                        ? FavoriteShimmer()
                        : AnimationLimiter(
                            child: ReorderableListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, index) {
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  key: Key(index.toString()),
                                  duration: const Duration(milliseconds: 1000),
                                  child: SlideAnimation(
                                      horizontalOffset: 50.0,
                                      child: FadeInAnimation(
                                          child: CustomProduct(
                                        onPress: () {
                                          Get.to(() => ProductView(
                                                product: controller
                                                    .favoriteList[index],
                                              ));
                                        },
                                        bottomMargin: (index ==
                                                controller.favoriteList.length -
                                                    1)
                                            ? 0
                                            : null,
                                        addToFavorite: () {
                                          controller.manageFavorite(
                                              item: controller
                                                  .favoriteList[index]);
                                        },
                                        key: Key(index.toString()),
                                        product: controller.favoriteList[index],
                                        productType: ProductType.FAVORITE,
                                      ))));
                            }),
                            itemCount: controller.favoriteList.length,
                            onReorder: (oldIndex, newIndex) {
                              controller.reorderFavorites(oldIndex, newIndex);
                            },
                          )),
                    SizedBox(
                      height: screenWidth(3),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
