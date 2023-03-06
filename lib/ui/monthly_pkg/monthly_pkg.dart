import 'package:flash_customer/ui/monthly_pkg/plan.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/colors.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/spaces.dart';

class MonthlyPkg extends StatelessWidget {
  const MonthlyPkg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Monthly pkg'),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
        child: Column(
          children: [
            Row(
              children: [
                CustomContainer(
                  backgroundColor: Color(0xFFCCCCCC),
                  width: 162,
                  height: 112,
                  radiusCircular: 6,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/new_car.svg',
                      ),
                      horizontalSpace(8),
                      TextWidget(
                        text: 'New Car',
                        fontWeight: MyFontWeight.semiBold,
                        textSize: MyFontSize.size18,
                      )
                    ],
                  ),
                ),
                horizontalSpace(21),
                CustomContainer(
                  backgroundColor: Color(0xFFCCCCCC),
                  width: 162,
                  height: 112,
                  radiusCircular: 6,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/svg/my_vehicles.svg',
                      ),
                      horizontalSpace(8),
                      TextWidget(
                        text: 'My Vehicles',
                        fontWeight: MyFontWeight.semiBold,
                        textSize: MyFontSize.size18,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpace(56),
            Row(
              children: [
                TextWidget(
                    text: 'Select Manufacturer',
                    textSize: MyFontSize.size18,
                    fontWeight: MyFontWeight.medium),
                horizontalSpace(6),
                TextWidget(
                  text: '(Required)',
                  textSize: MyFontSize.size8,
                  fontWeight: MyFontWeight.regular,
                  color: AppColor.lightGrey,
                ),
              ],
            ),
            verticalSpace(10),
            // CustomSizedBox(
            //   height: 40,
            //   width: double.infinity,
            // ),
            verticalSpace(24),
            Row(
              children: [
                TextWidget(
                    text: 'Model',
                    textSize: MyFontSize.size18,
                    fontWeight: MyFontWeight.medium),
                horizontalSpace(6),
                TextWidget(
                  text: '(Required)',
                  textSize: MyFontSize.size8,
                  fontWeight: MyFontWeight.regular,
                  color: AppColor.lightGrey,
                ),
              ],
            ),
            verticalSpace(10),
            // CustomSizedBox(
            //   height: 40,
            //   width: double.infinity,
            //   child: DefaultFormField(
            //     hintText: 'Enter Name',
            //     fillColor: AppColor.babyBlue,
            //     filled: true,
            //     textColor: AppColor.grey,
            //     textSize: MyFontSize.size15,
            //     fontWeight: MyFontWeight.medium,
            //   ),
            // ),
            verticalSpace(72),
            DefaultButton(
              height: 48,
              width: double.infinity,
              fontWeight: MyFontWeight.bold,
              text: 'Next',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return AlertDialog(
                    //   content: Padding(
                    //     padding: onlyEdgeInsets(top: 40,bottom: 32, end: 38, start: 38),
                    //     child: TextWidget(
                    //       textAlign: TextAlign.center,
                    //       text: 'Management will edit vehicle size as price will depends on the vehicle size',
                    //       textSize: MyFontSize.size17,
                    //       fontWeight: MyFontWeight.semiBold,
                    //     ),
                    //   ),
                    //   actions: [
                    //     Padding(
                    //       padding: onlyEdgeInsets(top: 0,bottom: 40, end: 48, start: 48),
                    //       child: DefaultButton(
                    //         width: 225,
                    //         height: 32,
                    //         text: 'Ok',
                    //         onPressed: (){
                    //           Navigator.pop(context);
                    //           },
                    //       ),
                    //     ),
                    //
                    //   ],
                    // );
                    return AlertDialog(
                      title: TextWidget(
                        textAlign: TextAlign.center,
                        text: 'The packages is not available now',
                        textSize: MyFontSize.size17,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      content: Padding(
                        padding: symmetricEdgeInsets(horizontal: 60),
                        child: TextWidget(
                          textAlign: TextAlign.center,
                          text: 'Please try again later or contact us for help',
                          textSize: MyFontSize.size16,
                          fontWeight: MyFontWeight.medium,
                          color: Color(0xFF9F9F9F),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding:
                              onlyEdgeInsets(bottom: 40, end: 48, start: 48),
                          child: Column(
                            children: [
                              DefaultButton(
                                width: 225,
                                height: 32,
                                text: 'Back',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              verticalSpace(12),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, MonthlyPlans());
                                  },
                                  child: TextWidget(
                                    text: 'Contact us',
                                    textSize: MyFontSize.size14,
                                    fontWeight: MyFontWeight.semiBold,
                                    color: Color(0xFF7A7A7A),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
