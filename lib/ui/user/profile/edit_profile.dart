import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/custom_form_field.dart';
import 'package:flash_customer/ui/widgets/image_editable.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../widgets/custom_bar_widget.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Profile',
      ),
      body: Column(
        children: [
          ImageEditable(
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
                      fillColor: AppColor.borderGrey,
                      filled: true,
                      enabled: false,
                      controller: TextEditingController(text: 'FWC1'),
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
                    hintText: 'Enter Name',
                    fillColor: AppColor.babyBlue,
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
                    hintText: 'Enter Email',
                    fillColor: AppColor.babyBlue,
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
                    hintText: 'Enter Phone Number',
                    fillColor: AppColor.babyBlue,
                    filled: true,
                    textColor: AppColor.grey,
                    textSize: MyFontSize.size15,
                    fontWeight: MyFontWeight.medium,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Expanded(
                        child: AlertDialog(
                          content: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextWidget(text: 'Are you sure to delete the account?',),
                          ),
                          actions: [
                            Padding(
                              padding: symmetricEdgeInsets(vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  DefaultButton(width: 130,height: 30,text: 'Cancel', onPressed: (){Navigator.pop(context);},backgroundColor: Color(0xFF6BB85F),),
                                  DefaultButton(width: 130,height: 30,text: 'Delete', onPressed: (){Navigator.pop(context);},backgroundColor: Color(0xFFB85F66),),
                                ],
                              ),
                            ),

                          ],
                        ),
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
                onPressed: () {},
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
    );
  }
}
