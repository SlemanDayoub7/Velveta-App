import 'package:flutter/material.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_shimmer.dart';

import '../../../../shared/custom_widgets/cutsom_button.dart';
import '../../../../shared/utils.dart';

class CategoryListShimmer extends StatelessWidget {
  const CategoryListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
        widget: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: AppColors.whiteColor,
          width: screenWidth(4),
          height: screenWidth(20),
          margin:
              EdgeInsets.only(left: screenWidth(25), right: screenWidth(25)),
        ),
        SizedBox(
          height: screenWidth(25),
        ),
        Container(
          margin:
              EdgeInsets.only(left: screenWidth(25), right: screenWidth(25)),
          width: screenWidth(1),
          height: screenWidth(9),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                width: screenWidth(20),
              );
            },
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CustomButton(
                width: screenWidth(3),
              );
            },
            itemCount: 3,
          ),
        ),
      ],
    ));
  }
}
