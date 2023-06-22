import 'package:flash_customer/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flash_customer/payment/tap_loader/awesome_loader.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:provider/provider.dart';

import '../../models/requestDetailsModel.dart';
import '../../providers/home_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../../providers/transactionHistory_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/font_styles.dart';
import '../../utils/styles/colors.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/data_loader.dart';
import '../widgets/image_editable.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class WalletPayment extends StatefulWidget {
  const WalletPayment({Key? key}) : super(key: key);

  @override
  State<WalletPayment> createState() => _WalletPaymentState();
}

class _WalletPaymentState extends State<WalletPayment> {
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
    final TransactionHistoryProvider transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    super.initState();
    payButtonColor = Color(0xff2ace00);
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    configureSDK(
        /*amount: double.parse(transactionHistoryProvider.rechargeAmountController!.text)*/);
  }

  void loadData() async {
    final TransactionHistoryProvider transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    await transactionHistoryProvider.getTransactionHistory();
  }

  // configure SDK
  Future<void> configureSDK(/*{required double amount}*/) async {
    // configure app
    configureApp();
    // sdk session configurations
    setupSDKSession(/*amount: amount*/);
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
  Future<void> setupSDKSession(/*{required double amount}*/) async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          transactionCurrency: "SAR",
          amount: '500',
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
          paymentItems: <PaymentItem>[
            PaymentItem(
                name: "service_item1",
                //TODO : change the price
                amountPerUnit: 258,
                // amountPerUnit: (updatedRequestDetailsData.id!).toDouble(),
                quantity: Quantity(value: 1),
                // quantity: Quantity(value: updatedRequestDetailsData.id!),
                // discount: {
                //   "type": "F",
                //   "value": 10,
                //   "maximum_fee": 10,
                //   "minimum_fee": 1
                // },
                description: "Item 1 Apple",
                // taxes: [
                //   Tax(
                //       amount: Amount(
                //           type: "F", value: 10, minimumFee: 1, maximumFee: 10),
                //       name: "tax1",
                //       description: "tax describtion")
                // ],
                totalAmount: 300),
          ],
          // List of taxes
          taxes: [],
          // taxes: [
          //   Tax(
          //       amount:
          //           Amount(type: "F", value: 10, minimumFee: 1, maximumFee: 10),
          //       name: "tax1",
          //       description: "tax describtion"),
          //   Tax(
          //       amount:
          //           Amount(type: "F", value: 10, minimumFee: 1, maximumFee: 10),
          //       name: "tax1",
          //       description: "tax describtion")
          // ],
          // List of shippnig
          shippings: [],
          // shippings: [
          //   Shipping(
          //       name: "shipping 1",
          //       amount: 100,
          //       description: "shiping description 1"),
          //   Shipping(
          //       name: "shipping 2",
          //       amount: 150,
          //       description: "shiping description 2")
          // ],
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
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final TransactionHistoryProvider transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context);

