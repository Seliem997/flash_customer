import 'package:flash_customer/ui/requests/summaryRequestDetails.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/font_styles.dart';
import '../../utils/snack_bars.dart';
import '../../utils/styles/colors.dart';
import '../home/home_screen.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/custom_text_form.dart';
import '../widgets/data_loader.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';
import 'myRequests.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails({Key? key, required this.requestId, this.cameFromOtherServices = false}) : super(key: key);

  final int requestId;
  final bool cameFromOtherServices;

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context, listen: false);
    await requestServicesProvider
        .getRequestDetails(requestId: widget.requestId)
        .then((value) => requestServicesProvider.setLoading(false));
  }

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context);

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
          onPressed: () {
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
                      padding:
                          symmetricEdgeInsets(vertical: 21, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              navigateAndFinish(context, const HomeScreen());
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
        ),
      ),
      body: SingleChildScrollView(
        child: (requestServicesProvider.isLoading)
            ? const DataLoader()
            : requestServicesProvider.detailsRequestData == null
                ? const CustomSizedBox(
                    height: 500,
                    child: Center(child: TextWidget(text: 'No Data Available')))
                : Padding(
                    padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
                    child: Column(
                      children: [
                        SummaryRequestDetails(cameFromOtherServices: widget.cameFromOtherServices,requestServicesProvider: requestServicesProvider),
                        verticalSpace(22),
                        CustomContainer(
                          width: 345,
                          radiusCircular: 4,
                          backgroundColor: const Color(0xFFE2E2F5),
                          child: Padding(
                            padding: symmetricEdgeInsets(
                                vertical: 11, horizontal: 24),
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
                                  backgroundColor:  requestServicesProvider
                                      .selectedCashPayment
                                      ? const Color(0xFFD2FFEA)
                                      : AppColor.white,
                                  borderColor: AppColor.borderGreyBold,
                                  radiusCircular: 4,
                                  padding: symmetricEdgeInsets(
                                      vertical: 5, horizontal: 12),
                                  onTap: () {
                                    requestServicesProvider
                                        .selectCashPayment(
                                        !requestServicesProvider
                                            .selectedCashPayment);
                                  },
                                  child: Row(
                                    children: [
                                      CustomSizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/images/cash.png'),
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
                                verticalSpace(12),
                                CustomContainer(
                                  height: 34,
                                  backgroundColor: requestServicesProvider
                                          .selectedCreditCardPayment
                                      ? const Color(0xFFD2FFEA)
                                      : AppColor.white,
                                  borderColor: AppColor.borderGreyBold,
                                  radiusCircular: 4,
                                  padding: symmetricEdgeInsets(
                                      vertical: 5, horizontal: 12),
                                  onTap: () {
                                    requestServicesProvider
                                        .selectCreditCardPayment(
                                            !requestServicesProvider
                                                .selectedCreditCardPayment);
                                  },
                                  child: Row(
                                    children: [
                                      CustomSizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/images/card.png'),
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
                                Visibility(
                                  visible: requestServicesProvider
                                      .selectedCreditCardPayment,
                                  child: CustomContainer(
                                    backgroundColor: const Color(0xFFF4FFFA),
                                    borderColor: AppColor.borderGreyBold,
                                    radiusCircular: 7,
                                    padding: symmetricEdgeInsets(
                                        vertical: 16, horizontal: 14),
                                    margin: onlyEdgeInsets(top: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          padding: symmetricEdgeInsets(
                                              vertical: 6, horizontal: 10),
                                          child: Row(
                                            children: [
                                              TextWidget(
                                                text: '*********8729',
                                                textSize: MyFontSize.size8,
                                                fontWeight:
                                                    MyFontWeight.regular,
                                              ),
                                              const Spacer(),
                                              CustomSizedBox(
                                                height: 16,
                                                width: 16,
                                                child: Image.asset(
                                                  'assets/images/card.png',
                                                  fit: BoxFit.fitWidth,
                                                ),
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
                                          padding: symmetricEdgeInsets(
                                              vertical: 6, horizontal: 10),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(
                                                  text: 'Expiry Date',
                                                  textSize: MyFontSize.size12,
                                                  fontWeight:
                                                      MyFontWeight.medium,
                                                  color:
                                                      const Color(0xFF272727),
                                                ),
                                                verticalSpace(8),
                                                CustomContainer(
                                                  height: 28,
                                                  width: 117,
                                                  backgroundColor:
                                                      AppColor.white,
                                                  borderColor:
                                                      AppColor.borderGreyBold,
                                                  radiusCircular: 3,
                                                  padding: symmetricEdgeInsets(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  child: Row(
                                                    children: [
                                                      TextWidget(
                                                        text: 'MM/YY',
                                                        textSize:
                                                            MyFontSize.size8,
                                                        fontWeight: MyFontWeight
                                                            .regular,
                                                      ),
                                                      const Spacer(),
                                                      CustomSizedBox(
                                                        height: 16,
                                                        width: 16,
                                                        child: Image.asset(
                                                          'assets/images/calendar.png',
                                                          fit: BoxFit.fitWidth,
                                                        ),
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
                                                  fontWeight:
                                                      MyFontWeight.medium,
                                                  color:
                                                      const Color(0xFF272727),
                                                ),
                                                verticalSpace(8),
                                                CustomContainer(
                                                  height: 28,
                                                  width: 97,
                                                  backgroundColor:
                                                      AppColor.white,
                                                  borderColor:
                                                      AppColor.borderGreyBold,
                                                  radiusCircular: 3,
                                                  padding: symmetricEdgeInsets(
                                                      vertical: 6,
                                                      horizontal: 10),
                                                  child: Row(
                                                    children: [
                                                      TextWidget(
                                                        text: '***',
                                                        textSize:
                                                            MyFontSize.size8,
                                                        fontWeight: MyFontWeight
                                                            .regular,
                                                      ),
                                                      const Spacer(),
                                                      CustomSizedBox(
                                                        height: 16,
                                                        width: 16,
                                                        child: Image.asset(
                                                            'assets/images/info-circle.png'),
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
                                              child: Image.asset(
                                                  'assets/images/empty_circle.png'),
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
                                ),
                                verticalSpace(12),
                                CustomContainer(
                                  height: 34,
                                  backgroundColor: AppColor.white,
                                  borderColor: AppColor.borderGreyBold,
                                  radiusCircular: 4,
                                  padding: symmetricEdgeInsets(
                                      vertical: 5, horizontal: 12),
                                  child: Row(
                                    children: [
                                      CustomSizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/images/apple.png'),
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
                                  padding: symmetricEdgeInsets(
                                      vertical: 5, horizontal: 12),
                                  child: Row(
                                    children: [
                                      CustomSizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/images/stc.png'),
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
                                  padding: symmetricEdgeInsets(
                                      vertical: 5, horizontal: 12),
                                  child: Row(
                                    children: [
                                      CustomSizedBox(
                                        height: 24,
                                        width: 24,
                                        child: Image.asset(
                                            'assets/images/bank.png'),
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
                          padding: symmetricEdgeInsets(horizontal: 24),
                          child: Row(
                            children: [
                              TextWidget(
                                text: 'Wallet',
                                textSize: MyFontSize.size15,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              horizontalSpace(12),
                              TextWidget(
                                /*${requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].customerDetails!.balance}*/
                                text: '20 SR',
                                textSize: MyFontSize.size14,
                                fontWeight: MyFontWeight.semiBold,
                                color: const Color(0xFF0084DF),
                              ),
                              horizontalSpace(10),
                              GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: Padding(
                                          padding: onlyEdgeInsets(
                                              top: 40, bottom: 32, end: 38, start: 38),
                                          child: TextWidget(
                                            textAlign: TextAlign.center,
                                            text:
                                            'This amount will decrease from your wallet',
                                            textSize: MyFontSize.size17,
                                            fontWeight: MyFontWeight.semiBold,
                                          ),
                                        ),
                                        actions: [
                                          Padding(
                                            padding: onlyEdgeInsets(
                                                top: 0, bottom: 40, end: 48, start: 48),
                                            child: DefaultButton(
                                              width: 225,
                                              height: 32,
                                              text: 'Ok',
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                  child: Image.asset('assets/images/info-circle.png')),
                            ],
                          ),
                        ),
                        verticalSpace(22),
                        CustomContainer(
                          width: 345,
                          // height: 235,
                          borderColor: AppColor.primary,
                          backgroundColor: const Color(0xFFF1F6FE),
                          child: Padding(
                            padding: symmetricEdgeInsets(
                                vertical: 16, horizontal: 24),
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
                                      text:
                                          '${requestServicesProvider.updatedRequestDetailsData!.amount!} SR',
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
                                      text:
                                          "${requestServicesProvider.updatedRequestDetailsData!.tax!}%",
                                      textSize: MyFontSize.size12,
                                      fontWeight: MyFontWeight.medium,
                                      color: const Color(0xFF383838),
                                    ),
                                  ],
                                ),

                                verticalSpace(20),
                                Row(
                                  children: [
                                    TextWidget(
                                      text: 'Discount code : ',
                                      textSize: MyFontSize.size14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    CustomContainer(
                                      width: 112,
                                      height: 30,
                                      radiusCircular: 3,
                                      backgroundColor: AppColor.buttonGrey,
                                      borderColor: AppColor.boldGrey,
                                      alignment: Alignment.center,
                                      child: Center(
                                        child: DefaultFormField(
                                          controller: requestServicesProvider
                                              .discountCodeController,
                                          withBorder: false,
                                          // padding: 10,
                                          // contentPadding: onlyEdgeInsets(start: 10),
                                          textInputAction: TextInputAction.done,
                                          hintText: '',
                                          enabled: requestServicesProvider
                                                  .couponData ==
                                              null,
                                          padding: symmetricEdgeInsets(
                                              vertical: 9, horizontal: 5),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: requestServicesProvider
                                                  .couponData !=
                                              null
                                          ? () {
                                              requestServicesProvider
                                                  .resetCoupon();
                                            }
                                          : () {
                                              requestServicesProvider
                                                  .checkOfferCoupon(context);
                                            },
                                      child: TextWidget(
                                        text: requestServicesProvider
                                                    .couponData !=
                                                null
                                            ? S.of(context).remove
                                            : S.of(context).apply,
                                        textSize: MyFontSize.size12,
                                        fontWeight: MyFontWeight.medium,
                                        color: requestServicesProvider
                                                    .couponData !=
                                                null
                                            ? AppColor.textRed
                                            : AppColor.primary,
                                      ),
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
                                      text: "${requestServicesProvider.couponData?.discountAmount ?? 0}",
                                      // "${requestServicesProvider.updatedRequestDetailsData!.discountAmount} SR",
                                      textSize: MyFontSize.size12,
                                      fontWeight: MyFontWeight.medium,
                                      color: const Color(0xFF383838),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: symmetricEdgeInsets(
                                      horizontal: 10, vertical: 28),
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
                                      text:
                                          '${requestServicesProvider.totalAmountAfterDiscount } SR',
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
                          onPressed: () async {
                            if(requestServicesProvider.selectedCashPayment || requestServicesProvider.selectedCreditCardPayment){
                              await requestServicesProvider
                                  .submitFinialRequest(
                                  requestId: requestServicesProvider
                                      .updatedRequestDetailsData!.id!,
                                  payBy: 'cash')
                                  .then((value) {
                                CustomSnackBars.successSnackBar(
                                    context, 'Submit Request Success');
                                navigateAndFinish(
                                    context,
                                    const HomeScreen(
                                      cameFromNewRequest: true,
                                    ));
                              });
                            }else{
                              showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Padding(
                                    padding: symmetricEdgeInsets(
                                        horizontal: 42, vertical: 20),
                                    child: TextWidget(
                                      text: 'Please select a cash payment method ',
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
                                            backgroundColor:
                                                const Color(0xFFBADEF6),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                            }

                          },
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

