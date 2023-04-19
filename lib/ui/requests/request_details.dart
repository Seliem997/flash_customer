import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/font_styles.dart';
import '../../utils/styles/colors.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_text_form.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class RequestDetails extends StatelessWidget {
  const RequestDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        withArrow: false,
        title: 'Request details',
        customizePopButton: IconButton(
          icon: SvgPicture.asset(
            'assets/svg/arrow-left.svg',
            color: Colors.black,
            width: 5.w,
          ),
          onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Padding(
                    padding: symmetricEdgeInsets(horizontal: 36, vertical: 0),
                    child: RichText(
                      text: TextSpan(
                        text: 'The request will be',
                        style: TextStyle(
                            color: const Color(0xFF0F0F0F),
                            fontSize: MyFontSize.size20,
                            fontWeight: MyFontWeight.medium),
                        children: [
                          TextSpan(
                            text: ' canceled',
                            style: TextStyle(
                              color: const Color(0xFFFF3F48),
                              fontSize: MyFontSize.size20,
                              fontWeight: MyFontWeight.medium,
                            ),
                          ),
                          TextSpan(
                            text: ' Are you sure to go back?',
                            style: TextStyle(
                              color: const Color(0xFF0F0F0F),
                              fontSize: MyFontSize.size20,
                              fontWeight: MyFontWeight.medium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: symmetricEdgeInsets(vertical: 21, horizontal: 24),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          DefaultButton(
                            width: 100,
                            height: 33,
                            text: 'Cancel',
                            textColor: AppColor.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: AppColor.textRed,
                          ),
                          horizontalSpace(21),
                          DefaultButton(
                            width: 100,
                            height: 33,
                            text: 'Continue',
                            textColor: AppColor.white,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: AppColor.boldGreen,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
          color: Colors.black,
          iconSize: 20.0,
        )
        ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            children: [
              CustomContainer(
                width: 345,
                // height: 395,
                radiusCircular: 4,
                borderColor: AppColor.primary,
                backgroundColor: const Color(0xFFF1F6FE),
                child: Padding(
                  padding: symmetricEdgeInsets(vertical: 24, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Location',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      verticalSpace(10),
                      TextWidget(
                        text: 'Flash Wash Store - Uhud St. - Qatif',
                        textSize: MyFontSize.size12,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                      verticalSpace(20),
                      TextWidget(
                        text: 'Vehicle',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      verticalSpace(10),
                      TextWidget(
                        text: 'Small Car - Blue Yaris ACWS 2190',
                        textSize: MyFontSize.size12,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                      verticalSpace(20),
                      TextWidget(
                        text: 'Date & Time',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      verticalSpace(10),
                      TextWidget(
                        text: 'Monday, 23 January 2023',
                        textSize: MyFontSize.size12,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                      verticalSpace(20),
                      TextWidget(
                        text: 'Services',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      verticalSpace(10),
                      TextWidget(
                        text: 'Inside & Outside wash (45 SR)',
                        textSize: MyFontSize.size12,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                      verticalSpace(20),
                      TextWidget(
                        text: 'Extra Services',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      verticalSpace(10),
                      TextWidget(
                        text: 'One chair wash (40 SR)',
                        textSize: MyFontSize.size12,
                        fontWeight: MyFontWeight.regular,
                        color: AppColor.subTextGrey,
                      ),
                      verticalSpace(20),
                      Row(
                        children: [
                          TextWidget(
                            text: 'Service Duration',
                            textSize: MyFontSize.size15,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          TextWidget(
                            text: '50 Min',
                            textSize: MyFontSize.size15,
                            fontWeight: MyFontWeight.medium,
                            color: const Color(0xFF686868),
                          ),
                          verticalSpace(20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(22),
              CustomContainer(
                width: 345,
                // height: 275,
                radiusCircular: 4,
                backgroundColor: const Color(0xFFE2E2F5),
                child: Padding(
                  padding: symmetricEdgeInsets(vertical: 11, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Payment methods',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.semiBold,
                      ),
                      verticalSpace(12),
                      CustomContainer(
                        height: 34,
                        backgroundColor: AppColor.white,
                        borderColor: AppColor.borderGreyBold,
                        radiusCircular: 4,
                        padding: symmetricEdgeInsets(vertical: 5, horizontal: 12),
                        child: Row(
                          children: [
                            CustomSizedBox(
                                height: 24,width: 24,
                                child: Image.asset('assets/images/cash.png'),
                            ),
                            horizontalSpace(10),
                            TextWidget(
                              text: 'Cash',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(10),
                      CustomContainer(
                        height: 240,
                        backgroundColor: const Color(0xFFF4FFFA),
                        borderColor: AppColor.borderGreyBold,
                        radiusCircular: 7,
                        padding: symmetricEdgeInsets(vertical: 16, horizontal: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'Card number',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: const Color(0xFF272727),
                            ),
                            verticalSpace(8),
                            CustomContainer(
                              height: 28,
                              backgroundColor: AppColor.white,
                              borderColor: AppColor.borderGreyBold,
                              radiusCircular: 3,
                              padding: symmetricEdgeInsets(vertical: 6, horizontal: 10),
                              child: Row(
                                children: [
                                  TextWidget(
                                    text: '*********8729',
                                    textSize: MyFontSize.size8,
                                    fontWeight: MyFontWeight.regular,
                                  ),
                                  const Spacer(),
                                  CustomSizedBox(
                                    height: 16,width: 16,
                                    child: Image.asset('assets/images/card.png',fit: BoxFit.fitWidth,),
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(11),
                            TextWidget(
                              text: 'Cardholder name',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.medium,
                              color: const Color(0xFF272727),
                            ),
                            verticalSpace(8),
                            CustomContainer(
                              height: 28,
                              backgroundColor: AppColor.white,
                              borderColor: AppColor.borderGreyBold,
                              radiusCircular: 3,
                              padding: symmetricEdgeInsets(vertical: 6, horizontal: 10),
                              child: TextWidget(
                                text: '*********8729',
                                textSize: MyFontSize.size8,
                                fontWeight: MyFontWeight.regular,
                              ),
                            ),
                            verticalSpace(16),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    TextWidget(
                                      text: 'Expiry Date',
                                      textSize: MyFontSize.size12,
                                      fontWeight: MyFontWeight.medium,
                                      color: const Color(0xFF272727),
                                    ),
                                    verticalSpace(8),
                                    CustomContainer(
                                      height: 28,
                                      width: 117,
                                      backgroundColor: AppColor.white,
                                      borderColor: AppColor.borderGreyBold,
                                      radiusCircular: 3,
                                      padding: symmetricEdgeInsets(vertical: 6, horizontal: 10),
                                      child: Row(
                                        children: [
                                          TextWidget(
                                            text: 'MM/YY',
                                            textSize: MyFontSize.size8,
                                            fontWeight: MyFontWeight.regular,
                                          ),
                                          const Spacer(),
                                          CustomSizedBox(
                                            height: 16,width: 16,
                                            child: Image.asset('assets/images/calendar.png',fit: BoxFit.fitWidth,),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                horizontalSpace(50),
                                Column(
                                  children: [
                                    TextWidget(
                                      text: 'CVV/CVC',
                                      textSize: MyFontSize.size12,
                                      fontWeight: MyFontWeight.medium,
                                      color: const Color(0xFF272727),
                                    ),
                                    verticalSpace(8),
                                    CustomContainer(
                                      height: 28,
                                      width: 97,
                                      backgroundColor: AppColor.white,
                                      borderColor: AppColor.borderGreyBold,
                                      radiusCircular: 3,
                                      padding: symmetricEdgeInsets(vertical: 6, horizontal: 10),
                                      child: Row(
                                        children: [
                                          TextWidget(
                                            text: '***',
                                            textSize: MyFontSize.size8,
                                            fontWeight: MyFontWeight.regular,
                                          ),
                                          const Spacer(),
                                          CustomSizedBox(
                                            height: 16,width: 16,
                                            child: Image.asset('assets/images/info-circle.png'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            verticalSpace(16),
                            Row(
                              children: [
                                CustomSizedBox(
                                  height: 16,
                                    width: 16,
                                    child: Image.asset('assets/images/empty_circle.png'),
                                ),
                                horizontalSpace(8),
                                TextWidget(
                                  text: 'Save Card',
                                  textSize: MyFontSize.size12,
                                  fontWeight: MyFontWeight.semiBold,
                                  color: AppColor.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(12),
                      CustomContainer(
                        height: 34,
                        backgroundColor: AppColor.white,
                        borderColor: AppColor.borderGreyBold,
                        radiusCircular: 4,
                        padding: symmetricEdgeInsets(vertical: 5, horizontal: 12),
                        child: Row(
                          children: [
                            CustomSizedBox(
                                height: 24,width: 24,
                                child: Image.asset('assets/images/card.png'),
                            ),
                            horizontalSpace(10),
                            TextWidget(
                              text: 'Credit card',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(12),
                      CustomContainer(
                        height: 34,
                        backgroundColor: AppColor.white,
                        borderColor: AppColor.borderGreyBold,
                        radiusCircular: 4,
                        padding: symmetricEdgeInsets(vertical: 5, horizontal: 12),
                        child: Row(
                          children: [
                            CustomSizedBox(
                                height: 24,width: 24,
                                child: Image.asset('assets/images/apple.png'),
                            ),
                            horizontalSpace(10),
                            TextWidget(
                              text: 'Apple Pay',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(12),
                      CustomContainer(
                        height: 34,
                        backgroundColor: AppColor.white,
                        borderColor: AppColor.borderGreyBold,
                        radiusCircular: 4,
                        padding: symmetricEdgeInsets(vertical: 5, horizontal: 12),
                        child: Row(
                          children: [
                            CustomSizedBox(
                                height: 24,width: 24,
                                child: Image.asset('assets/images/stc.png'),
                            ),
                            horizontalSpace(10),
                            TextWidget(
                              text: 'STC Pay',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                      verticalSpace(12),
                      CustomContainer(
                        height: 34,
                        backgroundColor: AppColor.white,
                        borderColor: AppColor.borderGreyBold,
                        radiusCircular: 4,
                        padding: symmetricEdgeInsets(vertical: 5, horizontal: 12),
                        child: Row(
                          children: [
                            CustomSizedBox(
                                height: 24,width: 24,
                                child: Image.asset('assets/images/bank.png'),
                            ),
                            horizontalSpace(10),
                            TextWidget(
                              text: 'Bank Transfer',
                              textSize: MyFontSize.size12,
                              fontWeight: MyFontWeight.semiBold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(22),
              Padding(
                padding:symmetricEdgeInsets(horizontal: 24),
                child: Row(children: [
                  TextWidget(
                    text: 'Wallet',
                    textSize: MyFontSize.size15,
                    fontWeight: MyFontWeight.semiBold,
                  ),
                  horizontalSpace(12),
                  TextWidget(
                    text: '20 SR',
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.semiBold,
                    color: const Color(0xFF0084DF),
                  ),
                  horizontalSpace(10),
                  Image.asset('assets/images/info-circle.png'),
                ],),
              ),
              verticalSpace(22),
              CustomContainer(
                width: 345,
                height: 235,
                borderColor: AppColor.primary,
                backgroundColor: const Color(0xFFF1F6FE),
                child: Padding(
                  padding: symmetricEdgeInsets(vertical: 16, horizontal: 24),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextWidget(
                            text: 'Amount :',
                            textSize: MyFontSize.size15,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          const Spacer(),
                          TextWidget(
                            text: '154 SR',
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.medium,
                            color: const Color(0xFF383838),
                          ),
                        ],
                      ),
                      verticalSpace(14),
                      Row(
                        children: [
                          TextWidget(
                            text: 'Tax :',
                            textSize: MyFontSize.size15,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          const Spacer(),
                          TextWidget(
                            text: '17 SR',
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.medium,
                            color: const Color(0xFF383838),
                          ),
                        ],
                      ),
                      verticalSpace(14),
                      Row(
                        children: [
                          TextWidget(
                            text: 'Discount Amount :',
                            textSize: MyFontSize.size14,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          const Spacer(),
                          TextWidget(
                            text: '70 SR',
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.medium,
                            color: const Color(0xFF383838),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: 'Discount code : ',
                            textSize: MyFontSize.size14,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          CustomContainer(
                            width: 112,
                            height: 24,
                            radiusCircular: 3,
                            backgroundColor: AppColor.white,
                            borderColor: AppColor.boldGrey,
                            child: Center(
                              child: CustomTextForm(
                                contentPadding:
                                onlyEdgeInsets(start: 10, bottom: 8),
                                textInputAction: TextInputAction.done,
                                hintText: '',
                              ),
                            ),
                          ),
                          const Spacer(),
                          TextWidget(
                            text: 'Active',
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                        symmetricEdgeInsets(horizontal: 10, vertical: 28),
                        child: const Divider(
                          color: Color(0xFF898A8D),
                        ),
                      ),
                      Row(
                        children: [
                          TextWidget(
                            text: 'Total Amount :',
                            textSize: MyFontSize.size20,
                            fontWeight: MyFontWeight.semiBold,
                          ),
                          const Spacer(),
                          TextWidget(
                            text: '240 SR',
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.medium,
                            color: const Color(0xFF383838),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(40),
              DefaultButton(
                height: 48,
                width: 345,
                fontWeight: MyFontWeight.bold,
                fontSize: MyFontSize.size20,
                backgroundColor: const Color(0xFFB6B6B6),
                text: 'Confirm and Pay',
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Padding(
                          padding: symmetricEdgeInsets(horizontal: 42, vertical: 20),
                          child: TextWidget(
                            text: 'Please select a payment method ',
                            fontWeight: MyFontWeight.semiBold,
                            textSize: MyFontSize.size15,
                            height: 1.5,
                          ),
                        ),
                        actions: [
                          Padding(
                            padding: onlyEdgeInsets(bottom: 20),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                DefaultButton(
                                  width: 154,
                                  height: 25,
                                  text: 'Ok',
                                  textColor: AppColor.black,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  backgroundColor: const Color(0xFFBADEF6),
                                ),
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
      ),
    );
  }
}
