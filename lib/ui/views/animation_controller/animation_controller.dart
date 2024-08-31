// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FadeTransitionController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late CurvedAnimation _curve;

  @override
  void onInit() {
    super.onInit();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_curve);
  }

  @override
  void onClose() {
    _controller.dispose();
    super.onClose();
  }
}
