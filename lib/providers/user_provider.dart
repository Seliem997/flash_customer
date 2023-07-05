import 'dart:async';

import 'package:cross_file/src/types/interface.dart';
import 'package:flash_customer/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../models/profileModel.dart';
import '../services/authentication_service.dart';
import '../utils/app_loader.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';
import '../utils/snack_bars.dart';

class UserProvider extends ChangeNotifier {
  String? userName = CacheHelper.returnData(key: CacheKey.userName);
  String? userBalance = CacheHelper.returnData(key: CacheKey.balance);
  String? userImage;
  String? phone = CacheHelper.returnData(key: CacheKey.phoneNumber);
  String? userEmail = CacheHelper.returnData(key: CacheKey.email);
  String? userId = CacheHelper.returnData(key: CacheKey.userId);

  Timer? _timer;

  Timer? get timer => _timer;

  set timer(Timer? value) {
    _timer = value;
    notifyListeners();
  }

  List<String> otp = [
    '',
    '',
    '',
    '',
  ];

  String otpToString() {
    String otpString = '';
    for (var element in otp) {
      otpString += element;
    }
    return otpString;
  }

  Future<Status> updateUserProfile({
    required String name,
    required String email,
  }) async {
    Status status = Status.error;
    AuthenticationService authenticationService = AuthenticationService();
    await authenticationService
        .updateProfile(name: name, email: email)
        .then((value) {
      if (value.status == Status.success) {
        status = Status.success;
        userName = (value.data as ProfileData).name;
        userImage = (value.data as ProfileData).image;
        userEmail = (value.data as ProfileData).email;
        userId = (value.data as ProfileData).fwId;

      }
      notifyListeners();
    });
    return status;
  }

  // Future<Status> deleteAccount() async {
  //   AuthenticationService authenticationService = AuthenticationService();
  //   Status status=Status.error;
  //   await authenticationService
  //       .deleteAccount()
  //       .then((value) {
  //     status = value;
  //     if(status==Status.success){
  //       CacheHelper.saveData(key: "loggedIn", value: false);
  //       CacheHelper.signOut();
  //     }
  //   });
  //
  //   return status;
  // }

  //-------------------------------------------- change App Mode -------

  //-------------------------------------------- change Language -------

  void changeLanguage(context) {
    if (Intl.getCurrentLocale() == 'ar') {
      MyApp.setLocale(context, const Locale("en"));
    } else {
      MyApp.setLocale(context, const Locale("ar"));
    }
    notifyListeners();
  }

  Future<void> updateProfilePicture(BuildContext context, String imagePath) async {
    final AuthenticationService authenticationService = AuthenticationService();

    AppLoader.showLoader(context);
    await authenticationService.updateProfilePicture(imagePath).then((value) {
      AppLoader.stopLoader();
      if (value.status == Status.success) {
        CustomSnackBars.successSnackBar(context, "Updated Successfully");
        userImage = value.data;
        CacheHelper.saveData(key: CacheKey.userImage, value: value.data);
      } else {
        CustomSnackBars.failureSnackBar(context, "Something went wrong");
      }
    });
  }
}
