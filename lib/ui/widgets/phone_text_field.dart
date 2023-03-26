import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/colors.dart';

class PhoneTextField extends StatelessWidget {
  const PhoneTextField(
      {Key? key,
      this.onChanged,
      required this.countryController,
      required this.phoneController,
      this.textInputAction,
      this.enabled = true})
      : super(key: key);
  final Function(String)? onChanged;
  final TextEditingController countryController;
  final TextEditingController phoneController;
  final TextInputAction? textInputAction;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w),
      decoration: BoxDecoration(
          color: enabled ? null : AppColor.grey,
          border: Border.all(width: 1, color: AppColor.borderGreyLight),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 9.w,
            child: TextField(
              controller: countryController,
              enabled: false,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          TextWidget(text: "|", color: AppColor.lightGrey, textSize: 26.sp),
          horizontalSpace(3),
          Expanded(
              child: TextFormField(
            textInputAction: textInputAction ?? TextInputAction.next,
            enabled: enabled,
            onChanged: onChanged,
            controller: phoneController,
            validator: (value) {
              if (value!.isEmpty ||
                  value.length < 10 ||
                  (value.length == 10 && value[0] != '1') ||
                  (value.length == 11 && value[0] != '0')) {
                return 'pleaseEnterAValidPhoneNumber';
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11)
            ],
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'phone',
            ),
          ))
        ],
      ),
    );
  }
}
