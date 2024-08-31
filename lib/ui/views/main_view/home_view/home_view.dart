import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_shimmer.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/main_view/home_view/home_controller.dart';
import 'package:velveta_app/ui/views/main_view/home_view/home_view_widget/category_list_shimmer.dart';
import 'home_view_widget/all_product_list.dart';
import 'home_view_widget/all_product_shimmer.dart';
import 'home_view_widget/category_list_view.dart';
import 'home_view_widget/header_home.dart';
import 'home_view_widget/home_slider.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Stack(
        children: [
          HeaderHome(
            controller: controller,
          ),
          Padding(
            padding: EdgeInsets.only(top: screenWidth(3)),
            child: RefreshIndicator(
              color: AppColors.blackColor,
              onRefresh: () async {
                await controller.getData();
              },
              child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  Obx(() => controller.isSliderLoading.value
                      ? CustomShimmer(
                          widget: Container(
                          width: screenWidth(1),
                          height: screenWidth(2),
                          color: AppColors.whiteColor,
                        ))
                      : controller.slider.value.slider == null
                          ? SizedBox()
                          : HomeSlider(controller: controller)),
                  SizedBox(
                    height: screenWidth(25),
                  ),
                  Obx(() => controller.isProductLoading.value
                      ? CategoryListShimmer()
                      : controller.allProducts.value.products == null
                          ? SizedBox()
                          : CategoryListView(controller: controller)),
                  SizedBox(
                    height: screenWidth(25),
                  ),
                  Obx(() => controller.isProductLoading.value
                      ? AllProductShimmer()
                      : controller.allProducts.value.products == null
                          ? SizedBox()
                          : AllProductListView(controller: controller)),
                  SizedBox(
                    height: screenWidth(25),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
