import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.white,
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  primarySwatch: Colors.blue,
  // appBarTheme: const AppBarTheme(
  //   titleSpacing: 20,
  //   systemOverlayStyle: SystemUiOverlayStyle(
  //     statusBarColor: Colors.black26,
  //     statusBarIconBrightness: Brightness.dark,
  //   ),
  //   titleTextStyle: TextStyle(
  //     color: Colors.black,
  //     fontSize: 24,
  //     fontWeight: FontWeight.bold,
  //     letterSpacing: 1.5,
  //   ),
  //   backgroundColor: Colors.transparent,
  //   elevation: 0.0,
  //   iconTheme: IconThemeData(
  //     color: kDefaultColor,
  //     size: 14,
  //   ),
  // ),
  // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //   selectedItemColor: kDefaultColor,
  //   unselectedItemColor: Colors.grey,
  //   elevation: 20.0,
  //   type: BottomNavigationBarType.fixed,
  //   backgroundColor: Colors.white,
  // ),
  // textTheme: const TextTheme(
  //   bodyText1: TextStyle(
  //     fontSize: 24,
  //     fontWeight: FontWeight.bold,
  //     color: Colors.black,
  //   ),
  //   subtitle1: TextStyle(
  //     fontSize: 18,
  //     fontWeight: FontWeight.w500,
  //   ),
  // ),

  // fontFamily: 'poppins',

);

ThemeData darkTheme= ThemeData(
  scaffoldBackgroundColor: AppColor.primaryDark,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  primarySwatch: Colors.blue,
  // colorScheme: const ColorScheme.dark(),
  // brightness: Brightness.dark,
  // appBarTheme: const AppBarTheme(
  //   titleSpacing: 20,
  //   systemOverlayStyle: SystemUiOverlayStyle(
  //     statusBarColor: kDefaultNightModeColor,
  //     // statusBarColor: Color(0xFF3A3B3C) ,
  //     statusBarIconBrightness: Brightness.light,
  //   ),
  //   titleTextStyle: TextStyle(
  //     color: Colors.white,
  //     fontSize: 22,
  //     fontWeight: FontWeight.w500,
  //     letterSpacing: 1.5,
  //   ),
  //   // backgroundColor: Colors.transparent,
  //   backgroundColor: Color(0xFF3A3B3C),
  //   elevation: 0.0,
  //   iconTheme: IconThemeData(
  //     color: kDefaultColor,
  //     size: 18,
  //   ),
  // ),
  // bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //     selectedItemColor: kDefaultColor,
  //     unselectedItemColor: Colors.grey,
  //     elevation: 20.0,
  //     type: BottomNavigationBarType.fixed,
  //     backgroundColor: kDefaultNightModeColor,
  // ),
  //
  // textTheme: const TextTheme(
  //     bodyText1: TextStyle(
  //       fontSize: 24,
  //       fontWeight: FontWeight.bold,
  //       color: Colors.white,
  //     ),
  //     subtitle1: TextStyle(
  //       fontSize: 18,
  //       fontWeight: FontWeight.w500,
  //     ),
  // ),
  //
  // fontFamily: 'poppins',

);