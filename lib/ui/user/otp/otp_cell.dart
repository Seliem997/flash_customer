import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../providers/addresses_provider.dart';
import '../../../providers/home_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../utils/app_loader.dart';
import '../../../utils/enum/statuses.dart';
import '../../../utils/snack_bars.dart';
import '../../../utils/styles/colors.dart';
import '../../home/home_screen.dart';
import '../../services/other_services_screen.dart';
import '../../vehicles/vehicles_type.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_text_form.dart';
import '../../widgets/navigate.dart';

class OtpCell extends StatelessWidget {
  final int index;

  final String? phoneNumber;
  final String? countryCode;
  const OtpCell(
      {Key? key, required this.index, this.phoneNumber, this.countryCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userDataProvider = Provider.of<UserProvider>(context);
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final AddressesProvider addressesProvider =
    Provider.of<AddressesProvider>(context);

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
          onChanged: (value) async {
            if (index == 3) {
              if (value.length == 1) {
                userDataProvider.otp[index] = value;
                FocusScope.of(context).nextFocus();

                AppLoader.showLoader(context);
                await userDataProvider
                    .checkCode(
                        phoneNumber: phoneNumber!,
                        countryCode: countryCode!,
                        otp: userDataProvider.otpToString())
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
                              navigateTo(context, const VehicleTypes());
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
                              navigateTo(context, const OtherServices());
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
              }
            } else {
              if (value.length == 1) {
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
