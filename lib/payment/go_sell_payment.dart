import 'dart:async';
import 'dart:io';

import 'package:flash_customer/payment/tap_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';

class GoSellPayment extends StatefulWidget {
  const GoSellPayment({Key? key}) : super(key: key);

  @override
  State<GoSellPayment> createState() => _GoSellPaymentState();
}

class _GoSellPaymentState extends State<GoSellPayment> {
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
    super.initState();
    payButtonColor = Color(0xff2ace00);
    configureSDK();
  }

  // configure SDK
  Future<void> configureSDK() async {
    // configure app
    configureApp();
    // sdk session configurations
    setupSDKSession();
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

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setupSDKSession() async {
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
                amountPerUnit: 500,
                quantity: Quantity(value: 1),
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
  }
}