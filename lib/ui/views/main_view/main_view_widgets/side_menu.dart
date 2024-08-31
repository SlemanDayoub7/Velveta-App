import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  List<String> text = [
    "Home",
    "Order",
    "Settings",
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width * 0.8,
        color: Colors.white,
        child: Column(children: [
          InkWell(
              onTap: () {},
              child: CustomText(
                text: "Logout",
                styleType: TextStyleType.SUBTITLE,
              ))
        ]));
  }
}
