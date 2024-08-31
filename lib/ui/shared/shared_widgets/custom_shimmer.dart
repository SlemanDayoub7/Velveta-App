import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final Widget widget;

  const CustomShimmer({
    super.key,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: widget, direction: ShimmerDirection.ltr,
      baseColor: Colors.grey.withOpacity(0.1), // The base color of the shimmer
      highlightColor:
          Colors.grey.withOpacity(0.2), // The highlight color of the shimmer
      // The direction of the shimmer
      loop: -1,
    );
  }
}
