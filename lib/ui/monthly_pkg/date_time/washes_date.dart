import 'package:flash_customer/ui/monthly_pkg/date_time/select_date.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/font_styles.dart';
import '../../widgets/custom_bar_widget.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class WashesDate extends StatelessWidget {
  const WashesDate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Date & Time '),
      body: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: '1st wash',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(12),
              CustomContainer(
                width: double.infinity,
                height: 75,
                backgroundColor: AppColor.selectedColor,
                child: Row(
                  children: [
                    CustomContainer(
                      width: 8,
                      height: double.infinity,
                      radiusCircular: 0,
                      backgroundColor: AppColor.primary,
                    ),
                    Padding(
                      padding:
                          symmetricEdgeInsets(horizontal: 12.5, vertical: 13.5),
                      child: Row(
                        children: [
                          CustomContainer(
                            borderColor: Color(0xFF0096FF),
                            height: 45,
                            width: 45,
                            backgroundColor: Colors.transparent,
                            radiusCircular: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svg/about.svg',
                              ),
                            ),
                          ),
                          horizontalSpace(24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/calendar.svg'),
                                  horizontalSpace(10),
                                  TextWidget(
                                    text: 'Monday, 22 January 2023',
                                    textSize: MyFontSize.size10,
                                    fontWeight: MyFontWeight.medium,
                                    color: Color(0xff282828),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/clock (1).svg'),
                                  horizontalSpace(10),
                                  TextWidget(
                                    text: '03:15 PM',
                                    textSize: MyFontSize.size10,
                                    fontWeight: MyFontWeight.medium,
                                    color: Color(0xff282828),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              verticalSpace(24),
              TextWidget(
                text: '2nd wash',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(12),
              CustomContainer(
                width: double.infinity,
                height: 75,
                backgroundColor: AppColor.borderGrey,
                child: Row(
                  children: [
                    CustomContainer(
                      width: 8,
                      height: double.infinity,
                      radiusCircular: 0,
                      backgroundColor: Color(0xFF898A8D),
                    ),
                    Padding(
                      padding:
                          symmetricEdgeInsets(horizontal: 12.5, vertical: 13.5),
                      child: Row(
                        children: [
                          CustomContainer(
                            borderColor: Color(0xFF979797),
                            height: 46,
                            width: 46,
                            backgroundColor: Colors.transparent,
                            radiusCircular: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svg/about.svg',
                              ),
                            ),
                          ),
                          horizontalSpace(24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/calendar.svg'),
                                  horizontalSpace(10),
                                  TextWidget(
                                    text: 'Monday, 22 January 2023',
                                    textSize: MyFontSize.size10,
                                    fontWeight: MyFontWeight.medium,
                                    color: Color(0xff282828),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/clock (1).svg'),
                                  horizontalSpace(10),
                                  TextWidget(
                                    text: '03:15 PM',
                                    textSize: MyFontSize.size10,
                                    fontWeight: MyFontWeight.medium,
                                    color: Color(0xff282828),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              verticalSpace(24),
              TextWidget(
                text: '3rd wash',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(12),
              CustomContainer(
                width: double.infinity,
                height: 75,
                backgroundColor: AppColor.borderGrey,
                child: Row(
                  children: [
                    CustomContainer(
                      width: 8,
                      height: double.infinity,
                      radiusCircular: 0,
                      backgroundColor: Color(0xFF898A8D),
                    ),
                    Padding(
                      padding:
                          symmetricEdgeInsets(horizontal: 12.5, vertical: 13.5),
                      child: Row(
                        children: [
                          CustomContainer(
                            borderColor: Color(0xFF979797),
                            height: 46,
                            width: 46,
                            backgroundColor: Colors.transparent,
                            radiusCircular: 100,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/svg/about.svg',
                              ),
                            ),
                          ),
                          horizontalSpace(24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/calendar.svg'),
                                  horizontalSpace(10),
                                  TextWidget(
                                    text: 'Monday, 22 January 2023',
                                    textSize: MyFontSize.size10,
                                    fontWeight: MyFontWeight.medium,
                                    color: Color(0xff282828),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                              Row(
                                children: [
                                  SvgPicture.asset('assets/svg/clock (1).svg'),
                                  horizontalSpace(10),
                                  TextWidget(
                                    text: '03:15 PM',
                                    textSize: MyFontSize.size10,
                                    fontWeight: MyFontWeight.medium,
                                    color: Color(0xff282828),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              verticalSpace(24),
              TextWidget(
                text: '4th wash',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(12),
              CustomContainer(
                width: double.infinity,
                height: 75,
                onTap: (){
                  navigateTo(context, SelectDate());
                },
                backgroundColor: AppColor.borderGrey,
                child: Row(
                  children: [
                    CustomContainer(
                      width: 8,
                      height: double.infinity,
                      radiusCircular: 0,
                      backgroundColor: Color(0xFF898A8D),
                    ),
                    Expanded(
                      child: Center(
                        child: TextWidget(
                          text: 'No date & time',
                          fontWeight: MyFontWeight.medium,
                          textSize: MyFontSize.size12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              verticalSpace(24),
            ],
          )),
    );
  }
}
