import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    this.color,
    this.textSize = 16,
    this.maxLines = 10,
    this.height = 1.0,
    this.fontWeight = FontWeight.w400,
    this.isTitle = false,
    this.textAlign,
    this.width,
    this.textScaleFactor,
  }) : super(key: key);
  final String text;
  final Color? color;
  final double textSize;
  final double height;
  final double? width;
  final double? textScaleFactor;
  final bool isTitle;
  final int maxLines;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider=Provider.of<UserProvider>(context);
    return SizedBox(
      width: width,
      child: Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        textScaleFactor: textScaleFactor,
        overflow: TextOverflow.ellipsis,

        style: TextStyle(
          fontSize: textSize,
          color: color ?? (userProvider.isDark ? Colors.white : Colors.black),
          height: height,
          overflow: TextOverflow.ellipsis,
          fontFamily: "Montserrat",
          fontWeight: isTitle ? FontWeight.w500 : fontWeight,
          letterSpacing: 1,

        ),
      ),
    );
  }
}
