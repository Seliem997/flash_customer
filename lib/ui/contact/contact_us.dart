import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../providers/about_provider.dart';
import '../../utils/styles/colors.dart';
import '../../utils/font_styles.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_container.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/spaces.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final AboutProvider aboutProvider =
        Provider.of<AboutProvider>(context, listen: false);
    await aboutProvider.getSocialLinks();
  }

  @override
  Widget build(BuildContext context) {
    final AboutProvider aboutProvider = Provider.of<AboutProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).contactUs),
      body: SingleChildScrollView(
        child: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text:
                    'Lorem ipsum dolor sit amet${aboutProvider.socialLinksData?.id}',
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
              Row(
                children: [
                  TextWidget(
                      text: 'Name',
                      textSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(3),
                  TextWidget(
                    text: '(Optional)',
                    textSize: MyFontSize.size8,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(10),
              CustomSizedBox(
                height: 40,
                width: double.infinity,
                child: DefaultFormField(
                  controller: aboutProvider.nameController,
                  hintText: 'Enter Name',
                  fillColor: AppColor.borderGreyLight,
                  filled: true,
                  textColor: AppColor.textGrey,
                  textSize: MyFontSize.size10,
                  fontWeight: MyFontWeight.regular,
                ),
              ),
              verticalSpace(22),
              Row(
                children: [
                  TextWidget(
                      text: 'Email',
                      textSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.medium),
                  horizontalSpace(3),
                  TextWidget(
                    text: '(Optional)',
                    textSize: MyFontSize.size8,
                    fontWeight: MyFontWeight.regular,
                    color: AppColor.lightGrey,
                  ),
                ],
              ),
              verticalSpace(10),
              CustomSizedBox(
                height: 40,
                width: double.infinity,
                child: DefaultFormField(
                  controller: aboutProvider.emailController,
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
                  controller: aboutProvider.phoneController,
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
                  controller: aboutProvider.messageController,
                  hintText: 'Type your message........',
                  fillColor: AppColor.borderGreyLight,
                  filled: true,
                  textColor: AppColor.textGrey,
                  textSize: MyFontSize.size10,
                  fontWeight: MyFontWeight.regular,
                ),
              ),
              verticalSpace(15),
              DefaultButton(
                height: 37,
                width: 345,
                text: 'Send',
                onPressed: () {
                  if(aboutProvider.phoneController.text != '' && aboutProvider.messageController.text != ''){
                    AppLoader.showLoader(context);
                    aboutProvider.contactUs().then((value) {
                      AppLoader.stopLoader();
                      aboutProvider.resetFields();
                      navigateAndFinish(context, const HomeScreen());
                    });
                  }else {
                    CustomSnackBars.failureSnackBar(context, 'Please Fill Required Fields',);
                  }

                },
              ),
              verticalSpace(24),
              Padding(
                padding: symmetricEdgeInsets(horizontal: 9),
                child: CustomSizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSizedBox(
                        // height: 30,
                        width: 30,
                        child: Image.asset('assets/images/telephonee.png'),
                      ),
                      horizontalSpace(14),
                      CustomSizedBox(
                        // height: 30,
                        width: 30,
                        child: Image.asset('assets/images/whatsapp.png'),
                      ),
                      horizontalSpace(14),
                      CustomSizedBox(
                        // height: 30,
                        width: 30,
                        child: Image.asset('assets/images/instagram.png'),
                      ),
                      horizontalSpace(14),
                      CustomSizedBox(
                        // height: 30,
                        width: 30,
                        child: Image.asset('assets/images/snapChat.png'),
                      ),
                      horizontalSpace(14),
                      CustomSizedBox(
                        // height: 30,
                        width: 30,
                        child: Image.asset('assets/images/tiktok.png'),

                      ),
                      horizontalSpace(14),
                      CustomSizedBox(
                        // height: 30,
                        width: 30,
                        child: Image.asset('assets/images/telegram.png'),
                      ),
                      horizontalSpace(14),
                      CustomSizedBox(
                        // height: 30,
                        width: 30,
                        child: Image.asset('assets/images/gMail.png'),

                      ),
                      horizontalSpace(14),
                    ],
                  ),
                ),
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
      ),
    );
  }
}
