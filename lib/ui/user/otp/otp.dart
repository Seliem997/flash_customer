import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/widgets/custom_bar_widget.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/colors.dart';
import 'package:flash_customer/utils/enum/statuses.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../providers/user_provider.dart';
import '../../../services/authentication_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/navigate.dart';
import '../register/register.dart';
import '../widgets/otp_cell.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key, required this.phoneNumber, required this.countryCode})
      : super(key: key);

  final String phoneNumber;
  final String countryCode;
  final AuthenticationService auth = AuthenticationService();

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
                      text: '$countryCode $phoneNumber',
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
              TextWidget(
                text: '2:00',
                color: AppColor.lightRed,
                textSize: MyFontSize.size18,
                fontWeight: MyFontWeight.bold,
              ),
              verticalSpace(28),
              Padding(
                padding: onlyEdgeInsets(start: 21),
                child: CustomSizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ListView.builder(
                      itemCount: 5,
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
                          color: AppColor.boldBlue,
                          fontSize: MyFontSize.size14,
                          fontWeight: MyFontWeight.medium,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // navigateTo(context, const RegisterPhoneNumber());
                          }),
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
                      .checkCode(phoneNumber, countryCode,
                          userDataProvider.otpToString())
                      .then((value) {
                    AppLoader.stopLoader();
                    if (value.status == Status.success) {
                      navigateTo(context, HomeScreen());
                    }
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
