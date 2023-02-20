import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flash_customer/ui/widgets/custom_bar_widget.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/custom_form_field.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/colors.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/navigate.dart';
import '../otp/otp.dart';

class RegisterPhoneNumber extends StatefulWidget {
  const RegisterPhoneNumber({Key? key}) : super(key: key);

  @override
  State<RegisterPhoneNumber> createState() => _RegisterPhoneNumberState();
}

class _RegisterPhoneNumberState extends State<RegisterPhoneNumber> {
  final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;
  @override
  void initState() {
    // loadData();
    super.initState();
  }

  // void loadData() async {
  //   final code = await countryPicker.showPicker(context: context);
  //   // Null check
  //   if (code != null) {
  //     setState(() {
  //       countryCode = code;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Register',
      ),
      body: Padding(
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
                      width: 182,
                      child: TextWidget(
                        text:
                            'You will receive a 4 digital code to verify next.',
                        textSize: MyFontSize.size15,
                        fontWeight: MyFontWeight.medium,
                      ),
                    ),
                    verticalSpace(20),
                    TextWidget(
                      text: '10:00',
                      color: AppColor.lightRed,
                      textSize: MyFontSize.size18,
                      fontWeight: MyFontWeight.bold,
                    ),
                    verticalSpace(22),
                    Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: TextWidget(
                          text: 'Enter Your Phone Number',
                          textSize: 13,
                          fontWeight: MyFontWeight.regular,
                        )),
                    verticalSpace(16),
                    Row(
                      children: [
                        CustomContainer(
                          padding: symmetricEdgeInsets(horizontal: 4),
                          width: 72,
                          height: 48,
                          radiusCircular: 5,
                          borderColor: AppColor.borderBlue,
                          onTap: () async {
                            final code = await countryPicker.showPicker(
                                context: context);
                            setState(() {
                              countryCode = code;
                            });
                          },
                          child: Row(
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
                                textSize: MyFontSize.size12,
                                fontWeight: MyFontWeight.regular,
                              ),
                            ],
                          ),
                        ),
                        horizontalSpace(6),
                        Expanded(
                            child: DefaultFormField(
                          hintText: 'phone Number',
                          keyboardType: TextInputType.phone,
                              textInputAction: TextInputAction.done,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly,
                              ],
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
              text: 'Confirm',
              onPressed: () {
                navigateTo(context, const OTPScreen());
              },
            ),
          ],
        ),
      ),
    );
  }
}
