import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../utils/colors.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_text_form.dart';


class OtpCell extends StatelessWidget {
  final int index;
  const OtpCell({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CustomContainer(
      width: 48,
      height: 48,
      padding: symmetricEdgeInsets(horizontal: 8),
      margin: onlyEdgeInsets(end: index != 4 ? 16 : 0),
      borderColor: AppColor.borderBlue,
      child: Center(
        child: CustomTextForm(
          padding: 6,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.phone,
          hintText: '...',
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
          },
        ),
      ),
    );
  }
}
