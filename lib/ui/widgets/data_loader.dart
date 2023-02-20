import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class DataLoader extends StatelessWidget {
  const DataLoader({Key? key, this.useExpand = false}) : super(key: key);
  final bool useExpand;
  @override
  Widget build(BuildContext context) {
    return useExpand
        ? const Expanded(
            child: Center(
                child: CircularProgressIndicator(
            color: AppColor.primary,
          )))
        : const Center(
            child: CircularProgressIndicator(
            color: AppColor.primary,
          ));
  }
}
