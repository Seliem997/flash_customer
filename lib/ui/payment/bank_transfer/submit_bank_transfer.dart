import 'package:flash_customer/ui/widgets/custom_button.dart';
import 'package:flash_customer/ui/widgets/navigate.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../generated/l10n.dart';
import '../../../providers/requestServices_provider.dart';
import '../../../utils/font_styles.dart';
import '../../home/home_screen.dart';
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
      appBar: CustomAppBar(title: S.of(context).bankTransferMethod),
      body: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: S.of(context).bankName,
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
                      CustomContainer(
                        backgroundColorDark: Colors.white,
                        width: 90,
                        height: 25,
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
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
                text: S.of(context).bankAccountNumber,
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
                      Expanded(child: TextWidget(text: requestServicesProvider.bankAccountsList[index].accountNumber!,textSize: 14,fontWeight: MyFontWeight.semiBold,)),
                      InkWell(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text: requestServicesProvider.bankAccountsList[index].accountNumber!));
                        },
                        child: SvgPicture.asset(
                          'assets/svg/copy.svg',
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(35),
              TextWidget(
                text: S.of(context).name,
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
                      Expanded(child: TextWidget(text: requestServicesProvider.bankAccountsList[index].accountHolder!,textSize: 14,fontWeight: MyFontWeight.semiBold,)),
                      InkWell(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text: requestServicesProvider.bankAccountsList[index].accountHolder!));
                        },
                        child: SvgPicture.asset(
                          'assets/svg/copy.svg',
                          color: AppColor.primary,
                        ),
                      ),
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
                      Expanded(
                        child: TextWidget(
                          text: requestServicesProvider.bankAccountsList[index].ibanNumber!,
                          textSize: 14,
                          fontWeight: MyFontWeight.semiBold,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Clipboard.setData(ClipboardData(text: requestServicesProvider.bankAccountsList[index].ibanNumber!));
                        },
                        child: SvgPicture.asset(
                          'assets/svg/copy.svg',
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(50),
              Center(
                child: CustomSizedBox(
                  height: 140,
                    width: 180,
                    onTap: () async{
                      await ImagePicker.platform
                          .getImage(source: ImageSource.gallery, imageQuality: 30)
                          .then((image) async {
                        if (image != null) {
                          await requestServicesProvider.uploadPaymentFile(
                              context, image.path,
                            bankAccountId: requestServicesProvider.bankAccountsList[index].id!,
                            requestId: requestServicesProvider.updatedRequestDetailsData!.id!,
                          ).then((value) {
                            navigateAndFinish(context, const HomeScreen(cameFromNewRequest: true,));
                          });
                        }
                      });

                    },
                    child: Image.asset(
                      'assets/images/uploadFile.png',
                    fit: BoxFit.contain,)),
              ),
            ],
          )),
    );
  }
}
