import 'dart:convert';
import 'dart:developer';

import 'package:cross_file/src/types/interface.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:intl/intl.dart';

import '../base/service/base_service.dart';
import '../models/loginModel.dart';
import '../models/profileModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';
import 'package:http/http.dart' as http;

import 'firebase_service.dart';

class AuthenticationService extends BaseService {
  Future<ResponseResult> checkCode(
      String phoneNumber, String countryCode, String otp) async {
    Status status = Status.error;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    dynamic message;
    // TODO: add fcm_token field after its done in backend
    Map<String, dynamic> body = {
      "phone": phoneNumber,
      "otp": otp,
      "country_code": countryCode,
      // "fcm_token":await FirebaseService.getDeviceToken()
    };
    ProfileData? profileData;
    try {
      await requestFutureData(
          api: Api.checkCode,
          body: body,
          headers: headers,
          jsonBody: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              message = response["message"];
              //---------------------------------------------------------------------- عايز اعرف السبب اللي ميخليش الداتا تدخل البروفايل داتا ------------------------
              profileData = UpdateProfileModel.fromJson(response).data!;

              print("Bearer ${response["data"]["token"]}");
              CacheHelper.saveData(
                  key: CacheKey.balance,
                  value: response["data"]["users"]["balance"]);
              CacheHelper.saveData(key: CacheKey.loggedIn, value: true);
              CacheHelper.saveData(key: CacheKey.userId, value: response["data"]["users"]["fw_id"]);
              CacheHelper.saveData(key: CacheKey.userImage, value: response["data"]["users"]["image"]);
              CacheHelper.saveData(
                  key: CacheKey.userName,
                  value: response["data"]["users"]["name"] ?? "New User");

              CacheHelper.saveData(
                  key: CacheKey.token,
                  value: "Bearer ${response["data"]["token"]}");
              print("service Profile Data ${profileData!.fwId}");
              print("cache Profile Data ${response["data"]["users"]["fw_id"]}");

            } else if (response["status_code"] == 400) {
              status = Status.codeNotCorrect;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in checking OTP code $e");
    }
    return ResponseResult(status, profileData, message: message);
  }

  Future<ResponseResult> updateProfile({
    required String name,
    required String email,
  }) async {
    Status status = Status.error;
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {
      "phone": CacheHelper.returnData(key: CacheKey.phoneNumber),
      "country_code": '+966',
      "name": name,
      "email": email,
      "_method": 'PUT'
    };
    ProfileData? userData;
    try {
      print(name);
      print(email);
      print(CacheHelper.returnData(key: CacheKey.phoneNumber));

      await requestFutureData(
          api: Api.updateMyProfile,
          body: body,
          jsonBody: true,
          withToken: true,
          headers: header,
          requestType: Request.post,
          onSuccess: (response) async {
            if (response["status_code"] == 200) {
              print('service updated done');
              status = Status.success;
              userData = UpdateProfileModel.fromJson(response).data;

              await CacheHelper.saveData(key: CacheKey.userName, value: name);
              await CacheHelper.saveData(
                  key: CacheKey.userImage, value: userData!.image);
              await CacheHelper.saveData(key: CacheKey.email, value: email);
            } else if (response["status_code"] == 400) {
              status = Status.codeNotCorrect;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in checking code $e");
    }
    return ResponseResult(status, userData);
  }

  Future<ResponseResult> registerOrLogin(
      String phoneNumber, String countryCode) async {
    Status status = Status.error;
    Map<String, String> headers = {
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    dynamic message;
    Map<String, dynamic> body = {
      "phone": phoneNumber,
      "country_code": countryCode
    };
    try {
      await requestFutureData(
          api: Api.registerOrLogin,
          body: body,
          headers: headers,
          requestType: Request.post,
          onSuccess: (response) async {
            if (response["status_code"] == 200) {
              status = Status.success;

              message = response["message"];

              await CacheHelper.saveData(
                  key: CacheKey.phoneNumber, value: phoneNumber);
              await CacheHelper.saveData(
                  key: CacheKey.countryCode, value: countryCode);
            } else if (response["status_code"] == 400) {
              status = Status.invalidEmailOrPass;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error Signing in $e");
    }
    return ResponseResult(status, '', message: message);
  }


  Future<ResponseResult> getSocialLinks() async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    SocialLinksModel? socialLinksData;

    try {
      await requestFutureData(
          api: Api.getSocialLinks,
          withToken: true,
          requestType: Request.get,
          headers: headers,
          onSuccess: (response) async {
            if (response['status_code'] == 200) {
              result = Status.success;
              socialLinksData = SocialLinksModel.fromJson(response);
            } else {
              result = Status.error;
            }
          });
    } catch (e) {
      result = Status.error;
      logger.e("Error in creating user $e");
    }
    return ResponseResult(result, socialLinksData);
  }

  void signOut() async {
    try {
      CacheHelper.saveData(key: CacheKey.loggedIn, value: false);
      CacheHelper.saveData(key: CacheKey.userName, value: "");
      CacheHelper.saveData(key: CacheKey.email, value: "");
      CacheHelper.saveData(key: CacheKey.userImage, value: '');

    } catch (e) {
      log("Error Signing out $e");
    }
  }

  Future<ResponseResult> updateProfilePicture(context,String imagePath) async {
    Status status = Status.error;
    String imageUrl = "";

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${CacheHelper.returnData(key: CacheKey.token)}"
    };

    try {
      var request = http.MultipartRequest("POST", Uri.parse(Api.updateProfile));

      request.headers.addAll(headers);

      request.fields['_method'] = "PUT";
      request.fields['country_code'] = "+966";
      request.fields['phone'] =
          CacheHelper.returnData(key: CacheKey.phoneNumber);

      request.files.add(await http.MultipartFile.fromPath("image", imagePath));

      logger.i(
          "Request Called: ${Api.updateProfile}\nHeaders: ${request.headers}\nBody:${request.fields}\nFiles:${request.files}");

      await request.send().then((stream) async {
        await http.Response.fromStream(stream).then((value) {
          AppLoader.showLoader(context);
          final response = jsonDecode(value.body);
          // userDataResponse = UpdateProfileModel.fromJson(response);
          logger.i("Response: $response");
          if (response['status_code'] == 200) {
            log("Successss");
            imageUrl = response['data']['image'];
            status = Status.success;
          } else if (response['status_code'] == 400) {
            status = Status.error;
            log("Failureee");
          }
        });
      }).timeout(const Duration(seconds: 30));
    } catch (e) {
      logger.e("Error in checking code $e");
      status = Status.error;
    }
    log("Status ${status.key}");
    return ResponseResult(status, imageUrl);
  }

  Future<ResponseResult> deleteMyAccount() async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {
      "_method": "delete"
    };
    dynamic message;

    try {
      await requestFutureData(
          api: Api.deleteMyAccount,
          requestType: Request.post,
          jsonBody: true,
          withToken: true,
          headers: headers,
          body: body,
          onSuccess: (response) async {
            try {
              result = Status.success;
              message = response["message"];
            } catch (e) {
              logger.e("Error getting response delete Account\n$e");
              message = response["message"];
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in deleting Account $e");
    }
    return ResponseResult(result, '', message: message);
  }

}
