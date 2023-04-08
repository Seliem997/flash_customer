import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/custom_form_field.dart';
import 'package:flash_customer/ui/widgets/image_editable.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/cache_helper.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';
import '../../../utils/app_loader.dart';
import '../../../utils/styles/colors.dart';
import '../../../utils/enum/shared_preference_keys.dart';
import '../../../utils/enum/statuses.dart';
import '../../../utils/snack_bars.dart';
import '../../widgets/custom_bar_widget.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    TextEditingController nameTextController = TextEditingController(
        text: userProvider.userName);
    TextEditingController emailTextController = TextEditingController(
        text: userProvider.userEmail);
    TextEditingController phoneTextController = TextEditingController(
        text: CacheHelper.returnData(key: CacheKey.phoneNumber));
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Profile',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ImageEditable(
              imageUrl: '',
              showEditIcon: true,
            ),
            verticalSpace(21),
            Padding(
              padding: symmetricEdgeInsets(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: 'ID',
                      textSize: MyFontSize.size18,
                      fontWeight: MyFontWeight.medium),
                  verticalSpace(10),
                  CustomSizedBox(
                      height: 40,
                      width: double.infinity,
                      child: DefaultFormField(
                        hintText: 'Enter ID',
                        fillColor: AppColor.borderGreyLight,
                        filled: true,
                        enabled: false,
                        controller: TextEditingController(text: userProvider.userId),
                      )),
                  verticalSpace(27),
                  Row(
                    children: [
                      TextWidget(
                          text: 'Name',
                          textSize: MyFontSize.size18,
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
                      controller: nameTextController,
                      hintText: 'Enter Name',
                      fillColor: AppColor.lightBabyBlue,
                      filled: true,
                      textColor: AppColor.grey,
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                    ),
                  ),
                  verticalSpace(27),
                  Row(
                    children: [
                      TextWidget(
                          text: 'Email',
                          textSize: MyFontSize.size18,
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
                      controller: emailTextController,
                      hintText: 'Enter Email',
                      fillColor: AppColor.lightBabyBlue,
                      filled: true,
                      textColor: AppColor.grey,
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                    ),
                  ),
                  verticalSpace(27),
                  TextWidget(
                      text: 'Phone Number',
                      textSize: MyFontSize.size18,
                      fontWeight: MyFontWeight.medium),
                  verticalSpace(10),
                  CustomSizedBox(
                    height: 40,
                    width: double.infinity,
                    child: DefaultFormField(
                      enabled: false,
                      controller: phoneTextController,
                      hintText: 'Enter Phone Number',
                      fillColor: AppColor.borderGreyLight,
                      filled: true,
                      textColor: AppColor.grey,
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                    ),
                  ),
                ],
              ),
            ),
            verticalSpace(60),
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextWidget(
                              text: 'Are you sure to delete the account?',
                            ),
                          ),
                          actions: [
                            Padding(
                              padding: symmetricEdgeInsets(vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  DefaultButton(
                                    width: 130,
                                    height: 30,
                                    text: 'Cancel',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    backgroundColor: AppColor.boldGreen,
                                  ),
                                  DefaultButton(
                                    width: 130,
                                    height: 30,
                                    text: 'Delete',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    backgroundColor: AppColor.textRed,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: TextWidget(
                      text: 'Delete account',
                      fontWeight: MyFontWeight.semiBold,
                      textSize: MyFontSize.size17,
                      color: const Color(0xFFFF2A34)),
                ),
                verticalSpace(12),
                DefaultButton(
                  text: 'Save',
                  onPressed: () async {
                    print('on Tap is ${phoneTextController.text}');
                    FocusScope.of(context).unfocus();
                    AppLoader.showLoader(context);
                    await userProvider
                        .updateUserProfile(
                            email: emailTextController.text,
                            name: nameTextController.text)
                        .then((value) {
                      if (value == Status.success) {
                        CustomSnackBars.successSnackBar(
                            context, 'Profile Updated');
                      } else {
                        CustomSnackBars.somethingWentWrongSnackBar(context);
                      }
                    });
                    AppLoader.stopLoader();
                  },
                  width: 345,
                  height: 48,
                  fontWeight: MyFontWeight.bold,
                  fontSize: 21,
                )
              ],
            ),
            verticalSpace(42),
          ],
        ),
      ),
    );
  }
}
