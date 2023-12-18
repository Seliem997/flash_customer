import 'dart:async';
import 'dart:io';

import 'package:flash_customer/providers/user_provider.dart';
import 'package:flash_customer/ui/payment/tap_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:intl/intl.dart' as intlAr;
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
import '../../providers/requestServices_provider.dart';
import '../../utils/enum/statuses.dart';
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
      {Key? key,
      required this.requestId,
      this.cameFromOtherServices = false,
      this.cameFromMonthlyPackage = false})
      : super(key: key);

  final int requestId;
  final bool cameFromOtherServices;
  final bool cameFromMonthlyPackage;

  @override
  State<RequestDetails> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  late Map<dynamic, dynamic> tapSDKResult;
  String chargeId = "";
  String sdkStatus = "";
  String? sdkErrorCode;
  String? sdkErrorMessage;
  String? sdkErrorDescription;
  AwesomeLoaderController loaderController = AwesomeLoaderController();
  Color? payButtonColor;

  @override
  void initState() {
    super.initState();
    payButtonColor = const Color(0xff2ace00);
    Future.delayed(const Duration(seconds: 0)).then((value) {
      startTimeout();
      loadData();
    });
    configureSDK();
  }

  void loadData() async {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);
    requestServicesProvider.clearServices();
    await requestServicesProvider
        .getRequestDetails(requestId: widget.requestId)
        .then((value) {
      requestServicesProvider.setLoading(false);
    });
  }

  final interval = const Duration(seconds: 1);

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  final int timerMaxSeconds = 60 * 10;

  int currentSeconds = 0;

  bool is_screen_on = true;

  bool isShow = false;

  startTimeout([int? milliseconds]) {
    final UserProvider userDataProvider =
        Provider.of<UserProvider>(context, listen: false);

    if (userDataProvider.timer != null) {
      userDataProvider.timer!.cancel();
    }
    var duration = interval;
    userDataProvider.timer = Timer.periodic(duration, (timer) {
      if (is_screen_on && userDataProvider.timer != null) {
        setState(() {
          currentSeconds = timer.tick;
          if (currentSeconds == timerMaxSeconds) {
            navigateAndFinish(context, const HomeScreen());
          }
          if (timer.tick >= timerMaxSeconds || !is_screen_on) {
            timer.cancel();
          }
        });
      }
    });
  }

  // configure SDK
  Future<void> configureSDK({
    double? amount,
    int? requestId,
  }) async {
    // configure app
    configureApp();
    // sdk session configurations
    setupSDKSession(amount: amount, requestId: requestId);
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
    int? requestId,
  }) async {
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          transactionCurrency: "SAR",
          amount: '$amount',
          customer: Customer(
              customerId: "",
              // customer id is important to retrieve cards saved for this customer
              email: "${userProvider.profileData?.email}",
              isdNumber: "965",
              number: "${userProvider.profileData?.phone}",
              firstName: "${userProvider.profileData?.name}",
              middleName: "",
              lastName: "",
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
            "customer_id": "${userProvider.profileData?.id}",
            "request_id": "$requestId",
            "charge_type": "credit",
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

    tapSDKResult = await GoSellSdkFlutter.startPaymentSDK;
    loaderController.stopWhenFull();

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
        chargeId = tapSDKResult['token'];
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

    chargeId = tapSDKResult['charge_id'];
  }

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context);
    final UserProvider userDataProvider = Provider.of<UserProvider>(
      context,
    );
    return WillPopScope(
      onWillPop: () async{
        final shouldPop = await showDialog(
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
                        fontWeight: MyFontWeight.semiBold),
                    children: [
                      TextSpan(
                        text: S.of(context).canceled,
                        style: TextStyle(
                          color: const Color(0xFFFF3F48),
                          fontSize: MyFontSize.size20,
                          fontWeight: MyFontWeight.semiBold,
                        ),
                      ),
                      TextSpan(
                        text: S.of(context).areYouSureToGoBack,
                        style: TextStyle(
                          color: const Color(0xFF0F0F0F),
                          fontSize: MyFontSize.size20,
                          fontWeight: MyFontWeight.semiBold,
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
                          userDataProvider.timer!.cancel();
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
        return shouldPop!;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          withArrow: false,
          title: S.of(context).requestDetails,
          customizePopButton: IconButton(
            icon: SvgPicture.asset(
              intlAr.Intl.getCurrentLocale() == 'en'
                  ? 'assets/svg/arrow-left.svg'
                  : 'assets/svg/arrow-right.svg',
              color: MyApp.themeMode(context) ? Colors.white : Colors.black,
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
                              fontWeight: MyFontWeight.semiBold),
                          children: [
                            TextSpan(
                              text: S.of(context).canceled,
                              style: TextStyle(
                                color: const Color(0xFFFF3F48),
                                fontSize: MyFontSize.size20,
                                fontWeight: MyFontWeight.semiBold,
                              ),
                            ),
                            TextSpan(
                              text: S.of(context).areYouSureToGoBack,
                              style: TextStyle(
                                color: const Color(0xFF0F0F0F),
                                fontSize: MyFontSize.size20,
                                fontWeight: MyFontWeight.semiBold,
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
                                userDataProvider.timer!.cancel();
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
                            child:
                                TextWidget(text: S.of(context).noDataAvailable)))
                    : Padding(
                        padding:
                            symmetricEdgeInsets(horizontal: 24, vertical: 19),
                        child: Column(
                          children: [
                            timerTextWidget(),
                            verticalSpace(20),
                            SummaryRequestDetails(
                                cameFromOtherServices:
                                    widget.cameFromOtherServices,
                                cameFromMonthlyPackage:
                                    widget.cameFromMonthlyPackage,
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
                                      backgroundColorDark: requestServicesProvider
                                              .selectedCashPayment
                                          ? AppColor.lightGrey
                                          : Colors.transparent,
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
                                              'assets/images/cash.png',
                                              color: MyApp.themeMode(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
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
                                      backgroundColorDark: requestServicesProvider
                                              .selectedCreditCardPayment
                                          ? AppColor.lightGrey
                                          : Colors.transparent,
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
                                              'assets/images/card.png',
                                              color: MyApp.themeMode(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                          horizontalSpace(10),
                                          TextWidget(
                                            text: S.of(context).creditCard,
                                            textSize: MyFontSize.size12,
                                            fontWeight: MyFontWeight.semiBold,
                                          ),
                                          const Spacer(),
                                          CustomSizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Image.asset(
                                                'assets/images/Mastercard.png',
                                              )),
                                          horizontalSpace(2),
                                          CustomSizedBox(
                                              width: 26,
                                              height: 26,
                                              child: Image.asset(
                                                  'assets/images/Visa.png')),
                                          horizontalSpace(4),
                                          CustomSizedBox(
                                              width: 26,
                                              height: 26,
                                              child: Image.asset(
                                                'assets/images/mada.png',
                                                color: MyApp.themeMode(context)
                                                    ? Colors.white
                                                    : null,
                                              )),
                                        ],
                                      ),
                                    ),
/*
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
*/
                                    Visibility(
                                      visible: Platform.isIOS,
                                      child: Column(
                                        children: [
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
                                                    'assets/images/apple.png',
                                                    color:
                                                        MyApp.themeMode(context)
                                                            ? Colors.white
                                                            : Colors.black,
                                                  ),
                                                ),
                                                horizontalSpace(10),
                                                TextWidget(
                                                  text: S.of(context).applePay,
                                                  textSize: MyFontSize.size12,
                                                  fontWeight:
                                                      MyFontWeight.semiBold,
                                                ),
                                              ],
                                            ),
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
                                      onTap: () {
                                        navigateTo(
                                          context,
                                          const BankTransferMethod(),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          CustomSizedBox(
                                            height: 24,
                                            width: 24,
                                            child: Image.asset(
                                              'assets/images/bank.png',
                                              color: MyApp.themeMode(context)
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
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
                                    text:
                                        '${requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].customerDetails?.balance} ${S.of(context).sr}',
                                    textSize: MyFontSize.size14,
                                    fontWeight: MyFontWeight.semiBold,
                                    color: const Color(0xFF0084DF),
                                  ),
                                  horizontalSpace(10),
/*
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
                                                  fontWeight:
                                                      MyFontWeight.semiBold,
                                                  colorDark: Colors.black,
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
*/
                                  const Spacer(),
                                  CustomContainer(
                                    height: 20,
                                    onTap: () {
                                      double.parse(requestServicesProvider
                                                  .updatedRequestDetailsData!
                                                  .customer!
                                                  .vehicle![0]
                                                  .customerDetails!
                                                  .balance!) <=
                                              requestServicesProvider
                                                  .totalAmountAfterDiscount!
                                          ? showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  content: Padding(
                                                    padding: onlyEdgeInsets(
                                                        top: 40,
                                                        bottom: 5,
                                                        end: 38,
                                                        start: 38),
                                                    child: TextWidget(
                                                      textAlign: TextAlign.center,
                                                      text:
                                                          '${S.of(context).youNeedToPay} ${(requestServicesProvider.totalAmountAfterDiscount! - double.parse(requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].customerDetails!.balance!)).toStringAsFixed(2)} ${S.of(context).cashOrChooseAnotherPayment}',
                                                      textSize: MyFontSize.size15,
                                                      height: 1.5,
                                                      fontWeight:
                                                          MyFontWeight.semiBold,
                                                      colorDark: Colors.black,
                                                    ),
                                                  ),
                                                  actions: [
                                                    Padding(
                                                      padding: symmetricEdgeInsets(horizontal: 5,vertical: 20) ,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: DefaultButton(
                                                              height: 32,
                                                              text: S.of(context).ok,
                                                              fontSize: MyFontSize.size15,
                                                              onPressed: () {
                                                                requestServicesProvider
                                                                    .selectWalletPayment(
                                                                        !requestServicesProvider
                                                                            .selectedWalletPayment);
                                                                Navigator.pop(context);
                                                              },
                                                            ),
                                                          ),
                                                          horizontalSpace(10),
                                                          Expanded(
                                                            child: DefaultButton(
                                                              height: 32,
                                                              fontSize: MyFontSize.size14,
                                                              text:
                                                                  S.of(context).cancel,
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              backgroundColor: AppColor.textRed,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : requestServicesProvider
                                              .selectWalletPayment(
                                                  !requestServicesProvider
                                                      .selectedWalletPayment);
                                    },
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: const Color(0xFF007FD8),
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 8,
                                        child: CircleAvatar(
                                          backgroundColor: requestServicesProvider
                                                  .selectedWalletPayment
                                              ? const Color(0xFF007FD8)
                                              : AppColor.white,
                                          radius: 6,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            verticalSpace(22),
                            CustomContainer(
                              width: 345,
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
                                              '${requestServicesProvider.updatedRequestDetailsData!.amount!} ${S.of(context).sr}',
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
                                              "${requestServicesProvider.updatedRequestDetailsData!.tax!} ${S.of(context).sr}",
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
                                          textSize: MyFontSize.size12,
                                          fontWeight: MyFontWeight.semiBold,
                                        ),
                                        CustomContainer(
                                          width: 120,
                                          height: 35,
                                          padding: onlyEdgeInsets(bottom: 0,top: 0),
                                          radiusCircular: 3,
                                          backgroundColor: AppColor.buttonGrey,
                                          borderColor: AppColor.boldGrey,
                                          alignment: Alignment.center,
                                          child: Center(
                                            child: DefaultFormField(
                                              controller: requestServicesProvider
                                                  .discountCodeController,
                                              withBorder: false,
                                              textInputAction:
                                                  TextInputAction.done,
                                              textColor: MyApp.themeMode(context)
                                                  ? requestServicesProvider
                                                              .couponData ==
                                                          null
                                                      ? Colors.white
                                                      : AppColor.primary
                                                  : Colors.black,
                                              hintText: '',
                                              enabled: requestServicesProvider
                                                      .couponData ==
                                                  null,
                                              height: 80,
                                              padding: onlyEdgeInsets(bottom: 5,start: 5, top: 3),
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
                                                      .checkOfferCoupon(
                                                    context,
                                                    requestId: requestServicesProvider
                                                        .updatedRequestDetailsData!
                                                        .id!,
                                                    offerCode:
                                                        requestServicesProvider
                                                            .discountCodeController
                                                            .text,
                                                    employeeId:
                                                        requestServicesProvider
                                                            .updatedRequestDetailsData!
                                                            .employee!
                                                            .id,
                                                  );
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
                                            colorDark: requestServicesProvider
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
                                              "${requestServicesProvider.couponData != null ? requestServicesProvider.updatedRequestDetailsData!.discountAmount.toStringAsFixed(2) : 0} ${S.of(context).sr}",
                                          textSize: MyFontSize.size12,
                                          fontWeight: MyFontWeight.medium,
                                          color: const Color(0xFF383838),
                                        ),
                                      ],
                                    ),
                                    Visibility(
                                      visible: requestServicesProvider.selectedWalletPayment,
                                      child: Column(children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(vertical: 20),
                                        child: Row(
                                          children: [
                                            TextWidget(
                                              text: S.of(context).wallet,
                                              textSize: MyFontSize.size14,
                                              fontWeight: MyFontWeight.semiBold,
                                            ),
                                            const Spacer(),
                                            TextWidget(
                                              text:
                                              "- ${double.parse(requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].customerDetails!.balance!) <=
                                                  requestServicesProvider.totalAmountAfterDiscount!
                                                  ? double.parse(requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].customerDetails!.balance!)
                                                  : requestServicesProvider.totalAmountAfterDiscount! } ${S.of(context).sr}",
                                              textSize: MyFontSize.size12,
                                              fontWeight: MyFontWeight.medium,
                                              color: const Color(0xFF383838),
                                            ),
                                          ],
                                        ),
                                      )
                                      ],),
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
                                              '${requestServicesProvider.totalAmountAfterDiscount != null ? requestServicesProvider.selectedWalletPayment
                                                  ? double.parse(requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].customerDetails!.balance!) <=
                                                  requestServicesProvider.totalAmountAfterDiscount!
                                                  ? (requestServicesProvider.totalAmountAfterDiscount! - double.parse(requestServicesProvider.updatedRequestDetailsData!.customer!.vehicle![0].customerDetails!.balance!)).toStringAsFixed(2)
                                                  : '0'
                                                  : requestServicesProvider.totalAmountAfterDiscount!.toStringAsFixed(2) : ''} ${S.of(context).sr}',
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
                              backgroundColor:
                                  (requestServicesProvider.selectedCashPayment ||
                                          requestServicesProvider
                                              .selectedCreditCardPayment ||
                                          requestServicesProvider
                                              .selectedWalletPayment)
                                      ? AppColor.primary
                                      : const Color(0xFFB6B6B6),
                              text: S.of(context).confirmAndPay,
                              onPressed: () async {
                                if (requestServicesProvider.selectedCashPayment) {
                                  if (requestServicesProvider
                                      .selectedWalletPayment) {
                                    if (requestServicesProvider
                                            .updatedRequestDetailsData!
                                            .totalAmount >
                                        double.parse(requestServicesProvider
                                            .updatedRequestDetailsData!
                                            .customer!
                                            .vehicle![0]
                                            .customerDetails!
                                            .balance!)) {
                                      AppLoader.showLoader(context);
                                      await requestServicesProvider
                                          .submitFinialRequest(
                                              requestId: requestServicesProvider
                                                  .updatedRequestDetailsData!.id!,
                                              payBy: 'cash',
                                              walletAmount: requestServicesProvider
                                                          .updatedRequestDetailsData!
                                                          .totalAmount >
                                                      double.parse(
                                                          requestServicesProvider
                                                              .updatedRequestDetailsData!
                                                              .customer!
                                                              .vehicle![0]
                                                              .customerDetails!
                                                              .balance!)
                                                  ? double.parse(
                                                      requestServicesProvider
                                                          .updatedRequestDetailsData!
                                                          .customer!
                                                          .vehicle![0]
                                                          .customerDetails!
                                                          .balance!)
                                                  : int.parse(requestServicesProvider
                                                      .updatedRequestDetailsData!
                                                      .totalAmount))
                                          .then((value) async {
                                        AppLoader.stopLoader();

                                        if (value.status == Status.success) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(S
                                                .of(context)
                                                .submitRequestSuccess),
                                            duration: const Duration(seconds: 3),
                                            backgroundColor: Colors.green,
                                            dismissDirection: DismissDirection.up,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            margin: EdgeInsets.only(
                                                bottom: 45.h,
                                                left: 10,
                                                right: 10),
                                          ));
                                          userDataProvider.timer!.cancel();
                                          navigateAndFinish(
                                              context,
                                              const HomeScreen(
                                                cameFromNewRequest: true,
                                              ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text('${value.message}'),
                                            duration: const Duration(seconds: 3),
                                            backgroundColor: Colors.red,
                                            dismissDirection:
                                                DismissDirection.horizontal,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            margin: EdgeInsets.only(
                                                bottom: 45.h,
                                                left: 10,
                                                right: 10),
                                          ));
                                        }
                                      });
                                    } else {
                                      CustomSnackBars.failureSnackBar(
                                          context,
                                          S
                                              .of(context)
                                              .youNeedToSelectOnlyCashOrWallet);
                                    }
                                  } else {
                                    AppLoader.showLoader(context);
                                    await requestServicesProvider
                                        .submitFinialRequest(
                                      requestId: requestServicesProvider
                                          .updatedRequestDetailsData!.id!,
                                      payBy: 'cash',
                                    )
                                        .then((value) async {
                                      AppLoader.stopLoader();
                                      if (value.status == Status.success) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              S.of(context).submitRequestSuccess),
                                          duration: const Duration(seconds: 3),
                                          backgroundColor: Colors.green,
                                          dismissDirection: DismissDirection.up,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          margin: EdgeInsets.only(
                                              bottom: 45.h, left: 10, right: 10),
                                        ));
                                        userDataProvider.timer!.cancel();
                                        navigateAndFinish(
                                            context,
                                            const HomeScreen(
                                              cameFromNewRequest: true,
                                            ));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('${value.message}'),
                                          duration: const Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                          dismissDirection:
                                              DismissDirection.horizontal,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          margin: EdgeInsets.only(
                                              bottom: 45.h, left: 10, right: 10),
                                        ));
                                      }
                                    });
                                  }
                                } else if (requestServicesProvider
                                    .selectedCreditCardPayment) {
                                  if (requestServicesProvider
                                      .selectedWalletPayment) {
                                    if (requestServicesProvider
                                            .updatedRequestDetailsData!
                                            .totalAmount >
                                        double.parse(requestServicesProvider
                                            .updatedRequestDetailsData!
                                            .customer!
                                            .vehicle![0]
                                            .customerDetails!
                                            .balance!)) {
                                      AppLoader.showLoader(context);
                                      await setupSDKSession(
                                        amount: requestServicesProvider
                                            .totalAmountAfterDiscount!
                                            .toDouble() - double.parse(requestServicesProvider
                                            .updatedRequestDetailsData!
                                            .customer!
                                            .vehicle![0]
                                            .customerDetails!
                                            .balance!),
                                        requestId: requestServicesProvider
                                            .updatedRequestDetailsData!.id!,
                                      );
                                      await startSDK();
                                      if (sdkStatus == "SUCCESS") {
                                        await requestServicesProvider
                                            .creditRequestPayment(
                                          chargeId: chargeId,
                                        )
                                            .then((value) async {
                                              await requestServicesProvider.submitFinialRequest(
                                                  requestId: requestServicesProvider
                                                      .updatedRequestDetailsData!.id!,
                                                  payBy: 'credit_card',
                                                  walletAmount: double.parse(
                                                      requestServicesProvider
                                                          .updatedRequestDetailsData!
                                                          .customer!
                                                          .vehicle![0]
                                                          .customerDetails!
                                                          .balance!)).then((value) {
                                                AppLoader.stopLoader();
                                                if (value.status == Status.success) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(S
                                                        .of(context)
                                                        .submitRequestSuccess),
                                                    duration:
                                                    const Duration(seconds: 3),
                                                    backgroundColor: Colors.green,
                                                    dismissDirection:
                                                    DismissDirection.up,
                                                    behavior: SnackBarBehavior.floating,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10.0),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        bottom: 45.h,
                                                        left: 10,
                                                        right: 10),
                                                  ));
                                                  userDataProvider.timer!.cancel();
                                                  navigateAndFinish(
                                                      context,
                                                      const HomeScreen(
                                                        cameFromNewRequest: true,
                                                      ));
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                    content: Text('${value.message}'),
                                                    duration:
                                                    const Duration(seconds: 3),
                                                    backgroundColor: Colors.red,
                                                    dismissDirection:
                                                    DismissDirection.horizontal,
                                                    behavior: SnackBarBehavior.floating,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10.0),
                                                    ),
                                                    margin: EdgeInsets.only(
                                                        bottom: 45.h,
                                                        left: 10,
                                                        right: 10),
                                                  ));
                                                }
                                              });
                                        });
                                      } else {
                                        AppLoader.stopLoader();
                                        CustomSnackBars.failureSnackBar(
                                            context, 'Payment Method Rejected');
                                      }
                                    } else {
                                      CustomSnackBars.failureSnackBar(
                                          context,
                                          S
                                              .of(context)
                                              .youNeedToSelectOnlyCreditOrWallet);
                                    }
                                  } else {
                                    AppLoader.showLoader(context);
                                    await setupSDKSession(
                                      amount: requestServicesProvider
                                          .totalAmountAfterDiscount!
                                          .toDouble(),
                                      requestId: requestServicesProvider
                                          .updatedRequestDetailsData!.id!,
                                    );
                                    await startSDK();
                                    if (sdkStatus == "SUCCESS") {
                                      await requestServicesProvider
                                          .creditRequestPayment(
                                        chargeId: chargeId,
                                      )
                                          .then((value) async {
                                        AppLoader.stopLoader();
                                        if (value.status == Status.success) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(S
                                                .of(context)
                                                .submitRequestSuccess),
                                            duration: const Duration(seconds: 3),
                                            backgroundColor: Colors.green,
                                            dismissDirection: DismissDirection.up,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            margin: EdgeInsets.only(
                                                bottom: 45.h,
                                                left: 10,
                                                right: 10),
                                          ));
                                          userDataProvider.timer!.cancel();
                                          navigateAndFinish(
                                              context,
                                              const HomeScreen(
                                                cameFromNewRequest: true,
                                              ));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text('${value.message}'),
                                            duration: const Duration(seconds: 3),
                                            backgroundColor: Colors.red,
                                            dismissDirection:
                                                DismissDirection.horizontal,
                                            behavior: SnackBarBehavior.floating,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            margin: EdgeInsets.only(
                                                bottom: 45.h,
                                                left: 10,
                                                right: 10),
                                          ));
                                        }
                                      });
                                    } else {
                                      AppLoader.stopLoader();
                                      CustomSnackBars.failureSnackBar(
                                          context, 'Payment Method Rejected');
                                    }
                                  }
                                } else if (requestServicesProvider
                                    .selectedWalletPayment) {
                                  if (requestServicesProvider
                                          .updatedRequestDetailsData!
                                          .totalAmount >
                                      double.parse(requestServicesProvider
                                          .updatedRequestDetailsData!
                                          .customer!
                                          .vehicle![0]
                                          .customerDetails!
                                          .balance!)) {
                                    CustomSnackBars.failureSnackBar(
                                        context,
                                        S
                                            .of(context)
                                            .youNeedToSelectCashWithWallet);
                                  } else {
                                    AppLoader.showLoader(context);
                                    await requestServicesProvider
                                        .submitFinialRequest(
                                      requestId: requestServicesProvider
                                          .updatedRequestDetailsData!.id!,
                                      payBy: 'wallet',
                                    )
                                        .then((value) async {
                                      AppLoader.stopLoader();
                                      if (value.status == Status.success) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              S.of(context).submitRequestSuccess),
                                          duration: const Duration(seconds: 3),
                                          backgroundColor: Colors.green,
                                          dismissDirection: DismissDirection.up,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          margin: EdgeInsets.only(
                                              bottom: 45.h, left: 10, right: 10),
                                        ));
                                        userDataProvider.timer!.cancel();
                                        navigateAndFinish(
                                            context,
                                            const HomeScreen(
                                              cameFromNewRequest: true,
                                            ));
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text('${value.message}'),
                                          duration: const Duration(seconds: 3),
                                          backgroundColor: Colors.red,
                                          dismissDirection:
                                              DismissDirection.horizontal,
                                          behavior: SnackBarBehavior.floating,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          margin: EdgeInsets.only(
                                              bottom: 45.h, left: 10, right: 10),
                                        ));
                                      }
                                    });
                                  }
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
                                            colorDark: Colors.black,
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
                                                  // height: 30,
                                                  fontSize: MyFontSize.size12,
                                                  text: S.of(context).ok,
                                                  textColor: AppColor.black,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  backgroundColor:
                                                      !MyApp.themeMode(context)
                                                          ? const Color(
                                                              0xFFBADEF6)
                                                          : AppColor.subTextGrey,
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
      ),
    );
  }

  GestureDetector timerTextWidget() {
    return GestureDetector(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextWidget(
          text: timerText,
          color: AppColor.lightRed,
          colorDark: AppColor.lightRed,
          textSize: MyFontSize.size18,
          fontWeight: MyFontWeight.bold,
        ),
      ),
    );
  }
}
