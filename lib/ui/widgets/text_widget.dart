import 'package:flash_customer/main.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.colorDark,
    this.textSize = 16,
    this.maxLines = 10,
    this.height = 1.0,
    this.fontWeight = FontWeight.w400,
    this.isTitle = false,
    this.underLine = false,
    this.textAlign,
    this.width,
    this.textScaleFactor,
  }) : super(key: key);
  final String text;
  final Color color;
  final Color? colorDark;
  final double textSize;
  final double height;
  final double? width;
  final double? textScaleFactor;
  final bool isTitle;
  final bool underLine;
  final int maxLines;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        textScaleFactor: textScaleFactor,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          decoration: underLine ? TextDecoration.underline : null,
          fontSize: textSize,
          color: MyApp.themeMode(context) ? colorDark : color,
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
