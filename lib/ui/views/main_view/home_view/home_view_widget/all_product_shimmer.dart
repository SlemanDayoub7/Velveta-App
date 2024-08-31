import 'package:flutter/material.dart';

import '../../../../shared/colors.dart';
import '../../../../shared/custom_widgets/cutsom_button.dart';
import '../../../../shared/shared_widgets/custom_shimmer.dart';
import '../../../../shared/utils.dart';

class AllProductShimmer extends StatelessWidget {
  const AllProductShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
        widget: Padding(
            padding:
                EdgeInsets.only(left: screenWidth(25), right: screenWidth(25)),
            child: Scrollbar(
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: EdgeInsets.all(screenWidth(25)),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: screenWidth(screenWidth(1)),
                            color: AppColors.grayColorTwo),
                      ),
                      width: screenWidth(1),
                      height: screenWidth(1.1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: screenWidth(2.5),
                            width: screenWidth(1),
                            child: Stack(
                              children: [
                                Container(
                                  width: screenWidth(1),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(width: screenWidth(200))),
                                  height: screenWidth(2.5),
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.favorite_sharp,
                                      size: screenWidth(10),
                                    ),
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: screenWidth(5),
                            height: screenWidth(20),
                            color: AppColors.whiteColor,
                          ),
                          Container(
                            width: screenWidth(2),
                            color: AppColors.whiteColor,
                            height: screenWidth(20),
                          ),
                          CustomButton(
                            onPress: () {},
                            height: screenWidth(9),
                            title: "",
                          )
                        ],
                      ),
                    );
                  }),
                  separatorBuilder: ((context, index) {
                    return SizedBox(
                      height: screenWidth(25),
                    );
                  }),
                  itemCount: 10),
            )));
  }
}
