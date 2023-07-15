import 'dart:async';
import 'dart:io';

import 'package:flash_customer/ui/payment/tap_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../providers/requestServices_provider.dart';
import '../../models/requestDetailsModel.dart';
import '../../models/request_details_model.dart';
import '../../providers/home_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../home/home_screen.dart';
import 'summaryRequestDetails.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/data_loader.dart';
import '../widgets/navigate.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';
import '../../utils/app_loader.dart';
import '../../utils/font_styles.dart';
import '../../utils/snack_bars.dart';
import '../../utils/styles/colors.dart';
import '../payment/bank_transfer/transfer_method.dart';

class RequestDetails extends StatefulWidget {
  const RequestDetails(
      {Key? key, required this.requestId, this.cameFromOtherServices = false, this.cameFromMonthlyPackage = false})
      : super(key: key);

  final int requestId;
  final bool cameFromOtherServices;
  final bool cameFromMonthlyPackage;

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  late Map<dynamic, dynamic> tapSDKResult;
  String responseID = "";
  String sdkStatus = "";
  String? sdkErrorCode;
  String? sdkErrorMessage;
  String? sdkErrorDescription;
  AwesomeLoaderController loaderController = AwesomeLoaderController();
  Color? payButtonColor;

  @override
  void initState() {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);
    super.initState();
    payButtonColor = const Color(0xff2ace00);
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    configureSDK();
  }

  void loadData() async {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);
    await requestServicesProvider
        .getRequestDetails(requestId: widget.requestId)
        .then((value) {
      requestServicesProvider.setLoading(false);
    });
  }

  // configure SDK
  Future<void> configureSDK({
    double? amount,
  }) async {
    // configure app
    configureApp();
    // sdk session configurations
    setupSDKSession(amount: amount);
  }

  // configure app key and bundle-id (You must get those keys from tap)
  Future<void> configureApp() async {
    GoSellSdkFlutter.configureApp(
      bundleId: Platform.isAndroid
          ? "com.flash.customerapp.flash_customer"
          : "com.flash.customerapp.flashCustomer",
      productionSecreteKey: Platform.isAndroid
          ? "sk_live_F8936xNMvjtIQLwle25zGqRC"
          : "sk_live_RudbTJM5larYPVzy8eKxhQ9B",
      sandBoxsecretKey: Platform.isAndroid
          ? "sk_test_hz9y0FNreufbwZA4kHMUCaLB"
          : "sk_test_6U4oxDwJlzAr5LPdisZ2ycXv",
      lang: "en",
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.   requestServicesProvider.updatedRequestDetailsData!.amount!
  Future<void> setupSDKSession({
    double? amount,
  }) async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          transactionCurrency: "SAR",
          amount: '$amount',
          customer: Customer(
              customerId: "",
              // customer id is important to retrieve cards saved for this customer
              email: "test@test.com",
              isdNumber: "965",
              number: "00000000",
              firstName: "test",
              middleName: "test",
              lastName: "test",
              metaData: null),
          paymentItems: [],
          // List of taxes
          taxes: [],

          shippings: [],

          postURL: "https://tap.company",
          // Payment description
          paymentDescription: "paymentDescription",
          // Payment Metadata
          paymentMetaData: {
            "SeliemCustomer_Id": "21",
            "SeliemRequest_Id": "22",
          },
          // Payment Reference
          paymentReference: Reference(
              acquirer: "acquirer",
              gateway: "gateway",
              payment: "payment",
              track: "track",
              transaction: "trans_910101",
              order: "order_262625"),
          // payment Descriptor
          paymentStatementDescriptor: "paymentStatementDescriptor",
          // Save Card Switch
          isUserAllowedToSaveCard: true,
          // Enable/Disable 3DSecure
          isRequires3DSecure: true,
          // Receipt SMS/Email
          receipt: Receipt(true, false),
          // Authorize Action [Capture - Void]
          authorizeAction: AuthorizeAction(
              type: AuthorizeActionType.CAPTURE, timeInHours: 10),
          // Destinations
          destinations: null,
          // merchant id
          merchantID: "",
          // Allowed cards
          allowedCadTypes: CardType.ALL,
          applePayMerchantID: "merchant.applePayMerchantID",
          allowsToSaveSameCardMoreThanOnce: true,
          // pass the card holder name to the SDK
          cardHolderName: "Card Holder NAME",
          // disable changing the card holder name by the user
          allowsToEditCardHolderName: true,
          // select payments you need to show [Default is all, and you can choose between WEB-CARD-APPLEPAY ]
          paymentType: PaymentType.ALL,
          // Transaction mode
          sdkMode: SDKMode.Sandbox);
    } on PlatformException {
      // platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      tapSDKResult = {};
    });
  }

  Future<void> startSDK() async {
    setState(() {
      loaderController.start();
    });

    var tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;
    loaderController.stopWhenFull();
    print('>>>> ${tapSDKResult['sdk_result']}');

    setState(() {
      switch (tapSDKResult['sdk_result']) {
        case "SUCCESS":
          sdkStatus = "SUCCESS";
          handleSDKResult();
          break;
        case "FAILED":
          sdkStatus = "FAILED";
          handleSDKResult();
          break;
        case "SDK_ERROR":
          print('sdk error............');
          print(tapSDKResult['sdk_error_code']);
          print(tapSDKResult['sdk_error_message']);
          print(tapSDKResult['sdk_error_description']);
          print('sdk error............');
          sdkErrorCode = tapSDKResult['sdk_error_code'].toString();
          sdkErrorMessage = tapSDKResult['sdk_error_message'];
          sdkErrorDescription = tapSDKResult['sdk_error_description'];
          break;

        case "NOT_IMPLEMENTED":
          sdkStatus = "NOT_IMPLEMENTED";
          break;
      }
    });
  }

  void handleSDKResult() {
    print('>>>> ${tapSDKResult['trx_mode']}');

    switch (tapSDKResult['trx_mode']) {
      case "CHARGE":
        printSDKResult('Charge');
        break;

      case "AUTHORIZE":
        printSDKResult('Authorize');
        break;

      case "SAVE_CARD":
        printSDKResult('Save Card');
        break;

      case "TOKENIZE":
        print('TOKENIZE token : ${tapSDKResult['token']}');
        print('TOKENIZE token_currency  : ${tapSDKResult['token_currency']}');
        print('TOKENIZE card_first_six : ${tapSDKResult['card_first_six']}');
        print('TOKENIZE card_last_four : ${tapSDKResult['card_last_four']}');
        print('TOKENIZE card_object  : ${tapSDKResult['card_object']}');
        print('TOKENIZE card_exp_month : ${tapSDKResult['card_exp_month']}');
        print('TOKENIZE card_exp_year    : ${tapSDKResult['card_exp_year']}');

        responseID = tapSDKResult['token'];
        break;
    }
  }

  void printSDKResult(String trx_mode) {
    print('$trx_mode status                : ${tapSDKResult['status']}');
    print('$trx_mode Aliiiicode                : ${tapSDKResult['code']}');
    print('$trx_mode id               : ${tapSDKResult['charge_id']}');
    print('$trx_mode  description        : ${tapSDKResult['description']}');
    print('$trx_mode  message           : ${tapSDKResult['message']}');
    print('$trx_mode  card_first_six : ${tapSDKResult['card_first_six']}');
    print('$trx_mode  card_last_four   : ${tapSDKResult['card_last_four']}');
    print('$trx_mode  card_object         : ${tapSDKResult['card_object']}');
    print('$trx_mode  card_brand          : ${tapSDKResult['card_brand']}');
    print('$trx_mode  card_exp_month  : ${tapSDKResult['card_exp_month']}');
    print('$trx_mode  card_exp_year: ${tapSDKResult['card_exp_year']}');
    print('$trx_mode  acquirer_id  : ${tapSDKResult['acquirer_id']}');
    print(
        '$trx_mode  acquirer_response_code : ${tapSDKResult['acquirer_response_code']}');
    print(
        '$trx_mode  acquirer_response_message: ${tapSDKResult['acquirer_response_message']}');
    print('$trx_mode  source_id: ${tapSDKResult['source_id']}');
    print('$trx_mode  source_channel     : ${tapSDKResult['source_channel']}');
    print('$trx_mode  source_object      : ${tapSDKResult['source_object']}');
    print(
        '$trx_mode source_payment_type : ${tapSDKResult['source_payment_type']}');

    responseID = tapSDKResult['charge_id'];
  }

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context);
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        withArrow: false,
        title: S.of(context).requestDetails,
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
                        text: S.of(context).theRequestWillBe,
                        style: TextStyle(
                            color: const Color(0xFF0F0F0F),
                            fontSize: MyFontSize.size20,
                            fontWeight: MyFontWeight.medium),
                        children: [
                          TextSpan(
                            text: S.of(context).canceled,
                            style: TextStyle(
                              color: const Color(0xFFFF3F48),
                              fontSize: MyFontSize.size20,
                              fontWeight: MyFontWeight.medium,
                            ),
                          ),
                          TextSpan(
                            text: S.of(context).areYouSureToGoBack,
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
                            text: S.of(context).cancel,
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
                            text: S.of(context).continu,
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
      body: (requestServicesProvider.isLoading)
          ? const DataLoader()
          : SingleChildScrollView(
            child: requestServicesProvider.detailsRequestData == null
                ? CustomSizedBox(
                    height: 500,
                    child: Center(
                        child: TextWidget(text: S.of(context).noDataAvailable)))
                : Padding(
                    padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
                    child: Column(
                      children: [
                        SummaryRequestDetails(
                            cameFromOtherServices: widget.cameFromOtherServices,
                            cameFromMonthlyPackage: widget.cameFromMonthlyPackage,
                            requestServicesProvider: requestServicesProvider),
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
                                  text: S.of(context).paymentMethods,
                                  textSize: MyFontSize.size15,
                                  fontWeight: MyFontWeight.semiBold,
                                ),
                                verticalSpace(12),
                                CustomContainer(
                                  height: 34,
                                  backgroundColor: requestServicesProvider
                                          .selectedCashPayment
                                      ? const Color(0xFFD2FFEA)
                                      : AppColor.white,
                                  borderColor: AppColor.borderGreyBold,
                                  radiusCircular: 4,
                                  padding: symmetricEdgeInsets(
                                      vertical: 5, horizontal: 12),
                                  onTap: () {
                                    requestServicesProvider.selectCashPayment(
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
                                        text: S.of(context).cash,
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
                                        text: S.of(context).creditCard,
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
                                          text: S.of(context).cardNumber,
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
                                          text: S.of(context).cardholderName,
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
                                                  text:
                                                      S.of(context).expiryDate,
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
                                              text: S.of(context).saveCard,
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
                                        text: S.of(context).applePay,
                                        textSize: MyFontSize.size12,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                    ],
                                  ),
                                ),
                               /* verticalSpace(12),
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
                                        text: S.of(context).stcPay,
                                        textSize: MyFontSize.size12,
                                        fontWeight: MyFontWeight.semiBold,
                                      ),
                                    ],
                                  ),
                                ),*/
                                verticalSpace(12),
                                CustomContainer(
                                  height: 34,
                                  backgroundColor: AppColor.white,
                                  borderColor: AppColor.borderGreyBold,
                                  radiusCircular: 4,
                                  padding: symmetricEdgeInsets(
                                      vertical: 5, horizontal: 12),
                                  onTap: (){
                                    navigateTo(context, const BankTransferMethod(),);
                                  },
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
                                        text: S.of(context).bankTransfer,
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
                                text: S.of(context).wallet,
                                textSize: MyFontSize.size15,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                              horizontalSpace(12),
                              TextWidget(
                                text: '${requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].customerDetails!.balance}',
                                textSize: MyFontSize.size14,
                                fontWeight: MyFontWeight.semiBold,
                                color: const Color(0xFF0084DF),
                              ),
                              horizontalSpace(10),
                              GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Padding(
                                            padding: onlyEdgeInsets(
                                                top: 40,
                                                bottom: 32,
                                                end: 38,
                                                start: 38),
                                            child: TextWidget(
                                              textAlign: TextAlign.center,
                                              text: S
                                                  .of(context)
                                                  .thisAmountWillDecreaseFromYourWallet,
                                              textSize: MyFontSize.size17,
                                              fontWeight: MyFontWeight.semiBold,
                                            ),
                                          ),
                                          actions: [
                                            Padding(
                                              padding: onlyEdgeInsets(
                                                  top: 0,
                                                  bottom: 40,
                                                  end: 48,
                                                  start: 48),
                                              child: DefaultButton(
                                                width: 225,
                                                height: 32,
                                                text: S.of(context).ok,
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
                                  child: Image.asset(
                                      'assets/images/info-circle.png')),
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
                                      text: S.of(context).amount,
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
                                      text: S.of(context).tax,
                                      textSize: MyFontSize.size15,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text:
                                          "${requestServicesProvider.updatedRequestDetailsData!.tax!} " "SR",
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
                                      text: S.of(context).discountCode,
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
                                      text: S.of(context).discountAmount,
                                      textSize: MyFontSize.size14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text:
                                          "${requestServicesProvider.couponData?.discountAmount ?? 0}",
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
                                      text: S.of(context).totalAmount,
                                      textSize: MyFontSize.size20,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text:
                                          '${requestServicesProvider.totalAmountAfterDiscount} SR',
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
                          backgroundColor: requestServicesProvider
                              .selectedCashPayment ? AppColor.primary : const Color(0xFFB6B6B6),
                          text: S.of(context).confirmAndPay,
                          onPressed: () async {
                            if (requestServicesProvider
                                    .selectedCashPayment /*||
                      requestServicesProvider
                          .selectedCreditCardPayment*/
                                ) {
                              AppLoader.showLoader(context);

                              await setupSDKSession(
                                  amount: requestServicesProvider.totalAmountAfterDiscount!.toDouble());

                              await startSDK();
                              await requestServicesProvider
                                  .submitFinialRequest(
                                requestId: requestServicesProvider
                                    .updatedRequestDetailsData!.id!,
                                payBy: 'cash',
                              )
                                  .then((value) async {
                                AppLoader.stopLoader();
                                CustomSnackBars.successSnackBar(
                                    context, 'Submit Request Success');
                                navigateAndFinish(
                                    context,
                                    const HomeScreen(
                                      cameFromNewRequest: true,
                                    ));
                              });
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Padding(
                                      padding: symmetricEdgeInsets(
                                          horizontal: 42, vertical: 20),
                                      child: TextWidget(
                                        text: S
                                            .of(context)
                                            .pleaseSelectACashPaymentMethod,
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
                                              text: S.of(context).ok,
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
