import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flash_customer/ui/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../utils/colors.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String title;
  final bool withArrow;
  final Color? backgroundColor;

  CustomAppBar({
    Key? key,
    this.withArrow = true,
    required this.title,
    this.backgroundColor,
  })  : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(
        text: title,
        color: AppColor.black,
        textSize: 18,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: backgroundColor ?? Colors.white,
      leading: withArrow
          ? IconButton(
              icon: SvgPicture.asset(
                'assets/svg/arrow-left.svg',
                color: Colors.black,
                width: 5.w,
              ),
              onPressed: () => Navigator.pop(context),
              color: Colors.black,
              iconSize: 20.0,
            )
          : Container(),
      centerTitle: true,
      titleSpacing: 0,
      elevation: 0,
      actions: [
        Padding(
          padding: onlyEdgeInsets(end: 24),
          child: SvgPicture.asset('assets/svg/home_bold.svg'),
        ),
      ],
    );
  }
}
