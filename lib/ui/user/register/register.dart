import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flash_customer/main.dart';
import 'package:flash_customer/services/authentication_service.dart';
import 'package:flash_customer/ui/widgets/custom_bar_widget.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/custom_form_field.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flash_customer/utils/enum/statuses.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flash_customer/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart' as intlar;

import '../../../generated/l10n.dart';
import '../../widgets/navigate.dart';
import '../otp/otp.dart';

class RegisterPhoneNumber extends StatefulWidget {
  const RegisterPhoneNumber({Key? key}) : super(key: key);

  @override
  State<RegisterPhoneNumber> createState() => _RegisterPhoneNumberState();
}

class _RegisterPhoneNumberState extends State<RegisterPhoneNumber> {
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode =
      const CountryCode(name: "Saudi Arabia", code: "SA", dialCode: "+966");
  late TextEditingController phoneController;
  final formKey = GlobalKey<FormState>();
  final AuthenticationService auth = AuthenticationService();

  @override
  void initState() {
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).registerOrLogin,
        // withArrow: false,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: symmetricEdgeInsets(vertical: 57, horizontal: 24),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/svg/register.svg'),
                      verticalSpace(20),
                      CustomSizedBox(
                        width: 200,
                        child: TextWidget(
                          text: S
                              .of(context)
                              .youWillReceiveA4DigitalCodeToVerifyNext,
                          textSize: MyFontSize.size15,
                          fontWeight: MyFontWeight.medium,
                          textAlign: TextAlign.center,
                          height: 1.3,
                        ),
                      ),
                      verticalSpace(45),
                      Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: TextWidget(
                            text: S.of(context).enterYourPhoneNumber,
                            textSize: MyFontSize.size12,
                            fontWeight: MyFontWeight.regular,
                          )),
                      verticalSpace(16),
                      Row(
                        textDirection: TextDirection.ltr,
                      children: [
                          CustomContainer(
                            padding: symmetricEdgeInsets(horizontal: 4),
                            width: 72,
                            height: 48,
                            radiusCircular: 5,
                            alignment: Alignment.center,
                            borderColor: AppColor.borderBlue,
                            onTap: () async {
                              setState(() {
                                countryCode = const CountryCode(name: "Saudi Arabia", code: "SA", dialCode: "+966");
                              });
                            },
                            child: Row(
                              textDirection: TextDirection.ltr,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomSizedBox(
                                  width: 20,
                                  height: 14,
                                  child: countryCode != null
                                      ? countryCode!.flagImage
                                      : const SizedBox(),
                                ),
                                horizontalSpace(2),
                                TextWidget(
                                  text: countryCode != null
                                      ? countryCode!.dialCode
                                      : '',
                                  textSize: 12,
                                  fontWeight: MyFontWeight.regular,
                                ),
                              ],
                            ),
                          ),
                          horizontalSpace(6),
                          Expanded(
                              child: DefaultFormField(
                            hintText: '545548879',
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            padding: onlyEdgeInsets(start: 15, top: 0, bottom: 8),
                            textInputAction: TextInputAction.done,
                            letterSpacing: 3,
                            textHeight: 0.8,
                            textColor: MyApp.themeMode(context) ? Colors.white : Colors.black,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (v) {
                              if (v!.isEmpty) {
                                CustomSnackBars.failureSnackBar(context,
                                    S.of(context).phoneNumberCannotBeEmpty);
                                return "";
                              } else if (v.length < 7) {
                                CustomSnackBars.failureSnackBar(
                                    context,
                                    S.of(context).phoneNumberLengthCanNotBeLessThan7Digits);
                                return "";
                              }
                            },
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(10),
              DefaultButton(
                height: 48,
                width: 345,
                fontSize: MyFontSize.size18,
                fontWeight: MyFontWeight.bold,
                radiusCircular: 6,
                text: S.of(context).confirm,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    AppLoader.showLoader(context);
                    auth
                        .registerOrLogin(
                      (phoneController.text)[0] == '0' ? (phoneController.text).substring(1) : (phoneController.text) ,
                      countryCode!.dialCode,
                    )
                        .then((value) {
                      AppLoader.stopLoader();
                      if (value.status == Status.success) {
                        navigateTo(
                            context,
                            OTPScreen(
                                countryCode: countryCode!.dialCode,
                                phoneNumber: (phoneController.text)[0] == '0' ? (phoneController.text).substring(1) : (phoneController.text),));
                      } else {
                        CustomSnackBars.failureSnackBar(context, value.message);
                      }
                    });
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
