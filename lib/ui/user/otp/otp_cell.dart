import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/app_loader.dart';
import '../../../utils/enum/statuses.dart';
import '../../../utils/snack_bars.dart';
import '../../../utils/styles/colors.dart';
import '../../home/home_screen.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_text_form.dart';
import '../../widgets/navigate.dart';

class OtpCell extends StatelessWidget {
  final int index;

  final String? phoneNumber;
  final String? countryCode;
  const OtpCell({Key? key, required this.index, this.phoneNumber, this.countryCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);

    return CustomContainer(
      width: 48,
      height: 48,
      padding: symmetricEdgeInsets(horizontal: 8),
      margin: onlyEdgeInsets(end: index != 4 ? 16 : 0),
      borderColor: AppColor.borderBlue,
      child: Center(
        child: CustomTextForm(
          padding: 6,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.phone,
          hintText: '...',
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) async{
            if(index == 3) {
              if (value.length == 1) {
                userDataProvider.otp[index] = value;
                FocusScope.of(context).nextFocus();
                print('ddddddddddd');

                  AppLoader.showLoader(context);
                 await userDataProvider
                      .checkCode(phoneNumber: phoneNumber!, countryCode: countryCode!, otp: userDataProvider.otpToString())
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
              }
            }else{
              if (value.length == 1) {
                print('mmmmmmmmmmm');
                userDataProvider.otp[index] = value;
                FocusScope.of(context).nextFocus();
              }
            }

          },
        ),
      ),
    );
  }
}
