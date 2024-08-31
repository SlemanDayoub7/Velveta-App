import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class CustomStars extends StatelessWidget {
  final double rate, size;
  const CustomStars({super.key, required this.rate, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenWidth(10),
      child: RatingBarIndicator(
          unratedColor: AppColors.grayColorOne,
          itemSize: size,
          itemCount: 5,
          rating: rate,
          itemBuilder: (context, i) {
            return Icon(
              Icons.star,
              color: AppColors.goldColor,
              size: size,
            );
          }

          // }) RatingBar.builder(
          //     initialRating: rate,
          //     minRating: 1,
          //     direction: Axis.horizontal,
          //     allowHalfRating: true,
          //     itemCount: 5,
          //     itemSize: size,
          //     itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          //     itemBuilder: (context, _) => Icon(
          //           Icons.star,
          //           color: AppColors.goldColor,
          //         ),
          //     onRatingUpdate: (rating) {
          //       print(rating);
          //     }
          ),
    );
  }
}
