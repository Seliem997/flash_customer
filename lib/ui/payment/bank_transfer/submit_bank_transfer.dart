import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';
import '../../../providers/requestServices_provider.dart';
import '../../../utils/font_styles.dart';
import '../../widgets/custom_bar_widget.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/data_loader.dart';
import '../../widgets/spaces.dart';
import '../../widgets/text_widget.dart';

class SubmitBankTransferMethod extends StatelessWidget {
  const SubmitBankTransferMethod({Key? key, required this.index}) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    final RequestServicesProvider requestServicesProvider =
    Provider.of<RequestServicesProvider>(context);
    return Scaffold(
      appBar: const CustomAppBar(title: 'Bank Transfer Method'),
      body: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Bank name',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(10),
              CustomContainer(
                width: double.infinity,
                // height: 45,
                borderColor: const Color(0xFFD5D5DC),
                child: Padding(
                  padding: symmetricEdgeInsets(horizontal: 11, vertical: 11),
                  child: Row(
                    children: [
                      CustomSizedBox(
                        width: 85,
                        height: 23,
                        child: Image.network(requestServicesProvider.bankAccountsList[index].image!),
                      ),
                      horizontalSpace(34),
                      TextWidget(text: requestServicesProvider.bankAccountsList[index].bankName!,textSize: 14,fontWeight: MyFontWeight.semiBold,)
                    ],
                  ),
                ),
              ),
              verticalSpace(35),
              TextWidget(
                text: 'Bank account number',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(10),
              CustomContainer(
                width: double.infinity,
                height: 45,
                borderColor: const Color(0xFFD5D5DC),
                backgroundColor: AppColor.lightBabyBlue,
                child: Padding(
                  padding: symmetricEdgeInsets(horizontal: 11, vertical: 11),
                  child: Row(
                    children: [
                      TextWidget(text: requestServicesProvider.bankAccountsList[index].accountNumber!,textSize: 14,fontWeight: MyFontWeight.semiBold,),
                    ],
                  ),
                ),
              ),
              verticalSpace(35),
              TextWidget(
                text: 'Name',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(10),
              CustomContainer(
                width: double.infinity,
                height: 45,
                borderColor: const Color(0xFFD5D5DC),
                backgroundColor: AppColor.lightBabyBlue,
                child: Padding(
                  padding: symmetricEdgeInsets(horizontal: 11, vertical: 11),
                  child: Row(
                    children: [
                      TextWidget(text: requestServicesProvider.bankAccountsList[index].accountHolder!,textSize: 14,fontWeight: MyFontWeight.semiBold,),
                    ],
                  ),
                ),
              ),
              verticalSpace(35),
              TextWidget(
                text: 'IBAN',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(10),
              CustomContainer(
                width: double.infinity,
                height: 45,
                borderColor: const Color(0xFFD5D5DC),
                backgroundColor: AppColor.lightBabyBlue,
                child: Padding(
                  padding: symmetricEdgeInsets(horizontal: 11, vertical: 11),
                  child: Row(
                    children: [
                      TextWidget(text: requestServicesProvider.bankAccountsList[index].ibanNumber!,textSize: 14,fontWeight: MyFontWeight.semiBold,),
                    ],
                  ),
                ),
              ),
              verticalSpace(50),
              Center(
                child: CustomSizedBox(
                  height: 100,
                    width: 140,
                    child: Image.asset('assets/images/uploadFile.png')),
              ),
              verticalSpace(50),
              DefaultButton(
                height: 37,
                width: 345,
                text: 'Submit',
                onPressed: () {},
              )
            ],
          )),
    );
  }
}
