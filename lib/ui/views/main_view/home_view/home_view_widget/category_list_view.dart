import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../../../core/translation/app_translation.dart';
import '../../../../shared/colors.dart';
import '../../../../shared/custom_widgets/custom_text.dart';
import '../../../../shared/custom_widgets/cutsom_button.dart';
import '../../../../shared/utils.dart';
import '../home_controller.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
    required this.controller,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: screenWidth(25), right: screenWidth(25)),
          child: CustomText(
            text: tr("key_categories"),
            styleType: TextStyleType.SUBTITLE,
          ),
        ),
        SizedBox(
          height: screenWidth(25),
        ),
        Container(
          margin:
              EdgeInsets.only(left: screenWidth(25), right: screenWidth(25)),
          width: screenWidth(1),
          height: screenWidth(9),
          child: AnimationLimiter(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: screenWidth(20),
                );
              },
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1000),
                  child: SlideAnimation(
                    horizontalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Obx(
                        () => CustomButton(
                          textStyleType: TextStyleType.BODY,
                          height: screenWidth(9),
                          onPress: () {
                            controller.selectCategory(index);
                          },
                          isFlexible: true,
                          title: controller.categories[index],
                          backColor: controller.selectedCategory.value == index
                              ? AppColors.blackColor
                              : AppColors.whiteColor,
                          foreColor: controller.selectedCategory.value == index
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: controller.categories.length,
            ),
          ),
        ),
      ],
    );
  }
}
