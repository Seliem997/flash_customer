import 'package:flash_customer/providers/addresses_provider.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/snack_bars.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/home_provider.dart';
import '../../utils/enum/statuses.dart';
import '../../utils/font_styles.dart';
import '../home/home_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class LocationDialog extends StatefulWidget {
  const LocationDialog({Key? key}) : super(key: key);

  @override
  State<LocationDialog> createState() => _LocationDialogState();
}

class _LocationDialogState extends State<LocationDialog> {
  String? addressType;

  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context);
    return Dialog(
      child: CustomContainer(
        width: 321,
        padding: symmetricEdgeInsets(horizontal: 10, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: symmetricEdgeInsets(horizontal: 22),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: TextWidget(
                  text: S.of(context).types,
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size18,
                  colorDark: Colors.black,
                ),
              ),
            ),
            verticalSpace(24),
            RadioListTile(
              title: Row(
                children: [
                  CustomSizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset('assets/images/home_light.png')),
                  horizontalSpace(6),
                  TextWidget(
                    text: S.of(context).home,
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    colorDark: Colors.black,
                    color: const Color(0xFF3F3F46),
                  ),
                ],
              ),
              value: "home",
              groupValue: addressType,
              onChanged: (value) {
                setState(() {
                  addressType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  CustomSizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/svg/work_light.svg',
                    ),
                  ),
                  horizontalSpace(6),
                  TextWidget(
                    text: S.of(context).work,
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    colorDark: Colors.black,
                    color: const Color(0xFF3F3F46),
                  )
                ],
              ),
              value: "work",
              groupValue: addressType,
              onChanged: (value) {
                setState(() {
                  addressType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  CustomSizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/svg/school_light.svg',
                    ),
                  ),
                  horizontalSpace(6),
                  TextWidget(
                    text: S.of(context).school,
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    colorDark: Colors.black,
                    color: const Color(0xFF3F3F46),
                  )
                ],
              ),
              value: "school",
              groupValue: addressType,
              onChanged: (value) {
                setState(() {
                  addressType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  CustomSizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/svg/shopping_light.svg',
                    ),
                  ),
                  horizontalSpace(6),
                  TextWidget(
                    text: S.of(context).shop,
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    colorDark: Colors.black,
                    color: const Color(0xFF3F3F46),
                  )
                ],
              ),
              value: "shop",
              groupValue: addressType,
              onChanged: (value) {
                setState(() {
                  addressType = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  TextWidget(
                    text: S.of(context).other,
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    colorDark: Colors.black,
                    color: const Color(0xFF3F3F46),
                  ),
                  horizontalSpace(11),
                  CustomSizedBox(
                      width: 140,
                      // height: 24,
                      child: DefaultFormField(
                        controller: addressesProvider.otherTextController,
                        hintText: S.of(context).type,
                        textSize: MyFontSize.size12,
                        fillColor: AppColor.lightBabyBlue,
                        filled: true,
                        padding: onlyEdgeInsets(bottom: 10, start: 10),
                        textInputAction: TextInputAction.done,
                      )),
                ],
              ),
              value: "other",
              groupValue: addressType,
              onChanged: (value) {
                setState(() {
                  addressType = value.toString();
                });
              },
            ),
            verticalSpace(6),
            DefaultButton(
              text: S.of(context).save,
              fontSize: MyFontSize.size14,
              fontWeight: MyFontWeight.bold,
              onPressed: () async {
                AppLoader.showLoader(context);
                if (addressType != null) {
                  await addressesProvider
                      .storeAddress(
                    type: addressType!,
                    lat: homeProvider.currentPosition!.latitude,
                    long: homeProvider.currentPosition!.longitude,
                    locationName: addressType == 'other' ? addressesProvider.otherTextController.text : null
                  )
                      .then((value) {
                        AppLoader.stopLoader();
                    if (value.status == Status.success) {
                      addressesProvider.otherTextController = TextEditingController();
                      navigateAndFinish(context, const HomeScreen());
                    } else {
                      CustomSnackBars.failureSnackBar(context, '${value.message}');
                    }
                  });
                } else {
                  CustomSnackBars.failureSnackBar(
                    context,
                    S.of(context).pleaseChooseType,
                  );
                }
              },
              height: 40,
              width: 210,
            ),
          ],
        ),
      ),
    );
  }
}
