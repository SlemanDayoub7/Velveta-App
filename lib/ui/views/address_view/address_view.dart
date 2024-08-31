import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:velveta_app/core/data/models/address_model.dart';
import 'package:velveta_app/core/enums/header_type.dart';
import 'package:velveta_app/core/translation/app_translation.dart';
import 'package:velveta_app/ui/shared/colors.dart';
import 'package:velveta_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:velveta_app/ui/shared/custom_widgets/cutsom_button.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_header.dart';
import 'package:velveta_app/ui/shared/shared_widgets/custom_shimmer.dart';
import 'package:velveta_app/ui/shared/utils.dart';
import 'package:velveta_app/ui/views/add_new_address_view/add_new_address_view.dart';
import 'package:velveta_app/ui/views/address_view/address_controller.dart';

class AddressView extends StatelessWidget {
  AddressView({super.key});
  AddressController controller = Get.put(AddressController());
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
                haveLogo: false,
                typeOfHeader: TypeOfHeader.ONE,
                title: tr("key_address"),
              ),
            ),
          ),
          Obx(() => Padding(
                padding: EdgeInsets.only(
                    top: screenWidth(4),
                    bottom: screenWidth(20),
                    left: screenWidth(25),
                    right: screenWidth(25)),
                child: RefreshIndicator(
                  color: AppColors.blackColor,
                  onRefresh: () async {
                    await controller.getAllAddress();
                  },
                  child: controller.isAdderssLoading.value
                      ? CustomShimmer(
                          widget: ListView.separated(
                              itemBuilder: (context, index) {
                                return Container(
                                  color: AppColors.whiteColor,
                                  height: screenWidth(6.5),
                                  width: screenWidth(1),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: screenWidth(30),
                                );
                              },
                              itemCount: 5))
                      : ListView(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            controller.addressList.value.userShippingAddress ==
                                    null
                                ? SizedBox()
                                : controller.addressList.value
                                            .userShippingAddress!.length ==
                                        0
                                    ? SizedBox()
                                    : ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: screenWidth(30),
                                          );
                                        },
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: controller.addressList.value
                                            .userShippingAddress!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Obx(
                                            () => CustomLocation(
                                              onTap: () {
                                                controller.selectedLocation
                                                    .value = index;
                                              },
                                              isSelected: controller
                                                      .selectedLocation.value ==
                                                  index,
                                              location: controller
                                                  .addressList
                                                  .value
                                                  .userShippingAddress![index],
                                              index: index,
                                            ),
                                          );
                                        },
                                      ),
                            SizedBox(
                              height: screenWidth(9),
                            ),
                            DottedBorder(
                                dashPattern: [screenWidth(17)],
                                borderType: BorderType.RRect,
                                strokeWidth: screenWidth(screenWidth(1)),
                                child: CustomButton(
                                  onPress: () {
                                    Get.to(() => AddNewAddressView());
                                  },
                                  title: tr("key_add_new_address"),
                                  isDotted: true,
                                  foreColor: AppColors.blackColor,
                                  backColor: AppColors.whiteColor,
                                )),
                            SizedBox(
                              height: screenWidth(20),
                            ),
                          ],
                        ),
                ),
              ))
        ],
      ),
    );
  }
}

class CustomLocation extends StatelessWidget {
  const CustomLocation({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.location,
    required this.index,
  });
  final UserShippingAddress location;
  final Function onTap;
  final bool isSelected;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenWidth(6.5),
      width: screenWidth(1),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/svgs/icon_location.svg",
                width: screenWidth(14), height: screenWidth(14)),
            SizedBox(
              width: screenWidth(20),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: tr("key_location") + " " + (index + 1).toString()),
                  SizedBox(
                    height: screenWidth(70),
                  ),
                  CustomText(
                    text: (location.city ?? "") +
                        " , " +
                        (location.state ?? "") +
                        " , " +
                        (location.addressLine ?? "") +
                        " , " +
                        (location.zipCode ?? ""),
                    textColor: AppColors.grayColorOne,
                    styleType: TextStyleType.SMALL,
                  )
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                onTap();
              },
              child: isSelected
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
  }
}
