import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/custom_container.dart';
import 'package:flash_customer/ui/widgets/image_editable.dart';
import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/transactionHistory_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/font_styles.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/data_loader.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    final TransactionHistoryProvider transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context, listen: false);
    await transactionHistoryProvider.getTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    final TransactionHistoryProvider transactionHistoryProvider =
        Provider.of<TransactionHistoryProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Wallet',
        backgroundColor: AppColor.lightBabyBlue,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          CustomContainer(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(44),
                bottomRight: Radius.circular(44)),
            width: double.infinity,
            height: 211,
            backgroundColor: AppColor.lightBabyBlue,
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
                const ImageEditable(
                  imageUrl: '',
                ),
                verticalSpace(14),
                TextWidget(
                  text: userProvider.userName == ""
                      ? "User Name"
                      : userProvider.userName ?? "User Name",
                  fontWeight: MyFontWeight.bold,
                  textSize: MyFontSize.size16,
                ),
                verticalSpace(10),
                TextWidget(
                  text: '${userProvider.userBalance} SR',
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
                    TextWidget(
                      text: 'Recharge Amount',
                      textSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.bold,
                    ),
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
                DefaultButton(
                    text: 'Pay', onPressed: () {}, width: 217, height: 40),
                verticalSpace(45),
                Row(
                  children: [
                    TextWidget(
                      text: 'Transactions history',
                      textSize: MyFontSize.size14,
                      fontWeight: MyFontWeight.bold,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {},
                      child: TextWidget(
                        text: 'See All',
                        textSize: MyFontSize.size10,
                        fontWeight: MyFontWeight.medium,
                        color: AppColor.boldBlue,
                      ),
                    )
                  ],
                ),
                verticalSpace(6),
                transactionHistoryProvider.transactionData == null
                    ? const DataLoader()
                    : CustomSizedBox(
                        height: 300,
                        child: ListView.separated(
                          itemCount: transactionHistoryProvider
                              .transactionData!.collection!.length,
                          itemBuilder: (context, index) => CustomContainer(
                            height: 60,
                            width: 345,
                            radiusCircular: 4,
                            padding: symmetricEdgeInsets(
                                horizontal: 16, vertical: 12),
                            /*backgroundColor: int.parse(transactionHistoryProvider
                                        .transactionData!
                                        .collection![index]
                                        .amount!) >=
                                    0
                                ? AppColor.acceptGreen
                                : AppColor.canceledRed,*/
                            backgroundColor: AppColor.acceptGreen,
                            child: Center(
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: transactionHistoryProvider
                                            .transactionData!
                                            .collection![index]
                                            .type!,
                                        textSize: MyFontSize.size14,
                                        fontWeight: MyFontWeight.medium,
                                      ),
                                      verticalSpace(9),
                                      Row(
                                        children: [
                                          CustomSizedBox(
                                            width: 8,
                                            height: 8,
                                            child: SvgPicture.asset(
                                                'assets/svg/clock.svg'),
                                          ),
                                          horizontalSpace(4),
                                          TextWidget(
                                            text: '18/3/2023  -  ',
                                            textSize: MyFontSize.size8,
                                            fontWeight: MyFontWeight.regular,
                                            color: AppColor.subTitleGrey,
                                          ),
                                          TextWidget(
                                            text: '11:06 PM',
                                            textSize: MyFontSize.size8,
                                            fontWeight: MyFontWeight.regular,
                                            color: AppColor.subTitleGrey,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  TextWidget(
                                    text: transactionHistoryProvider
                                        .transactionData!
                                        .collection![index]
                                        .amount!,
                                    textSize: MyFontSize.size14,
                                    fontWeight: MyFontWeight.semiBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              verticalSpace(14),
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
