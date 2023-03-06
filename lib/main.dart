import 'package:flash_customer/ui/contact/contact_us.dart';
import 'package:flash_customer/ui/splash/app_splash.dart';
import 'package:flash_customer/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
          title: 'Flash Customer',
          /*theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: AppCubit.get(context).isDark ? ThemeMode.light :ThemeMode.dark   ,*/
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
          // home: const ContactUs(),
          home: const AppSplash(),
        );
      }
    );
  }
}