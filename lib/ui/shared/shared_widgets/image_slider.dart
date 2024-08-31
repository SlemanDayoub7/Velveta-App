import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_shimmer.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/full_image_view/full_image_view.dart';
import 'package:velveta_app/ui/views/proudct_view/product_controller.dart';

class ImageSlider extends StatelessWidget {
  final List<String>? imageUrls;

  final Function? onChanged;
  ImageSlider({super.key, this.imageUrls, this.onChanged});
  ProductController controller = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => SizedBox.expand(
            child: InkWell(
                onTap: () {
                  Get.to(() => FullImageView(
                      imageUrl: baseImageUrl +
                          imageUrls![controller.currentImage.value]));
                },
                child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return SpinKitSpinningLines(
                      duration: Duration(seconds: 2),
                      color: AppColors.blackColor,
                      size: screenWidth(7),
                    );
                  },
                  imageUrl:
                      baseImageUrl + imageUrls![controller.currentImage.value],
                  fit: BoxFit.fill,
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
              margin: EdgeInsets.only(bottom: screenWidth(40)),
              width: screenWidth(1.5),
              height: screenWidth(7),
              child: CarouselSlider(
                options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      controller.currentImage.value = index;
                    },
                    scrollPhysics: BouncingScrollPhysics(),
                    autoPlay: false,
                    aspectRatio: 1,
                    height: screenWidth(1.3),
                    viewportFraction: 0.3),
                items: [
                  ...List.generate(imageUrls!.length, (index) {
                    return imageUrls != null
                        ? InkWell(
                            onTap: () {
                              Get.to(() => FullImageView(
                                  imageUrl: baseImageUrl + imageUrls![index]));
                            },
                            child: Container(
                              margin: EdgeInsets.only(left: screenWidth(50)),
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         width: 1, color: AppColors.blackColor)),
                              height: screenWidth(1.3),
                              width: screenWidth(1),
                              child: Image.network(
                                baseImageUrl + imageUrls![index],
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox();
                                },
                              ),
                            ),
                          )
                        : SizedBox();
                  })
                ],
              )),
        ),
      ],
    );
  }
}
