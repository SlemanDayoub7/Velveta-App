import 'package:flutter/material.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/views/main_view/cart_view/cart_view.dart';
import 'package:velveta_app/ui/views/main_view/favortie_view/favortie_view.dart';
import 'package:velveta_app/ui/views/main_view/home_view/home_view.dart';
import 'package:velveta_app/ui/views/main_view/main_view_widgets/bottom_navigation_bar.dart';
import 'package:velveta_app/ui/views/main_view/profile_view/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  PageController controller = PageController();
  BottomNavigationEnum selecte = BottomNavigationEnum.HOME;

  GlobalKey<ScaffoldState> scafolldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      key: scafolldKey,
      bottomNavigationBar: CustomBottmNavigation(
        onTap: (View, ix) {
          selecte = View;
          setState(() {});
          controller.jumpToPage(ix);
          //! here notify onTap in navitem
        },
        selectedView: selecte,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [HomeView(), FavoriteView(), CartView(), ProfileView()],
      ),
    );
  }
}
