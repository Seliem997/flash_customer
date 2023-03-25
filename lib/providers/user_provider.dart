import 'dart:async';

import 'package:flash_customer/utils/cache_helper.dart';
import 'package:flutter/material.dart';

import '../models/profileModel.dart';
import '../services/authentication_service.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';

class UserProvider extends ChangeNotifier {
  String? userName= CacheHelper.returnData(key: CacheKey.userName);
  String? userBalance= CacheHelper.returnData(key: CacheKey.balance);
  String? userImage;
  String phone= CacheHelper.returnData(key: CacheKey.phoneNumber);
  String? userEmail= CacheHelper.returnData(key: CacheKey.email);
  String? userId= CacheHelper.returnData(key: CacheKey.userId);



  Timer? _timer;

  Timer? get timer => _timer;

  set timer(Timer? value) {
    _timer = value;
    notifyListeners();
  }

  List<String> otp = ['', '', '', '',];

  String otpToString() {
    String otpString = '';
    for (var element in otp) {
      otpString += element;
    }
    return otpString;
  }


  Future<Status> updateUserProfile({required String name,required String email,}) async {
    Status status = Status.error;
    AuthenticationService authenticationService = AuthenticationService();
    await authenticationService.updateProfile(name: name, email: email)
        .then((value) {
         if( value.status == Status.success){
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


}
