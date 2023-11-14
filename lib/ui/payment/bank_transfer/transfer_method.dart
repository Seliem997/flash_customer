import 'package:flash_customer/ui/payment/bank_transfer/submit_bank_transfer.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../providers/requestServices_provider.dart';
import '../../../utils/font_styles.dart';
import '../../widgets/custom_bar_widget.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/data_loader.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';


class BankTransferMethod extends StatefulWidget {
  const BankTransferMethod({Key? key}) : super(key: key);

  @override
  State<BankTransferMethod> createState() => _BankTransferMethodState();
}

class _BankTransferMethodState extends State<BankTransferMethod> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
  }

  void loadData() async {
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context, listen: false);
    await requestServicesProvider
        .getBankAccounts()
        .then((value) {
      requestServicesProvider.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(title: S.of(context).bankTransferMethod),
      body: (requestServicesProvider.isLoading)
          ? const DataLoader()
          : requestServicesProvider.bankAccountsList == []
          ? CustomSizedBox(
          height: 500,
          child: Center(
              child: TextWidget(text: S.of(context).noDataAvailable)))
          : Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: S.of(context).choseOneOfOurBanks,
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(20),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => CustomContainer(
                  width: double.infinity,
                      onTap: (){
                    navigateTo(context, SubmitBankTransferMethod(index: index,));
                      },
                      borderColor: const Color(0xFFD5D5DC),
                  child: Padding(
                    padding: symmetricEdgeInsets(horizontal: 11, vertical: 11),
                    child: Row(
                      children: [
                        CustomContainer(
                          backgroundColorDark: Colors.white,
                          width: 90,
                          height: 25,
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Image.network(requestServicesProvider.bankAccountsList[index].image!),
                        ),
                        horizontalSpace(34),
                        TextWidget(
                          text: requestServicesProvider.bankAccountsList[index].bankName!,
                          textSize: 14,
                          fontWeight: MyFontWeight.semiBold,
                        )
                      ],
                    ),
                  ),
                ),
                    separatorBuilder: (context, index) => verticalSpace(24),
                    itemCount: requestServicesProvider.bankAccountsList.length),
              ),
            ],
          )),
    );
  }
}
