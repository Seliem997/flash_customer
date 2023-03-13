import 'package:flash_customer/providers/user_provider.dart';
import 'package:flash_customer/ui/contact/contact_us.dart';
import 'package:flash_customer/ui/splash/app_splash.dart';
import 'package:flash_customer/utils/cache_helper.dart';
import 'package:flash_customer/utils/enum/shared_preference_keys.dart';
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

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;
  late bool loggedIn = false;
  late bool showOnBoarding = false;

  changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
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
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flash Customer',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
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
