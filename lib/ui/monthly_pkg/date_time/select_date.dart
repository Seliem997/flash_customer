import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/font_styles.dart';
import '../../widgets/custom_bar_widget.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class SelectDate extends StatelessWidget {
  const SelectDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Date & Time '),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
        child: Column(
          children: [
            Row(
              children: [
                TextWidget(
                  text: 'Select Date',
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size15,
                ),

                Spacer(),
                CustomContainer(
                  width: 55,
                  height: 24,
                  radiusCircular: 3,
                  borderColor: Color(0xFF979797),
                  child: Padding(
                    padding: symmetricEdgeInsets(horizontal: 4),
                    child: Row(
                      children: [
                        TextWidget(
                          text: 'Jan',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size10,
                          color: Color(0xFF909090),
                        ),
                        horizontalSpace(8),
                        SvgPicture.asset('assets/svg/arrow_down.svg',)
                      ],
                    ),
                  ),
                ),
                horizontalSpace(8),
                CustomContainer(
                  width: 65,
                  height: 24,
                  radiusCircular: 3,
                  borderColor: Color(0xFF979797),
                  child: Padding(
                    padding: symmetricEdgeInsets(horizontal: 4),
                    child: Row(
                      children: [
                        TextWidget(
                          text: '2023',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size10,
                          color: Color(0xFF909090),
                        ),
                        horizontalSpace(11),
                        SvgPicture.asset('assets/svg/arrow_down.svg',)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            verticalSpace(16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                  CustomContainer(
                    width: 48,
                    height: 58,
                    radiusCircular: 6,
                    backgroundColor: AppColor.buttonGrey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: '20',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size16,
                          color: Color(0xFF565656),
                        ),
                        verticalSpace(6),
                        TextWidget(
                          text: 'Fri',
                          fontWeight: MyFontWeight.regular,
                          textSize: MyFontSize.size10,
                          color: Color(0xFF696969),
                        ),

                      ],
                    ),
                  ),
                  horizontalSpace(10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
