import 'dart:async';

import 'package:flash_customer/ui/home/home_screen.dart';
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
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../providers/user_provider.dart';
import '../../../services/authentication_service.dart';
import '../../../utils/snack_bars.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/navigate.dart';
import '../register/register.dart';
import 'otp_cell.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key, required this.phoneNumber, required this.countryCode})
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

  startTimeout([int? milliseconds]) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context,listen: false);

    if (userDataProvider.timer != null) {
      userDataProvider.timer!.cancel();
    }
    var duration = interval;
    userDataProvider.timer = Timer.periodic(duration, (timer) {
      if (is_screen_on && userDataProvider.timer != null) {
        setState(() {
          print(timer.tick);
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

    return Scaffold(
      appBar: CustomAppBar(
        title: 'OTP',
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
                  text: 'Code is send to ',
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.medium),
                  children: [
                    TextSpan(
                      text: '${widget.countryCode} ${widget.phoneNumber}',
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
                  child: ListView.builder(

                    shrinkWrap: true,
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return OtpCell(index: index);
                      }),
                ),
              ),
              verticalSpace(30),
              RichText(
                text: TextSpan(
                  text: 'Didn\'t receive code? ',
                  style: TextStyle(
                      color: AppColor.black,
                      fontSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.medium),
                  children: [
                    TextSpan(
                        text: 'Request Again',
                        style: TextStyle(
                          color: isShow ? AppColor.boldBlue : AppColor.buttonGrey,
                          fontSize: MyFontSize.size14,
                          fontWeight: MyFontWeight.medium,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = isShow ? () {
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
                                CustomSnackBars.successSnackBar(context, 'Code Sent Successfully');
                              } else {
                                CustomSnackBars.somethingWentWrongSnackBar(context);
                              }
                            });
                          } : null
                    ),
                  ],
                ),
              ),
              verticalSpace(150),
              DefaultButton(
                text: S.of(context).continueText,
                width: double.infinity,
                height: 40,
                onPressed: () async {
                  AppLoader.showLoader(context);
                  await auth
                      .checkCode(widget.phoneNumber, widget.countryCode,
                          userDataProvider.otpToString())
                      .then((value) {
                    AppLoader.stopLoader();
                   /* if (value.status == Status.success) {
                      if(userDataProvider.otpToString() == "1234"){
                        navigateTo(context, const HomeScreen());
                      }else{
                        CustomSnackBars.somethingWentWrongSnackBar(context);
                      }
                    }*/
                    navigateTo(context, const HomeScreen());
                  });
                },
              )
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
