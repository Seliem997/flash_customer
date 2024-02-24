import 'dart:async';

import 'package:flash_customer/ui/widgets/custom_bar_widget.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flash_customer/utils/enum/statuses.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intlAr;
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../main.dart';
import '../../../providers/addresses_provider.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../services/authentication_service.dart';
import '../../../utils/snack_bars.dart';
import '../../home/home_screen.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/navigate.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen(
      {Key? key, required this.phoneNumber, required this.countryCode})
      : super(key: key);

  final String phoneNumber;
  final String countryCode;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final AuthenticationService auth = AuthenticationService();
  final interval = const Duration(seconds: 1);

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  final int timerMaxSeconds = 60 * 2;

  int currentSeconds = 0;

  bool is_screen_on = true;

  bool isShow = false;

  startTimeout([dynamic  milliseconds]) {
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
            isShow = true;
          }
          if (timer.tick >= timerMaxSeconds || !is_screen_on) {
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) => startTimeout());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final AddressesProvider addressesProvider = Provider.of<AddressesProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).otp,
      ),
      body: Padding(
        padding: symmetricEdgeInsets(vertical: 57, horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset('assets/svg/otp.svg'),
              verticalSpace(23),
              RichText(
                text: TextSpan(
                  text: S.of(context).codeIsSendTo,
                  style: TextStyle(
                      color: MyApp.themeMode(context)
                          ? AppColor.white
                          : AppColor.black,
                      fontSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.medium),
                  children: [
                    TextSpan(
                      text: intlAr.Intl.getCurrentLocale() == 'ar' ? ' ${widget.phoneNumber} 966+' : ' ${widget.countryCode} ${widget.phoneNumber}',
                      style: TextStyle(
                        color: const Color(0xFF29A7FF),
                        fontSize: MyFontSize.size14,
                        fontWeight: MyFontWeight.medium,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              timerTextWidget(),
              verticalSpace(28),
              CustomSizedBox(
                height: 50,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      onCompleted: (pin) async{
                          AppLoader.showLoader(context);
                          await userDataProvider
                              .checkCode(
                              phoneNumber: widget.phoneNumber,
                              countryCode: widget.countryCode,
                              otp: pin.toString())
                              .then((value) async{
                            AppLoader.stopLoader();
                            if (value.status == Status.success) {
                              if (value.message != "invalid otp") {
                                userDataProvider.timer!.cancel();
                                if(userDataProvider.statusType != null) {
                                  if(userDataProvider.statusType == 'wash service') {
                                    AppLoader.showLoader(context);
                                    await addressesProvider
                                        .storeAddress(
                                      lat: homeProvider.currentPosition!.latitude,
                                      long: homeProvider.currentPosition!.longitude,
                                    )
                                        .then((value) {
                                      AppLoader.stopLoader();
                                      if (value.status == Status.success) {
                                        navigateAndFinish(context, const HomeScreen(cameFromOTPToVehicles: true,));
                                      } else {
                                        CustomSnackBars.failureSnackBar(
                                            context, '${value.message}');
                                      }
                                    });
                                  }else if(userDataProvider.statusType == 'other service'){
                                    AppLoader.showLoader(context);
                                    await addressesProvider
                                        .storeAddress(
                                      lat: homeProvider.currentPosition!.latitude,
                                      long: homeProvider.currentPosition!.longitude,
                                    )
                                        .then((value) {
                                      if (value.status == Status.success) {
                                        AppLoader.stopLoader();
                                        navigateAndFinish(context, const HomeScreen(cameFromOTPToOther: true,));
                                      } else {
                                        CustomSnackBars.failureSnackBar(
                                            context, '${value.message}');
                                        AppLoader.stopLoader();
                                      }
                                    });
                                  }
                                }else{
                                  navigateTo(context, const HomeScreen());
                                }
                              } else {
                                CustomSnackBars.failureSnackBar(context, value.message);
                              }
                            } else {
                              CustomSnackBars.failureSnackBar(context, value.message);
                            }
                          });


                      },
                    ),
                  ),
                ),
              ),
              verticalSpace(30),
              RichText(
                text: TextSpan(
                  text: S.of(context).didNotReceiveCode,
                  style: TextStyle(
                      color: MyApp.themeMode(context)
                          ? AppColor.white
                          : AppColor.black,
                      fontSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.medium),
                  children: [
                    TextSpan(
                        text: S.of(context).requestAgain,
                        style: TextStyle(
                          color:
                              isShow ? AppColor.boldBlue : AppColor.buttonGrey,
                          fontSize: MyFontSize.size14,
                          fontWeight: MyFontWeight.medium,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = isShow
                              ? () {
                                  AppLoader.showLoader(context);
                                  auth
                                      .registerOrLogin(
                                    widget.phoneNumber,
                                    widget.countryCode,
                                  )
                                      .then((value) {
                                    AppLoader.stopLoader();
                                    startTimeout();
                                    isShow = false;
                                    if (value.status == Status.success) {
                                      CustomSnackBars.successSnackBar(context,
                                          S.of(context).codeSentSuccessfully);
                                    } else {
                                      CustomSnackBars
                                          .somethingWentWrongSnackBar(context);
                                    }
                                  });
                                }
                              : null),
                  ],
                ),
              ),
              verticalSpace(150),
/*
              DefaultButton(
                text: S.of(context).continueText,
                fontSize: MyFontSize.size18,
                width: double.infinity,
                height: 55,
                onPressed: () async {
                  AppLoader.showLoader(context);
                  await userDataProvider
                      .checkCode(phoneNumber: widget.phoneNumber, countryCode: widget.countryCode, otp: userDataProvider.otpToString())
                      .then((value) {
                    AppLoader.stopLoader();
                    if (value.status == Status.success) {
                      if (value.message != "invalid otp") {
                        userDataProvider.timer!.cancel();
                        navigateTo(context, const HomeScreen());
                      } else {
                        CustomSnackBars.failureSnackBar(context, value.message);
                      }
                    } else {
                      CustomSnackBars.failureSnackBar(context, value.message);
                    }
                  });
                },
              )
*/
            ],
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
          textSize: MyFontSize.size18,
          fontWeight: MyFontWeight.bold,
        ),
      ),
    );
  }
}
