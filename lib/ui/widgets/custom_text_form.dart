import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/colors.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
    this.onEditingComplete,
    this.textInputAction,
    this.keyboardType,
    this.hintText,
    this.onChanged,
    this.inputFormatters,
    this.validator,
    this.onSubmit,
    this.controller,
    this.padding = 20, this.onTap, this.enabled= true,
  }) : super(key: key);

  final VoidCallback? onEditingComplete;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final String? hintText;
  final double? padding;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator? validator;
  final Function(dynamic)? onSubmit;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final GestureTapCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      onFieldSubmitted: onSubmit,
      validator: validator,
      onEditingComplete: onEditingComplete,
      textInputAction: textInputAction,
      style: const TextStyle(color: AppColor.secondary),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: !enabled,
        fillColor: AppColor.borderGreyLight,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColor.grey,
          fontSize: 12.sp,
        ),
        contentPadding: EdgeInsetsDirectional.only(start: 2.w),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
          // borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.white,
          ),
        ),
      ),
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