/*
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Complete Payment'),
          backgroundColor: Colors.grey,
        ),
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 300,
                left: 18,
                right: 18,
                child: Text(
                  "Status: [$sdkStatus $responseID ]",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Roboto",
                    fontStyle: FontStyle.normal,
                    fontSize: 15.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                bottom: Platform.isIOS ? 0 : 10,
                left: 18,
                right: 18,
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    clipBehavior: Clip.hardEdge,
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(payButtonColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    onPressed: startSDK,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'PAY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
*/
    return Scaffold(
      backgroundColor: MyApp.themeMode(context) ? AppColor.boldDark : null,
      appBar: CustomAppBar(
        title: 'My Wallet',
        // backgroundColor: AppColor.lightBabyBlue,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          CustomContainer(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(44),
                bottomRight: Radius.circular(44)),
            width: double.infinity,
            backgroundColorDark: AppColor.darkScaffoldColor,
            borderColorDark: Colors.transparent,
            height: 211,
            backgroundColor: AppColor.lightBabyBlue,
            child: Column(
              children: [
                // const CircleAvatar(
                //   backgroundColor: Color.fromRGBO(0, 107, 182, 0.53),
                //   radius: 55,
                //   child: CircleAvatar(
                //     radius: 49,
                //     backgroundImage: AssetImage(
                //       'assets/images/profile.png',
                //     ),
                //   ),
                // ),
                const ImageEditable(
                  imageUrl: '',
                ),
                verticalSpace(14),
                TextWidget(
                  text: userProvider.userName == ""
                      ? "User Name"
                      : userProvider.userName ?? "User Name",
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size16,
                ),
                verticalSpace(10),
                TextWidget(
                  text: '${userProvider.userBalance} SR',
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size14,
                  color: const Color(0xFF00567B),
                ),
              ],
            ),
          ),
          verticalSpace(32),
          CustomContainer(
            borderColorDark: Colors.transparent,
            child: Padding(
              padding: symmetricEdgeInsets(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextWidget(
                        text: 'Recharge Amount',
                        textSize: MyFontSize.size14,
                        fontWeight: MyFontWeight.bold,
                      ),
                      horizontalSpace(18),
                      Expanded(
                        child: CustomContainer(
                          height: 30,
                          radiusCircular: 3,
                          backgroundColor: AppColor.buttonGrey,
                          borderColor: AppColor.boldGrey,
                          alignment: Alignment.center,
                          child: Center(
                            child: DefaultFormField(
                              controller: transactionHistoryProvider
                                  .rechargeAmountController,
                              withBorder: false,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              textInputAction: TextInputAction.done,
                              hintText: '',
                              padding: symmetricEdgeInsets(
                                  vertical: 8, horizontal: 5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(28),
                  SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      clipBehavior: Clip.hardEdge,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(payButtonColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        startSDK();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'PAY',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DefaultButton(
                      text: 'Pay',
                      onPressed: () {
                        /*if(transactionHistoryProvider.rechargeAmountController == null){
                          CustomSnackBars.failureSnackBar(context, 'Please, Enter Amount First',);
                        }else{
                          AppLoader.showLoader(context);
                          transactionHistoryProvider.chargingWalletUrl(
                            amount: int.parse(transactionHistoryProvider.rechargeAmountController!.text,),
                            payBy: 'credit_card',
                          ).then((value) => AppLoader.stopLoader());
                        }*/
                        AppLoader.showLoader(context);
                        transactionHistoryProvider
                            .chargingWalletUrl(
                          amount: /*int.parse(transactionHistoryProvider.rechargeAmountController!.text,)*/ 30,
                          payBy: 'credit_card',
                        )
                            .then((value) {
                          AppLoader.stopLoader();
                          homeProvider.launchExpectedURL(
                            expectedUrl:
                                '${transactionHistoryProvider.chargeWalletUrl!.chargeUrl}',
                          );
                        });
                      },
                      width: 217,
                      height: 40),
                  verticalSpace(45),
                  Row(
                    children: [
                      TextWidget(
                        text: 'Transactions history',
                        textSize: MyFontSize.size14,
                        fontWeight: MyFontWeight.bold,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: TextWidget(
                          text: 'See All',
                          textSize: MyFontSize.size10,
                          fontWeight: MyFontWeight.medium,
                          color: AppColor.boldBlue,
                        ),
                      )
                    ],
                  ),
                  verticalSpace(6),
                  transactionHistoryProvider.transactionData == null
                      ? const DataLoader()
                      : CustomSizedBox(
                          height: 300,
                          child: ListView.separated(
                            itemCount: transactionHistoryProvider
                                .transactionData!.collection!.length,
                            itemBuilder: (context, index) => CustomContainer(
                              height: 60,
                              width: 345,
                              radiusCircular: 4,
                              padding: symmetricEdgeInsets(
                                  horizontal: 16, vertical: 12),
                              /*backgroundColor: int.parse(transactionHistoryProvider
                                          .transactionData!
                                          .collection![index]
                                          .amount!) >=
                                      0
                                  ? AppColor.acceptGreen
                                  : AppColor.canceledRed,*/
                              backgroundColor: AppColor.acceptGreen,
                              child: Center(
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: transactionHistoryProvider
                                              .transactionData!
                                              .collection![index]
                                              .type!,
                                          textSize: MyFontSize.size14,
                                          fontWeight: MyFontWeight.medium,
                                        ),
                                        verticalSpace(9),
                                        Row(
                                          children: [
                                            CustomSizedBox(
                                              width: 8,
                                              height: 8,
                                              child: SvgPicture.asset(
                                                  'assets/svg/clock.svg'),
                                            ),
                                            horizontalSpace(4),
                                            TextWidget(
                                              text: '18/3/2023  -  ',
                                              textSize: MyFontSize.size8,
                                              fontWeight: MyFontWeight.regular,
                                              color: AppColor.subTitleGrey,
                                            ),
                                            TextWidget(
                                              text: '11:06 PM',
                                              textSize: MyFontSize.size8,
                                              fontWeight: MyFontWeight.regular,
                                              color: AppColor.subTitleGrey,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    TextWidget(
                                      text: transactionHistoryProvider
                                          .transactionData!
                                          .collection![index]
                                          .amount!,
                                      textSize: MyFontSize.size14,
                                      fontWeight: MyFontWeight.semiBold,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) =>
                                verticalSpace(14),
                          ),
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
