import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const int screenHeight = 808; // deduct safe area space and device bottom bar
const int screenHeight2 =
    1323 - 808; // deduct safe area space and device bottom bar
const int screenWidth = 393;

SizedBox verticalSpace(double height) => SizedBox(
      height: (height / screenHeight * 100).h,
    );
SizedBox horizontalSpace(double width) => SizedBox(
      width: (width / screenWidth * 100).w,
    );

EdgeInsets symmetricEdgeInsets({double vertical = 0, double horizontal = 0}) =>
    EdgeInsets.symmetric(
      vertical: (vertical / screenHeight * 100).h,
      horizontal: (horizontal / screenWidth * 100).w,
    );

EdgeInsetsDirectional onlyEdgeInsets(
        {double top = 0,
        double bottom = 0,
        double end = 0,
        double start = 0}) =>
    EdgeInsetsDirectional.only(
      top: (top / screenHeight * 100).h,
      bottom: (bottom / screenHeight * 100).h,
      end: (end / screenWidth * 100).w,
      start: (start / screenWidth * 100).w,
    );
