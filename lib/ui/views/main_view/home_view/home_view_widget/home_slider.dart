import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/colors.dart';
import '../../../../shared/utils.dart';
import '../home_controller.dart';

class HomeSlider extends StatelessWidget {
  const HomeSlider({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth(1),
      height: screenWidth(2),
      child: Stack(
        children: [
          Container(
              width: screenWidth(1),
              height: screenWidth(2),
              child: CarouselSlider(
                carouselController: controller.carouselController,
                options: CarouselOptions(
                    onPageChanged: (index, reason) {},
                    scrollPhysics: BouncingScrollPhysics(),
                    autoPlay: true,
                    aspectRatio: 1,
                    height: screenWidth(2),
                    viewportFraction: 1),
                items: [
                  ...List.generate(controller.slider.value.slider!.length,
                      (index) {
                    return Container(
                        height: screenWidth(1.3),
                        width: screenWidth(1),
                        child: CachedNetworkImage(
                          imageUrl: baseImageUrl +
                              controller.slider.value.slider![index].images![0],
                          width: screenWidth(1),
                          height: screenWidth(1.3),
                          fit: BoxFit.fill,
                          placeholder: (context, url) {
                            return SpinKitSpinningLines(
                              duration: Duration(seconds: 2),
                              color: AppColors.blackColor,
                              size: screenWidth(7),
                            );
                          },
                        ));
                  })
                ],
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                controller.moveToLeft();
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: screenWidth(35), bottom: screenWidth(35)),
                width: screenWidth(20),
                height: screenWidth(10),
                color: AppColors.blackColor.withOpacity(0.5),
                child: SvgPicture.asset(
                  "assets/images/svgs/icon_silder_move_left.svg",
                  width: screenWidth(40),
                  height: screenWidth(40),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                controller.moveToRight();
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: screenWidth(35), bottom: screenWidth(35)),
                width: screenWidth(20),
                height: screenWidth(10),
                color: AppColors.blackColor.withOpacity(0.5),
                child: SvgPicture.asset(
                  "assets/images/svgs/icon_silder_move_right.svg",
                  width: screenWidth(40),
                  height: screenWidth(40),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
