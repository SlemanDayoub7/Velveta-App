import 'package:flutter/material.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_shimmer.dart';

import '../../../../shared/colors.dart';
import '../../../../shared/utils.dart';

class FavoriteShimmer extends StatelessWidget {
  const FavoriteShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
        widget: ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: screenWidth(30),
        );
      },
      itemBuilder: (context, index) {
        return Container(
          key: key,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
          ),
          width: screenWidth(1),
          height: screenWidth(3),
        );
      },
      itemCount: 4,
    ));
  }
}
