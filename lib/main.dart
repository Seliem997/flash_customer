import 'dart:developer';

import 'package:flash_customer/providers/about_provider.dart';
import 'package:flash_customer/providers/addresses_provider.dart';
import 'package:flash_customer/providers/home_provider.dart';
import 'package:flash_customer/providers/myRequests_provider.dart';
import 'package:flash_customer/providers/myVehicles_provider.dart';
import 'package:flash_customer/providers/otherServices_provider.dart';
import 'package:flash_customer/providers/package_provider.dart';
import 'package:flash_customer/providers/requestServices_provider.dart';
import 'package:flash_customer/providers/transactionHistory_provider.dart';
import 'package:flash_customer/providers/user_provider.dart';
import 'package:flash_customer/ui/contact/contact_us.dart';
import 'package:flash_customer/ui/splash/app_splash.dart';
import 'package:flash_customer/utils/cache_helper.dart';
import 'package:flash_customer/utils/enum/shared_preference_keys.dart';
import 'package:flash_customer/utils/styles/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) async {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.changeLanguage(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  late bool loggedIn = false;
  late bool showOnBoarding = false;
  // late bool isDarkMode = false;

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
    log(locale.languageCode);
    CacheHelper.saveData(
        key: CacheKey.language, value: locale.languageCode);
  }

  @override
  initState() {
    loadData();
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
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        UserProvider userProvider = Provider.of<UserProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flash Customer',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: userProvider.isDark ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: S.delegate.supportedLocales,
          locale: _locale,
          // home: const ContactUs(),
          home: const AppSplash(),
        );
      }),
    );
  }
}
