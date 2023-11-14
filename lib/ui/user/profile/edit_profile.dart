import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/custom_form_field.dart';
import 'package:flash_customer/ui/widgets/image_editable.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/cache_helper.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
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
    TextEditingController nameTextController =
        TextEditingController(text: userProvider.profileData?.name);
    TextEditingController emailTextController =
        TextEditingController(text: userProvider.profileData?.email);
    TextEditingController phoneTextController = TextEditingController(
        text: userProvider.profileData?.phone);
    TextEditingController fwIdTextController = TextEditingController(
        text: userProvider.profileData?.fwId);
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).myProfile,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageEditable(
              imageUrl: userProvider.profileData?.image ?? '',
              showEditIcon: true,
              onTap: () async {
                AppLoader.showLoader(context);
                await ImagePicker.platform
                    .getImage(source: ImageSource.gallery, imageQuality: 30)
                    .then((image) async {
                  if (image != null) {
                    await userProvider.updateProfilePicture(
                        context, image.path).then((value) {
                          AppLoader.stopLoader();
                    });
                  }
                });
                AppLoader.stopLoader();
              },
            ),
            verticalSpace(21),
            Padding(
              padding: symmetricEdgeInsets(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      text: S.of(context).id,
                      textSize: MyFontSize.size18,
                      fontWeight: MyFontWeight.medium,
                  ),
                  verticalSpace(10),
                  CustomSizedBox(
                      height: 40,
                      width: double.infinity,
                      child: DefaultFormField(
                        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: S.of(context).enterId,
                        fillColor: AppColor.borderGreyLight,
                        filled: true,
                        enabled: false,
                        textColor: AppColor.grey,
                        controller: fwIdTextController,
                      )),
                  verticalSpace(27),
                  Row(
                    children: [
                      TextWidget(
                          text: S.of(context).name,
                          textSize: MyFontSize.size18,
                          fontWeight: MyFontWeight.medium),
                      horizontalSpace(3),
                      TextWidget(
                        text: S.of(context).optional,
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
                      hintText: S.of(context).enterName,
                      fillColor: AppColor.lightBabyBlue,
                      filled: true,
                      textColor: AppColor.grey,
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                      maxLines: 1,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                  ),
                  verticalSpace(27),
                  Row(
                    children: [
                      TextWidget(
                          text: S.of(context).email,
                          textSize: MyFontSize.size18,
                          fontWeight: MyFontWeight.medium),
                      horizontalSpace(3),
                      TextWidget(
                        text: S.of(context).optional,
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
                      hintText: S.of(context).enterEmail,
                      fillColor: AppColor.lightBabyBlue,
                      filled: true,
                      textColor: AppColor.grey,
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                      maxLines: 1,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    ),
                  ),
                  verticalSpace(27),
                  TextWidget(
                      text: S.of(context).phoneNumber,
                      textSize: MyFontSize.size18,
                      fontWeight: MyFontWeight.medium),
                  verticalSpace(10),
                  CustomSizedBox(
                    height: 40,
                    width: double.infinity,
                    child: DefaultFormField(
                      enabled: false,
                      controller: phoneTextController,
                      hintText: S.of(context).enterPhoneNumber,
                      fillColor: AppColor.borderGreyLight,
                      filled: true,
                      textColor: AppColor.grey,
                      textSize: MyFontSize.size15,
                      fontWeight: MyFontWeight.medium,
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
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
                          content: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: TextWidget(
                              text: S.of(context).areYouSureToDeleteTheAccount,
                              color: AppColor.black,
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
                                    text: S.of(context).cancel,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    backgroundColor: AppColor.boldGreen,
                                  ),
                                  DefaultButton(
                                    width: 130,
                                    height: 30,
                                    text: S.of(context).delete,
                                    onPressed: () async{
                                      await userProvider.deleteAccount();
                                      navigateAndFinish(context, const HomeScreen());
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
                      text: S.of(context).deleteAccount,
                      fontWeight: MyFontWeight.semiBold,
                      textSize: MyFontSize.size17,
                      color: const Color(0xFFFF2A34)),
                ),
                verticalSpace(12),
                DefaultButton(
                  text: S.of(context).save,
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    AppLoader.showLoader(context);
                    await userProvider
                        .updateUserProfile(
                            email: emailTextController.text,
                            name: nameTextController.text)
                        .then((value) {
                      if (value == Status.success) {
                        CustomSnackBars.successSnackBar(
                            context, S.of(context).profileUpdated);
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
