import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/font_styles.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_bar_widget.dart';
import 'new_address.dart';

class MyAddresses extends StatelessWidget {
  const MyAddresses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Addresses',
      ),
      body: Padding(
        padding: symmetricEdgeInsets(horizontal: 24),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: symmetricEdgeInsets(vertical: 30),
                child: Column(
                  children: [
                    CustomContainer(
                      height: 64,
                      width: 345,
                      backgroundColor: Color(0xFFE6EEFB),
                      child: Padding(
                        padding:
                            symmetricEdgeInsets(vertical: 7, horizontal: 7),
                        child: Row(
                          children: [
                            CustomContainer(
                              width: 50,
                              height: 50,
                              radiusCircular: 3,
                              padding: EdgeInsets.zero,
                              clipBehavior: Clip.hardEdge,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/addresses.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            horizontalSpace(12),
                            CustomSizedBox(
                              width: 157,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextWidget(
                                    text:
                                        'Saudi Arabia,Uhud Rd, Ar Rawdah,',
                                    maxLines: 2,
                                    fontWeight: MyFontWeight.medium,
                                    textSize: MyFontSize.size10,
                                  ),
                                  TextWidget(
                                    text: 'Tarut 32626',
                                    fontWeight: MyFontWeight.medium,
                                    textSize: MyFontSize.size10,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            horizontalSpace(30),
                            DefaultButton(
                              text: 'Home',
                              fontWeight: MyFontWeight.semiBold,
                              fontSize: MyFontSize.size9,
                              onPressed: () {},
                              backgroundColor: Color(0xFF66C0FF),
                              width: 64,
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                    verticalSpace(14),
                    CustomContainer(
                      height: 64,
                      width: 345,
                      backgroundColor: Color(0xFFE6EEFB),
                      child: Padding(
                        padding:
                        symmetricEdgeInsets(vertical: 7, horizontal: 7),
                        child: Row(
                          children: [
                            CustomContainer(
                              width: 50,
                              height: 50,
                              radiusCircular: 3,
                              padding: EdgeInsets.zero,
                              clipBehavior: Clip.hardEdge,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                'assets/images/addresses2.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            horizontalSpace(12),
                            CustomSizedBox(
                              width: 157,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text:
                                    'Saudi Arabia,Uhud Rd, Ar Rawdah,',
                                    maxLines: 2,
                                    fontWeight: MyFontWeight.medium,
                                    textSize: MyFontSize.size10,
                                  ),
                                  TextWidget(
                                    text: 'Tarut 32626',
                                    fontWeight: MyFontWeight.medium,
                                    textSize: MyFontSize.size10,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            horizontalSpace(30),
                            DefaultButton(
                              text: 'Work',
                              fontWeight: MyFontWeight.semiBold,
                              fontSize: MyFontSize.size9,
                              onPressed: () {},
                              backgroundColor: Color(0xFF66C0FF),
                              width: 64,
                              height: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: symmetricEdgeInsets(horizontal: 24),
              child: DefaultButton(
                text: 'Add new address',
                onPressed: () {
                  navigateTo(context, NewAddress());
                },
                fontWeight: MyFontWeight.bold,
                fontSize: 21,
                height: 48,
                width: 345,
              ),
            ),
            verticalSpace(50)
          ],
        ),
      ),
    );
  }
}
