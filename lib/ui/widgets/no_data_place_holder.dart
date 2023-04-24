import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../../utils/styles/colors.dart';

class NoDataPlaceHolder extends StatelessWidget {
  const NoDataPlaceHolder({Key? key, this.useExpand = true}) : super(key: key);
  final bool useExpand;

  @override
  Widget build(BuildContext context) {
    return useExpand
        ? Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const TextWidget(
                text: 'no Data Available',
                color: AppColor.grey,
              ),
            ),
          )
        : const Center(
            child: TextWidget(
              text: 'no Data Available',
              color: AppColor.grey,
            ),
          );
  }
}
