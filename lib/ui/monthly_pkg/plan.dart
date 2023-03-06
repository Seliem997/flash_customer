import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';
import 'date_time/washes_date.dart';

class MonthlyPlans extends StatefulWidget {
  const MonthlyPlans({Key? key}) : super(key: key);

  @override
  State<MonthlyPlans> createState() => _MonthlyPlansState();
}

class _MonthlyPlansState extends State<MonthlyPlans> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Monthly pkg'),
        body: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Select Package',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size16,
              ),
              verticalSpace(23),
              CustomContainer(
                onTap: (){
                  navigateTo(context, WashesDate(),);
                },
                radiusCircular: 6,
                width: 345,
                height: 173,
                backgroundColor: AppColor.selectedColor,
                padding: EdgeInsets.zero,
                borderColor: Color(0xFF55B9FE),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomContainer(
                          width: 112,
                          height: 34,
                          radiusCircular: 0,
                          backgroundColor: Color(0xFF9ACEF2),
                          child: Center(
                            child: TextWidget(
                              text: 'Economy PKG',
                              fontWeight: MyFontWeight.semiBold,
                              textSize: MyFontSize.size10,
                              color: Color(0xFF00567B),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 13),
                          child: CustomSizedBox(
                            height: 18,
                            width: 18,
                            child: CircleAvatar(
                              backgroundColor: Color(0xFF55B9FE),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          symmetricEdgeInsets(horizontal: 18, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(10),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Washes:',
                                fontWeight: MyFontWeight.semiBold,
                                textSize: MyFontSize.size14,
                              ),
                              horizontalSpace(8),
                              RichText(
                                text: TextSpan(
                                  text: '4 times ',
                                  style: TextStyle(
                                      color: Color(0xFF0096FF),
                                      fontSize: MyFontSize.size10,
                                      fontWeight: MyFontWeight.medium),
                                  children: [
                                    TextSpan(
                                      text: 'per month',
                                      style: TextStyle(
                                        color: const Color(0xFF636363),
                                        fontSize: MyFontSize.size10,
                                        fontWeight: MyFontWeight.medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(16),
                          TextWidget(
                            text: 'Include for each appointment:',
                            fontWeight: MyFontWeight.semiBold,
                            textSize: MyFontSize.size14,
                          ),
                          verticalSpace(7),
                          TextWidget(
                            text: 'Inside and outside wash(!)',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            color: Color(0xFF636363),
                          ),
                          verticalSpace(16),
                          TextWidget(
                            text: '160 SR',
                            fontWeight: MyFontWeight.bold,
                            textSize: MyFontSize.size14,
                            color: AppColor.borderBlue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(16),
              CustomContainer(
                radiusCircular: 6,
                width: 345,
                height: 173,
                backgroundColor: AppColor.borderGrey,
                padding: EdgeInsets.zero,
                borderColor: Color(0xFFCDCDCD),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomContainer(
                          width: 112,
                          height: 34,
                          radiusCircular: 0,
                          backgroundColor: Color(0xFFB8B8B8),
                          child: Center(
                            child: TextWidget(
                              text: 'Golden PKG',
                              fontWeight: MyFontWeight.semiBold,
                              textSize: MyFontSize.size10,
                              color: Color(0xFF363636),
                            ),
                          ),
                        ),
                        Spacer(),
                        // Padding(
                        //   padding: const EdgeInsetsDirectional.only(end: 13),
                        //   child: CustomSizedBox(
                        //     height: 18,
                        //     width: 18,
                        //     child: CircleAvatar(
                        //       backgroundColor: Color(0xFF55B9FE),
                        //       child: Icon(
                        //         Icons.check,
                        //         color: Colors.white,
                        //         size: 13,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding:
                      symmetricEdgeInsets(horizontal: 18, vertical: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(10),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Washes:',
                                fontWeight: MyFontWeight.semiBold,
                                textSize: MyFontSize.size14,
                              ),
                              horizontalSpace(8),
                              RichText(
                                text: TextSpan(
                                  text: '4 times ',
                                  style: TextStyle(
                                      color: Color(0xFF0096FF),
                                      fontSize: MyFontSize.size10,
                                      fontWeight: MyFontWeight.medium),
                                  children: [
                                    TextSpan(
                                      text: 'per month',
                                      style: TextStyle(
                                        color: const Color(0xFF636363),
                                        fontSize: MyFontSize.size10,
                                        fontWeight: MyFontWeight.medium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(16),
                          TextWidget(
                            text: 'Include for each appointment:',
                            fontWeight: MyFontWeight.semiBold,
                            textSize: MyFontSize.size14,
                          ),
                          verticalSpace(7),
                          TextWidget(
                            text: 'Inside and outside wash(!)',
                            fontWeight: MyFontWeight.medium,
                            textSize: MyFontSize.size10,
                            color: Color(0xFF636363),
                          ),
                          verticalSpace(16),
                          TextWidget(
                            text: '160 SR',
                            fontWeight: MyFontWeight.bold,
                            textSize: MyFontSize.size14,
                            color: AppColor.borderBlue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ));
  }
}
