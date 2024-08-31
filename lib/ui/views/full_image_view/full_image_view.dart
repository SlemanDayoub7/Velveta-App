import 'package:flutter/material.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class FullImageView extends StatelessWidget {
  final String imageUrl;
  const FullImageView({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenWidth(13),
                  left: screenWidth(25),
                  right: screenWidth(25)),
              child: CustomHeader(
                typeOfHeader: TypeOfHeader.ONE,
                haveLogo: false,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: screenWidth(1),
              width: screenWidth(1),
              child: InteractiveViewer(
                child: Image.network(
                  imageUrl,
                ),
                boundaryMargin: EdgeInsets.all(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
