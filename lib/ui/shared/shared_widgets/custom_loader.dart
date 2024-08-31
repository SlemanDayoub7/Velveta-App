import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SpinKitWaveSpinner(
        trackColor: AppColors.grayColorTwo,
        size: screenWidth(2),
        curve: Curves.easeInOut,
        color: AppColors.blackColor,
        child: Image.asset(
          "assets/images/pngs/logo.png",
          width: screenWidth(2),
          height: screenWidth(2),
          filterQuality: FilterQuality.high,
          fit: BoxFit.contain,
        ),
      )),
    );
  }
}
