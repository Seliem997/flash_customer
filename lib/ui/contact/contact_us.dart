import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/styles/colors.dart';
import '../../utils/font_styles.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/spaces.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Contact us'),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              text: 'Lorem ipsum dolor sit amet',
              fontWeight: MyFontWeight.semiBold,
              textSize: MyFontSize.size16,
            ),
            verticalSpace(10),
            TextWidget(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magnd.',
              fontWeight: MyFontWeight.regular,
              textSize: MyFontSize.size12,
              color: AppColor.grey,
            ),
            verticalSpace(32),
            TextWidget(
                text: 'Name',
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium),
            verticalSpace(10),
            CustomSizedBox(
              height: 40,
              width: double.infinity,
              child: DefaultFormField(
                hintText: 'Enter Name',
                fillColor: AppColor.borderGreyLight,
                filled: true,
                textColor: AppColor.textGrey,
                textSize: MyFontSize.size10,
                fontWeight: MyFontWeight.regular,
              ),
            ),
            verticalSpace(22),
            TextWidget(
                text: 'Email',
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium),
            verticalSpace(10),
            CustomSizedBox(
              height: 40,
              width: double.infinity,
              child: DefaultFormField(
                hintText: 'mariam.nasser87@yahoo.com',
                fillColor: AppColor.borderGreyLight,
                filled: true,
                textColor: AppColor.textGrey,
                textSize: MyFontSize.size10,
                fontWeight: MyFontWeight.regular,
              ),
            ),
            verticalSpace(22),
            TextWidget(
                text: 'Phone number',
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium),
            verticalSpace(10),
            CustomSizedBox(
              height: 40,
              width: double.infinity,
              child: DefaultFormField(
                hintText: '+966 124 365 1236',
                fillColor: AppColor.borderGreyLight,
                filled: true,
                textColor: AppColor.textGrey,
                textSize: MyFontSize.size10,
                fontWeight: MyFontWeight.regular,
              ),
            ),
            verticalSpace(22),
            TextWidget(
                text: 'Message',
                textSize: MyFontSize.size14,
                fontWeight: MyFontWeight.medium),
            verticalSpace(10),
            CustomSizedBox(
              height: 104,
              width: double.infinity,
              child: DefaultFormField(
                hintText: 'Type your message........',
                fillColor: AppColor.borderGreyLight,
                filled: true,
                textColor: AppColor.textGrey,
                textSize: MyFontSize.size10,
                fontWeight: MyFontWeight.regular,
              ),
            ),
            verticalSpace(32),
            DefaultButton(
              height: 37,
              width: 345,
              text: 'Send',
              onPressed: () {},
            ),
            verticalSpace(24),
            Padding(
              padding: symmetricEdgeInsets(horizontal: 9),
              child: CustomSizedBox(
                height: 35,
                child: Row(
                  children: [
                    CustomSizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/svg/telephone.svg',
                      ),
                    ),
                    horizontalSpace(14),
                    CustomSizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/svg/whatsapp.svg',
                      ),
                    ),
                    horizontalSpace(14),
                    CustomSizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/svg/instagram.svg',
                      ),
                    ),
                    horizontalSpace(14),
                    CustomSizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/svg/snapchat.svg',
                      ),
                    ),
                    horizontalSpace(14),
                    CustomSizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/svg/tiktok.svg',
                      ),
                    ),
                    horizontalSpace(14),
                    CustomSizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/svg/telegram.svg',
                      ),
                    ),
                    horizontalSpace(14),
                    CustomSizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        'assets/svg/gmail.svg',
                      ),
                    ),
                    horizontalSpace(14),
                  ],
                ),),
            ),
            verticalSpace(24),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Our website',
                style: TextStyle(
                  fontSize: MyFontSize.size16,
                  fontWeight: MyFontWeight.semiBold,
                  decoration: TextDecoration.underline,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
