import 'package:flash_customer/main.dart';
import 'package:flash_customer/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_sell_sdk_flutter/go_sell_sdk_flutter.dart';
import 'package:go_sell_sdk_flutter/model/models.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../models/requestDetailsModel.dart';
import '../../providers/home_provider.dart';
import '../../providers/requestServices_provider.dart';
import '../../providers/transactionHistory_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/app_loader.dart';
import '../../utils/cache_helper.dart';
import '../../utils/enum/date_formats.dart';
import '../../utils/enum/shared_preference_keys.dart';
import '../../utils/enum/statuses.dart';
import '../../utils/font_styles.dart';
import '../../utils/styles/colors.dart';
import '../payment/tap_loader/awesome_loader.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/data_loader.dart';
import '../widgets/image_editable.dart';
import '../widgets/no_data_place_holder.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class WalletPayment extends StatefulWidget {
  const WalletPayment({Key? key}) : super(key: key);

  @override
  State<WalletPayment> createState() => _WalletPaymentState();
}

class _WalletPaymentState extends State<WalletPayment> {
  late Map<dynamic, dynamic> tapSDKResult;
  String chargeID = "";
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
    payButtonColor = const Color(0xff2ace00);
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    configureSDK(
        /*amount: double.parse(
            transactionHistoryProvider.rechargeAmountController!.text)*/);
  }

  void loadData() async {
    final TransactionHistoryProvider transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    transactionHistoryProvider.isLoading == true;
    await transactionHistoryProvider.getTransactionHistory();
  }

  // configure SDK
  Future<void> configureSDK() async {
    // configure app
    configureApp();
    // startSDK();
    // sdk session configurations
    // setupSDKSession(amount: amount);
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
  Future<void> setupSDKSession({required double amount}) async {
    try {
      GoSellSdkFlutter.sessionConfigurations(
          trxMode: TransactionMode.PURCHASE,
          transactionCurrency: "SAR",
          amount: '$amount',
          customer: Customer(
              customerId: "",
              // customer id is important to retrieve cards saved for this customer
              email: "${CacheHelper.returnData(key: CacheKey.email)}",
              isdNumber: "965",
              number: "${CacheHelper.returnData(key: CacheKey.phoneNumber)}",
              firstName: "${CacheHelper.returnData(key: CacheKey.userName)}",
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
            "customer_id": "${CacheHelper.returnData(key: CacheKey.userNumberId)}",
            "charge_type": "wallet",
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

        chargeID = tapSDKResult['token'];
        break;
    }
  }

  void printSDKResult(String trx_mode) {
    print('$trx_mode status                : ${tapSDKResult['status']}');
    print('$trx_mode Aliiiicode                : ${tapSDKResult['code']}');
    print('$trx_mode chargeID                : ${tapSDKResult['charge_id']}');
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

    chargeID = tapSDKResult['charge_id'];
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final TransactionHistoryProvider transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context);

    return Scaffold(
      backgroundColor: MyApp.themeMode(context) ? AppColor.boldDark : null,
      appBar: CustomAppBar(
        title: S.of(context).myWallet,
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
                ImageEditable(
                  imageUrl: CacheHelper.returnData(key: CacheKey.userImage) ?? '',
                ),
                verticalSpace(14),
                TextWidget(
                  text: userProvider.userName == ""
                      ? S.of(context).userName
                      : userProvider.userName ?? S.of(context).userName,
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size16,
                ),
                verticalSpace(10),
                TextWidget(
                  text: '${userProvider.userBalance}',
                  // text: '${sdkStatus == "SUCCESS" ? (double.parse(userProvider.userBalance!) + double.parse(transactionHistoryProvider.rechargeAmountController!.text)) : userProvider.userBalance} ${S.of(context).sr}',
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
                        text: S.of(context).rechargeAmount,
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
                  DefaultButton(
                      text: S.of(context).pay,
                      onPressed: () async{
                        if(double.parse(transactionHistoryProvider
                            .rechargeAmountController!.text) > 1) {
                          AppLoader.showLoader(context);
                          await setupSDKSession(
                            amount: double.parse(transactionHistoryProvider
                                .rechargeAmountController!.text));
                          startSDK().then((value) async{
                            if(sdkStatus == "SUCCESS"){
                              await transactionHistoryProvider.rechargeWallet(chargeId: chargeID).then((value) {
                                if (value.status == Status.success) {
                                  userProvider.userBalance = transactionHistoryProvider.rechargeWalletData?.newBalance.toString();
                                  CacheHelper.saveData(key: CacheKey.balance, value: transactionHistoryProvider.rechargeWalletData?.newBalance);
                                  print("user balance == ${userProvider.userBalance}");
                                }
                              });
                            }
                            AppLoader.stopLoader();
                          });
                        }else{
                          CustomSnackBars.failureSnackBar(context, "Please Enter a valid Amount");
                        }

                      },
                      width: 217,
                      height: 40),
                  verticalSpace(45),
                  Row(
                    children: [
                      TextWidget(
                        text: S.of(context).transactionsHistory,
                        textSize: MyFontSize.size14,
                        fontWeight: MyFontWeight.bold,
                      ),
                      /*const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: TextWidget(
                          text: S.of(context).seeAll,
                          textSize: MyFontSize.size10,
                          fontWeight: MyFontWeight.medium,
                          color: AppColor.boldBlue,
                        ),
                      )*/
                    ],
                  ),
                  verticalSpace(6),
                  transactionHistoryProvider.isLoading == true
                      ? const DataLoader()
                  : transactionHistoryProvider.transactionData == null
                      ? const DataLoader()
                      : transactionHistoryProvider.transactionData!.collection!.isEmpty
                      ? const CustomSizedBox(
                      height: 300,
                      child: Center(child: NoDataPlaceHolder(useExpand: false,)))
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
                                              text: DateFormat(DFormat.dmy.key)
                                                  .format(DateTime.parse(
                                                      transactionHistoryProvider
                                                          .transactionData!
                                                          .collection![index]
                                                          .createdAt!)),
                                              textSize: MyFontSize.size8,
                                              fontWeight: MyFontWeight.regular,
                                              color: AppColor.subTitleGrey,
                                            ),
                                            horizontalSpace(10),
                                            TextWidget(
                                              text: DateFormat(DFormat.hm.key)
                                                  .format(DateTime.parse(
                                                      transactionHistoryProvider
                                                          .transactionData!
                                                          .collection![index]
                                                          .createdAt!)),
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
