import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flash_customer/utils/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../generated/l10n.dart';
import '../../main.dart';
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
    aboutProvider.contactDataKey = GlobalKey<FormState>();
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
          child: Form(
            key: aboutProvider.contactDataKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(42),
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
                    hintText: 'example@gmail.com',
                    fillColor: AppColor.borderGreyLight,
                    filled: true,
                    textColor: AppColor.textGrey,
                    textSize: MyFontSize.size10,
                    fontWeight: MyFontWeight.regular,
                    validator: (value) {
                      if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!)) {
                        return "Please Enter Valid Email Address";
                      } else if (value.isEmpty) {
                        return "Please Enter Your Email Address";
                      }
                      return null;
                    },
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
                    hintText: '+966 543 210 1234',
                    fillColor: AppColor.borderGreyLight,
                    filled: true,
                    textColor: AppColor.textGrey,
                    textSize: MyFontSize.size10,
                    fontWeight: MyFontWeight.regular,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
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
                    if(aboutProvider.emailController.text != ''){
                      if (aboutProvider.contactDataKey.currentState!.validate()) {
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
                      }

                    }else{
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
                        CustomContainer(
                          onTap: (){
                            aboutProvider.socialLinksData!.data!.phone0 == null
                                ? CustomSnackBars.failureSnackBar(context, "Phone is null")
                                : aboutProvider.makingPhoneCall(phoneNum: aboutProvider.socialLinksData!.data!.phone0);
                          },
                          width: 30,
                          child: Image.asset('assets/images/telephonee.png'),
                        ),
                        horizontalSpace(14),
                        CustomContainer(
                          width: 30,
                          child: Image.asset('assets/images/whatsapp.png'),
                          onTap: () async {
                            //To remove the keyboard when button is pressed
                            FocusManager.instance.primaryFocus?.unfocus();

                            final url = "https://wa.me/+955${aboutProvider.socialLinksData!.data!.phone1}?text=Hello";
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              CustomSnackBars.failureSnackBar(context, "Unable to open whatsapp",);
                            }
                            if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';

                          /*  var whatsappUrl =
                                "whatsapp://send?phone=+955${aboutProvider.socialLinksData!.data!.phone1}" +
                                    "&text=${Uri.encodeComponent("I need help in ")}";
                            try {
                              launch(whatsappUrl);
                            } catch (e) {
                              //To handle error and display error message
                             CustomSnackBars.failureSnackBar(context, "Unable to open whatsapp",);
                            }*/
                          },
                        ),
                        horizontalSpace(14),
                        CustomContainer(
                          width: 30,
                          child: Image.asset('assets/images/instagram.png'),
                          onTap: () async{
                            try {
                              await launchUrlString('${aboutProvider.socialLinksData!.data!.instagram}', mode: LaunchMode.externalApplication);
                            } catch (e) {
                              print(e);
                              await launchUrlString('${aboutProvider.socialLinksData!.data!.instagram}', mode: LaunchMode.platformDefault);
                            }
                          },
                        ),
                        horizontalSpace(14),
                        CustomContainer(
                          width: 30,
                          child: Image.asset('assets/images/snapChat.png'),
                            onTap: () async{
                              try {
                                await launchUrlString('${aboutProvider.socialLinksData!.data!.snapchat}', mode: LaunchMode.externalApplication);
                              } catch (e) {
                                print(e);
                                await launchUrlString('${aboutProvider.socialLinksData!.data!.snapchat}', mode: LaunchMode.platformDefault);
                              }
                            },
                        ),
                        horizontalSpace(14),
                        CustomContainer(
                          width: 30,
                          child: Image.asset('assets/images/tiktok.png', color: MyApp.themeMode(context) ? Colors.white : Colors.black,),
                            onTap: () async{
                              try {
                                await launchUrlString('${aboutProvider.socialLinksData!.data!.tiktok}', mode: LaunchMode.externalApplication);
                              } catch (e) {
                                print(e);
                                await launchUrlString('${aboutProvider.socialLinksData!.data!.tiktok}', mode: LaunchMode.platformDefault);
                              }
                            }
                        ),
                        horizontalSpace(14),
                        CustomContainer(
                          width: 30,
                          child: Image.asset('assets/images/telegram.png'),
                        ),
                        horizontalSpace(14),
                        CustomContainer(
                          width: 30,
                          child: Image.asset('assets/images/gMail.png'),
                            onTap: () async{
                              try {
                                await launchUrlString('${aboutProvider.socialLinksData!.data!.gmail}', mode: LaunchMode.externalApplication);
                              } catch (e) {
                                print(e);
                                await launchUrlString('${aboutProvider.socialLinksData!.data!.gmail}', mode: LaunchMode.platformDefault);
                              }
                            }
                        ),
                        horizontalSpace(14),
                      ],
                    ),
                  ),
                ),
                verticalSpace(24),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () async{
                      try {
                        await launchUrlString('${aboutProvider.socialLinksData!.data!.website}', mode: LaunchMode.externalApplication);
                      } catch (e) {
                        print(e);
                        await launchUrlString('${aboutProvider.socialLinksData!.data!.website}', mode: LaunchMode.platformDefault);
                      }
                    },
                    child: Text(
                      'Our website',
                      style: TextStyle(
                        fontSize: MyFontSize.size16,
                        fontWeight: MyFontWeight.semiBold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
