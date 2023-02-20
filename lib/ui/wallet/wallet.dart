import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/image_editable.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/font_styles.dart';
import '../widgets/custom_bar_widget.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Wallet',
        backgroundColor: AppColor.babyBlue,
      ),
      body: Column(
        children: [
          CustomContainer(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(44),
                bottomRight: Radius.circular(44)),
            width: double.infinity,
            height: 211,
            backgroundColor: AppColor.babyBlue,
            child: Column(
              children: [
                // const CircleAvatar(
                //   backgroundColor: Color.fromRGBO(0, 107, 182, 0.53),
                //   radius: 55,
                //   child: CircleAvatar(
                //     radius: 49,
                //     backgroundImage: AssetImage(
                //       'assets/images/profile.png',
                //     ),
                //   ),
                // ),
                const ImageEditable(imageUrl: '',),
                verticalSpace(14),
                TextWidget(
                  text: 'Mariam Nasser Saleh',
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size16,
                ),
                verticalSpace(10),
                TextWidget(
                  text: 'Balance : 64 SR',
                  fontWeight: MyFontWeight.semiBold,
                  textSize: MyFontSize.size14,
                  color: const Color(0xFF00567B),
                ),
              ],
            ),
          ),
          verticalSpace(32),
          Padding(
            padding: symmetricEdgeInsets(horizontal: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    TextWidget(text: 'Recharge Amount',textSize: MyFontSize.size14,fontWeight: MyFontWeight.bold,),
                    horizontalSpace(18),
                    const Expanded(
                      child: CustomContainer(
                        height: 24,
                        backgroundColor: Color(0xFFE1E1E1),
                        radiusCircular: 3,
                      ),
                    ),
                  ],
                ),
                verticalSpace(28),
                DefaultButton(text: 'Pay', onPressed: (){},width: 217,height: 32),
                verticalSpace(45),
                Row(
                  children: [
                    TextWidget(text: 'Transactions history',textSize: MyFontSize.size14,fontWeight: MyFontWeight.bold,),
                    const Spacer(),
                    TextButton(onPressed: (){}, child: TextWidget(text: 'See All',textSize: MyFontSize.size10,fontWeight: MyFontWeight.medium,color: AppColor.boldBlue,),)
                  ],
                ),
                verticalSpace(6),
                CustomContainer(
                  height: 60,
                  width: 345,
                  radiusCircular: 4,
                  padding: symmetricEdgeInsets(horizontal: 16,vertical: 12),
                  backgroundColor: AppColor.acceptGreen,
                  child: Center(
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(text: 'Refunds',textSize: MyFontSize.size14,fontWeight: MyFontWeight.medium,),
                            verticalSpace(9),
                            Row(
                              children: [
                                CustomSizedBox(
                                  width: 8,
                                  height: 8,
                                  child: SvgPicture.asset('assets/svg/clock.svg'),
                                ),
                                horizontalSpace(4),
                                TextWidget(text: '18/1/2023  -  ',textSize: MyFontSize.size8,fontWeight: MyFontWeight.regular,color: AppColor.subTitleGrey,),
                                TextWidget(text: '09:06 PM',textSize: MyFontSize.size8,fontWeight: MyFontWeight.regular,color: AppColor.subTitleGrey,),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextWidget(text: '8.6 SR',textSize: MyFontSize.size14,fontWeight: MyFontWeight.semiBold,),

                      ],
                    ),
                  ),
                ),
                verticalSpace(14),
                CustomContainer(
                  height: 60,
                  width: double.infinity,
                  radiusCircular: 4,
                  padding: symmetricEdgeInsets(horizontal: 16,vertical: 12),
                  backgroundColor: AppColor.acceptGreen,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(text: 'Recharge',textSize: MyFontSize.size14,fontWeight: MyFontWeight.medium,),
                          verticalSpace(9),
                          Row(
                            children: [
                              CustomSizedBox(
                                width: 8,
                                height: 8,
                                child: SvgPicture.asset('assets/svg/clock.svg'),
                              ),
                              horizontalSpace(4),
                              TextWidget(text: '18/1/2023  -  ',textSize: MyFontSize.size8,fontWeight: MyFontWeight.regular,color: AppColor.subTitleGrey,),
                              TextWidget(text: '09:06 PM',textSize: MyFontSize.size8,fontWeight: MyFontWeight.regular,color: AppColor.subTitleGrey,),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      TextWidget(text: '18.6 SR',textSize: MyFontSize.size14,fontWeight: MyFontWeight.semiBold,),
                    ],
                  ),
                ),
                verticalSpace(14),
                CustomContainer(
                  height: 60,
                  width: double.infinity,
                  radiusCircular: 4,
                  padding: symmetricEdgeInsets(horizontal: 16,vertical: 12),
                  backgroundColor: AppColor.canceledRed,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(text: 'Wash Req',textSize: MyFontSize.size14,fontWeight: MyFontWeight.medium,),
                          verticalSpace(9),
                          Row(
                            children: [
                              CustomSizedBox(
                                width: 8,
                                height: 8,
                                child: SvgPicture.asset('assets/svg/clock.svg'),
                              ),
                              horizontalSpace(4),
                              TextWidget(text: '18/1/2023  -  ',textSize: MyFontSize.size8,fontWeight: MyFontWeight.regular,color: AppColor.subTitleGrey,),
                              TextWidget(text: '09:06 PM',textSize: MyFontSize.size8,fontWeight: MyFontWeight.regular,color: AppColor.subTitleGrey,),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      TextWidget(text: '-8.6 SR',textSize: MyFontSize.size14,fontWeight: MyFontWeight.semiBold,),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
