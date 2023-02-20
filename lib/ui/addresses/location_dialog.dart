import 'package:flash_customer/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/font_styles.dart';
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
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: CustomContainer(
        width: 321,
        height: 400,
        padding: symmetricEdgeInsets(horizontal: 10,vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: symmetricEdgeInsets(horizontal: 22),
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: TextWidget(
                  text: 'Types :',
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size18,
                ),
              ),
            ),
            verticalSpace(24),
            RadioListTile(
              title: Row(
                children: [
                  CustomSizedBox(
                    height: 14,
                    width: 14,
                    child: SvgPicture.asset(
                      'assets/svg/home_light.svg',
                    ),
                  ),
                  horizontalSpace(6),
                  TextWidget(
                    text: 'Home',
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    color: const Color(0xFF3F3F46),
                  ),
                ],
              ),
              value: "home",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  CustomSizedBox(
                    height: 14,
                    width: 14,
                    child: SvgPicture.asset(
                      'assets/svg/work_light.svg',
                    ),
                  ),
                  horizontalSpace(6),
                  TextWidget(
                    text: 'Work',
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    color: const Color(0xFF3F3F46),
                  )
                ],
              ),
              value: "work",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  CustomSizedBox(
                    height: 14,
                    width: 14,
                    child: SvgPicture.asset(
                      'assets/svg/school_light.svg',
                    ),
                  ),
                  horizontalSpace(6),
                  TextWidget(
                    text: 'School',
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    color: const Color(0xFF3F3F46),
                  )
                ],
              ),
              value: "school",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  CustomSizedBox(
                    height: 14,
                    width: 14,
                    child: SvgPicture.asset(
                      'assets/svg/shopping_light.svg',
                    ),
                  ),
                  horizontalSpace(6),
                  TextWidget(
                    text: 'Shop',
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    color: const Color(0xFF3F3F46),
                  )
                ],
              ),
              value: "shop",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Row(
                children: [
                  TextWidget(
                    text: 'Other',
                    textSize: MyFontSize.size14,
                    fontWeight: MyFontWeight.medium,
                    color: const Color(0xFF3F3F46),
                  ),
                  horizontalSpace(11),
                  CustomSizedBox(
                      width: 140,
                      height: 24,
                      child: DefaultFormField(
                        hintText: 'Type',
                        textSize: MyFontSize.size8,
                        fillColor: AppColor.babyBlue,
                        filled: true,
                      )),
                ],
              ),
              value: "other",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            verticalSpace(6),
            DefaultButton(
              text: 'Save',
              onPressed: () {},
              height: 32,
              width: 225,
            ),
          ],
        ),
      ),
    );
  }
}
