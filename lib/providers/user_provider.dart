import 'dart:async';

import 'package:cross_file/src/types/interface.dart';
import 'package:flash_customer/utils/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import '../models/profileModel.dart';
import '../models/requestResult.dart';
import '../services/authentication_service.dart';
import '../utils/app_loader.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';
import '../utils/snack_bars.dart';

class UserProvider extends ChangeNotifier {
  AuthenticationService authenticationService = AuthenticationService();

  String? userName = CacheHelper.returnData(key: CacheKey.userName);
  String? userBalance = CacheHelper.returnData(key: CacheKey.balance);
  String? userImage = CacheHelper.returnData(key: CacheKey.userImage);
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



  ProfileData? profileData;
  Future<ResponseResult>checkCode(
      {required String phoneNumber, required String countryCode, required String otp}) async {
    Status state = Status.error;
    dynamic message;

    await authenticationService
        .checkCode(phoneNumber, countryCode, otp)
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        message = value.message;
        profileData = value.data;
        print("object Profile Data ${profileData!.fwId}");
      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, profileData, message: message);
  }


  Future<Status> updateUserProfile({
    required String name,
    required String email,
  }) async {
    Status status = Status.error;
    await authenticationService
        .updateProfile(name: name, email: email)
        .then((value) {
      if (value.status == Status.success) {
        status = Status.success;
        profileData = value.data;
        userName = (value.data as ProfileData).name;
        userImage = (value.data as ProfileData).image;
        CacheHelper.saveData(key: CacheKey.userImage, value: (value.data as ProfileData).image);
        userEmail = (value.data as ProfileData).email;
        userId = (value.data as ProfileData).fwId;
      }
      notifyListeners();
    });
    return status;
  }

  Future<Status> deleteAccount() async {
    Status status=Status.error;
    await authenticationService
        .deleteMyAccount()
        .then((value) {
      if(value.status == Status.success){
        CacheHelper.saveData(key: CacheKey.loggedIn, value: false);
        notifyListeners();
        authenticationService.signOut();
      }
    });

    return status;
  }


  //-------------------------------------------- change Language -------

  void changeLanguage(context) {
    if (Intl.getCurrentLocale() == 'ar') {
      MyApp.setLocale(context, const Locale("en"));
    } else {
      MyApp.setLocale(context, const Locale("ar"));
    }
    notifyListeners();
  }

  Future<void> updateProfilePicture(
      BuildContext context, String imagePath) async {

    AppLoader.showLoader(context);
    await authenticationService
        .updateProfilePicture(context,imagePath)
        .then((imageUrl) {
      if (imageUrl.status == Status.success) {
        CustomSnackBars.successSnackBar(context, "Updated Successfully");
        userImage = imageUrl.data;
        CacheHelper.saveData(key: CacheKey.userImage, value: imageUrl.data);
      } else {
        CustomSnackBars.failureSnackBar(context, "Something went wrong");
      }
    });
    notifyListeners();
  }
}
