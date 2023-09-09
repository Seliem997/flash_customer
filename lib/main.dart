import 'dart:developer';

import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_customer/providers/about_provider.dart';
import 'package:flash_customer/providers/addresses_provider.dart';
import 'package:flash_customer/providers/home_provider.dart';
import 'package:flash_customer/providers/myRequests_provider.dart';
import 'package:flash_customer/providers/myVehicles_provider.dart';
import 'package:flash_customer/providers/notifications_provider.dart';
import 'package:flash_customer/providers/otherServices_provider.dart';
import 'package:flash_customer/providers/package_provider.dart';
import 'package:flash_customer/providers/payment_provider.dart';
import 'package:flash_customer/providers/requestServices_provider.dart';
import 'package:flash_customer/providers/transactionHistory_provider.dart';
import 'package:flash_customer/providers/user_provider.dart';
import 'package:flash_customer/services/firebase_service.dart';
import 'package:flash_customer/ui/home/home_screen.dart';
import 'package:flash_customer/ui/splash/app_splash.dart';
import 'package:flash_customer/utils/cache_helper.dart';
import 'package:flash_customer/utils/enum/shared_preference_keys.dart';
import 'package:flash_customer/utils/styles/colors.dart';
import 'package:flash_customer/utils/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  FastCachedImageConfig.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseService.initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeLanguage(newLocale);
  }

  static void changeThemeMode(BuildContext context) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeThemeMode();
  }

  static bool themeMode(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    return state.isDarkMode;
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  late bool loggedIn = false;
  late bool showOnBoarding = false;
  bool isDarkMode = false;

  void changeThemeMode() {
    isDarkMode = !isDarkMode;
    setState(() {});
    if (isDarkMode) {
      CacheHelper.saveData(key: CacheKey.darkMode, value: true);
    } else {
      CacheHelper.saveData(key: CacheKey.darkMode, value: false);
    }
  }

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
    log(locale.languageCode);
    CacheHelper.saveData(key: CacheKey.language, value: locale.languageCode);
  }

  @override
  initState() {
    loadData();
    if (CacheHelper.returnData(key: CacheKey.darkMode) != null) {
      isDarkMode = CacheHelper.returnData(key: CacheKey.darkMode);
    }
    super.initState();
  }

  void loadData() {
    if (CacheHelper.returnData(key: CacheKey.language) != null) {
      _locale = Locale(CacheHelper.returnData(key: CacheKey.language));
    }
    if (CacheHelper.returnData(key: CacheKey.loggedIn) != null) {
      loggedIn = CacheHelper.returnData(key: CacheKey.loggedIn);
    }
    if (CacheHelper.returnData(key: CacheKey.showOnBoarding) != null) {
      showOnBoarding = CacheHelper.returnData(key: CacheKey.showOnBoarding);
    }
    // if (CacheHelper.returnData(key: CacheKey.darkMode) != null) {
    //   isDarkMode = CacheHelper.returnData(key: CacheKey.darkMode);
    // }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        isDarkMode ? true : false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OtherServicesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AboutProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddressesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PackageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransactionHistoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyVehiclesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RequestServicesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyRequestsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => NotificationsProvider(),
        ),
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        UserProvider userProvider = Provider.of<UserProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flash Customer',
          theme: isDarkMode
              ? ThemeData.dark().copyWith(
                  appBarTheme: const AppBarTheme(
                      color: AppColor.darkScaffoldColor,
                      iconTheme: IconThemeData(color: Colors.white)),
                  scaffoldBackgroundColor: AppColor.darkScaffoldColor)
              : ThemeData(
                  primarySwatch: Colors.blue,
                  appBarTheme: const AppBarTheme(
                      color: AppColor.white,
                      iconTheme: IconThemeData(color: Colors.black)),
                  scaffoldBackgroundColor: AppColor.lightScaffoldColor),
          darkTheme: darkTheme,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: S.delegate.supportedLocales,
          locale: _locale,
          // home: const HomeScreen(),
          home: const AppSplash(),
        );
      }),
    );
  }
}
