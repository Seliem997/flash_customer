import 'package:flash_customer/ui/user/profile/edit_profile.dart';
import 'package:flash_customer/ui/user/register/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../models/loginModel.dart';
import '../../providers/user_provider.dart';
import '../../services/authentication_service.dart';
import '../../utils/cache_helper.dart';
import '../../utils/enum/shared_preference_keys.dart';
import '../../utils/enum/statuses.dart';
import '../home/home_screen.dart';
import '../user/login/login.dart';
import '../widgets/custom_container.dart';
import '../widgets/navigate.dart';

class AppSplash extends StatefulWidget {
  const AppSplash({Key? key}) : super(key: key);

  @override
  State<AppSplash> createState() => _AppSplashState();
}

class _AppSplashState extends State<AppSplash> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) => loadData());
    super.initState();
  }

  void loadData() async {
    // if (CacheHelper.returnData(key: CacheKey.loggedIn)) {
    //   final UserProvider userDataProvider =
    //       Provider.of<UserProvider>(context, listen: false);
    //   AuthenticationService authenticationService = AuthenticationService();
    //   await authenticationService.getMyProfile().then((result) {
    //     if (result.status == Status.success) {
    //       final userData = (result.data as UserData?);
    //       if ((result.data as UserData?) != null) {
    //         userDataProvider.phone = userData!.phone;
    //         userDataProvider.userName = userData.name;
    //         userDataProvider.userImage = userData.image;
    //         userDataProvider.email = userData.email;
    //         // userDataProvider.duties = userData.duties;
    //       }
    //     } else {
    //       authenticationService.signOut();
    //     }
    //   });
    // }
    await Future.delayed(const Duration(seconds: 4));
    navigateAndFinish(
      context, const HomeScreen(),
    );
    /*final bool loggedIn = CacheHelper.returnData(key: CacheKey.loggedIn);
    navigateAndFinish(
      context,
      !loggedIn ? const RegisterPhoneNumber() : const HomeScreen(),
    );*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/logo_animation.gif',fit: BoxFit.fitHeight,height: 100.h,),
      ),
    );
  }
}
