import 'package:flash_customer/ui/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/colors.dart';


class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  const ExpandableContainer({
    super.key,
    required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 180.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: (225 / screenWidth * 100).w,
      height: expanded ? expandedHeight : collapsedHeight,
      child: Container(
        padding: EdgeInsets.only(top:0.8.h ),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            border: Border.all(width: 1.0, color: Colors.transparent),
            color: const Color.fromRGBO(152, 152, 152, 0.56),
        ),
        child: child,
      ),
    );
  }
}
