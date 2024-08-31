import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:velveta_app/core/enums/message_type.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/utils.dart';

class CustomToast {
  static showMeassge({
    required String message,
    MessageType messageType = MessageType.INFO,
  }) {
    BotToast.showCustomText(
        duration: Duration(seconds: 2),
        toastBuilder: (value) {
          return Container(
            decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(width: 1, color: AppColors.grayColorOne)),
            padding: EdgeInsets.all(screenWidth(40)),
            child: CustomText(
              textAlign: TextAlign.center,
              text: message,
              overflow: TextOverflow.visible,
              styleType: TextStyleType.SMALL,
            ),
          );
        });
  }
}
