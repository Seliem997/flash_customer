import 'package:flutter/material.dart';

import '../../utils/font_styles.dart';
import '../widgets/custom_bar_widget.dart';
import '../widgets/custom_container.dart';
import '../widgets/spaces.dart';
import '../widgets/text_widget.dart';

class BankTransferMethod extends StatelessWidget {
  const BankTransferMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Bank Transfer Method'),
      body: Padding(
          padding: symmetricEdgeInsets(horizontal: 24, vertical: 49),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(56),
              TextWidget(
                text: 'Chose one of our banks',
                fontWeight: MyFontWeight.semiBold,
                textSize: MyFontSize.size15,
              ),
              verticalSpace(20),
              CustomContainer(
                width: double.infinity,
                height: 45,
                borderColor: const Color(0xFFD5D5DC),
                child: Padding(
                  padding: symmetricEdgeInsets(horizontal: 11, vertical: 11),
                  child: Row(
                    children: [
                      CustomSizedBox(
                        width: 85,
                        height: 23,
                        child: Image.network('d'),
                      ),
                      horizontalSpace(34),
                      TextWidget(text: 'Alinma Bank',textSize: 14,fontWeight: MyFontWeight.semiBold,)
                    ],
                  ),
                ),
              ),

              verticalSpace(24),
            ],
          )),
    );
  }
}
