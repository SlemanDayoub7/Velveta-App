import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/about_us_view/about_us_view.dart';
import 'package:velveta_app/ui/views/address_view/address_view.dart';
import 'package:velveta_app/ui/views/contact_us_view/contact_us_view.dart';
import 'package:velveta_app/ui/views/edit_profile_view/edit_profile_view.dart';
import 'package:velveta_app/ui/views/main_view/profile_view/profile_controller.dart';
import 'package:velveta_app/ui/views/my_order_view/my_order_view.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  top: screenWidth(13),
                  left: screenWidth(25),
                  right: screenWidth(25)),
              child: CustomHeader(
                haveIconBack: false,
                haveLogo: false,
                typeOfHeader: TypeOfHeader.ONE,
                title: tr("key_user_profile"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenWidth(4),
                left: screenWidth(25),
                right: screenWidth(25)),
            child: RefreshIndicator(
              onRefresh: () async {
                profile.refresh();
              },
              child: ListView(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: screenWidth(20),
                  ),
                  Obx(
                    () => profile.userInfo.value != null
                        ? Padding(
                            padding: EdgeInsets.only(bottom: screenWidth(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: screenWidth(5),
                                  height: screenWidth(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: profile.selectedImage.value != null
                                          ? DecorationImage(
                                              image: FileImage(
                                                  profile.selectedImage.value!),
                                              fit: BoxFit.contain)
                                          : null),
                                  child: profile.selectedImage.value == null
                                      ? Icon(
                                          Icons.image,
                                          size: screenWidth(15),
                                        )
                                      : null,
                                ),
                                SizedBox(
                                  width: screenWidth(40),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text:
                                            (profile.userInfo.value.firstName ??
                                                "")),
                                    SizedBox(
                                      height: screenWidth(50),
                                    ),
                                    CustomText(
                                      text: profile.userInfo.value.email ?? "",
                                      styleType: TextStyleType.SMALL,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : SizedBox(),
                  ),
                  CustomText(
                    text: tr("key_my_account"),
                    textColor: AppColors.grayColorOne,
                  ),
                  SizedBox(
                    height: screenWidth(15),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            if (profile.checkIsLoggedIn())
                              myAccountList[index].onTap!();
                          },
                          child: Row(
                            children: [
                              CustomText(
                                text: tr(myAccountList[index].title!),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                "assets/images/svgs/icon_arrow.svg",
                                width: screenWidth(20),
                                height: screenWidth(20),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return SizedBox(
                          height: screenWidth(11),
                        );
                      },
                      itemCount: myAccountList.length),
                  SizedBox(
                    height: screenWidth(15),
                  ),
                  CustomText(
                    fontWeight: FontWeight.w500,
                    text: tr("key_support"),
                    textColor: AppColors.grayColorOne,
                  ),
                  SizedBox(
                    height: screenWidth(15),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            supportList[index].onTap!();
                          },
                          child: Row(
                            children: [
                              CustomText(
                                text: tr(supportList[index].title!),
                              ),
                              Spacer(),
                              SvgPicture.asset(
                                "assets/images/svgs/icon_arrow.svg",
                                width: screenWidth(20),
                                height: screenWidth(20),
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, i) {
                        return SizedBox(
                          height: screenWidth(11),
                        );
                      },
                      itemCount: supportList.length),
                  SizedBox(
                    height: screenWidth(15),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        "assets/images/svgs/instagram_logo.svg",
                        width: screenWidth(11),
                        height: screenWidth(11),
                      ),
                      SizedBox(
                        width: screenWidth(10),
                      ),
                      SvgPicture.asset(
                        "assets/images/svgs/facebook_logo.svg",
                        width: screenWidth(11),
                        height: screenWidth(11),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: screenWidth(screenWidth(20)),
                  ),
                  Obx(() => profile.isLoggedIn.value
                      ? CustomButton(
                          onPress: () {
                            profile.logOut();
                          },
                          foreColor: AppColors.whiteColor,
                          backColor: AppColors.blackColor,
                          title: tr("key_log_out"),
                        )
                      : CustomButton(
                          onPress: () {
                            profile.logIn();
                          },
                          foreColor: AppColors.whiteColor,
                          backColor: AppColors.blackColor,
                          title: tr("key_login"))),
                  SizedBox(
                    height: screenWidth(10),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Setting {
  String? title;
  Function? onTap;
  Setting({this.title, this.onTap});
}

List<Setting> myAccountList = [
  Setting(
    title: "key_edit_profile",
    onTap: () {
      Get.to(() => EditProfileView());
    },
  ),
  Setting(
      title: "key_my_location",
      onTap: () {
        Get.to(() => AddressView());
      }),
  Setting(
      title: "key_languages",
      onTap: () {
        Get.bottomSheet(
          Container(
            padding: EdgeInsets.all(screenWidth(25)),
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: [
                ...List.generate(profile.languages.length, (index) {
                  return Obx(
                    () => Padding(
                      padding: EdgeInsets.only(bottom: screenWidth(30)),
                      child: Row(
                        children: [
                          CustomText(text: profile.languages[index].name),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              profile.selectedLanguageIndex.value = index;
                            },
                            child: profile.selectedLanguageIndex.value == index
                                ? SvgPicture.asset(
                                    "assets/images/svgs/icon_selected_circle.svg",
                                    width: screenWidth(14),
                                    height: screenWidth(14),
                                  )
                                : SvgPicture.asset(
                                    "assets/images/svgs/icon_unselected_circle.svg",
                                    width: screenWidth(14),
                                    height: screenWidth(14),
                                  ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
                CustomButton(
                  title: tr("key_save"),
                  onPress: () {
                    profile.changeLanguage();
                  },
                )
              ],
            ),
          ),
          backgroundColor: AppColors.whiteColor,
        );
      }),
  Setting(
      title: "key_my_order",
      onTap: () {
        Get.to(() => MyOrderView());
      })
];
List<Setting> supportList = [
  Setting(
    title: "key_about_us",
    onTap: () {
      Get.to(() => AboutUsView());
    },
  ),
  Setting(
      title: "key_contact_us",
      onTap: () {
        Get.to(() => ContactUsView());
      }),
  Setting(title: "key_privacy_policy", onTap: () {}),
  Setting(title: "key_terms_of_service", onTap: () {})
];
