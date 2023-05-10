import 'dart:developer';

import '../base/service/base_service.dart';
import '../models/loginModel.dart';
import '../models/profileModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';

class AuthenticationService extends BaseService {
  // final fb = FacebookLogin(debug: true);

  // Future<ResponseResult> forgotPassword(String email) async {
  //   Status status = Status.error;
  //   // late LoginModel loginModel;
  //   Map<String, dynamic> body = {"nameOrEmail": email};
  //   try {
  //     await requestFutureData(
  //         api: Api.forgotPassword,
  //         body: body,
  //         requestType: Request.post,
  //         onSuccess: (response) {
  //           if (response["status_code"] == 200) {
  //             status = Status.success;
  //           } else if (response["status_code"] == 400) {
  //             status = Status.emailNotRegistered;
  //           }
  //         });
  //   } catch (e) {
  //     status = Status.error;
  //     logger.e("Error in forgot password $e");
  //   }
  //   return ResponseResult(status, "");
  // }

  Future<ResponseResult> checkCode(
      String phoneNumber, String countryCode, String otp) async {
    Status status = Status.error;
    Map<String, String> header = {'Content-Type' : 'application/json'};
    Map<String, dynamic> body = {
      "phone": phoneNumber,
      "otp": otp,
      "country_code": countryCode
    };
    try {
      await requestFutureData(
          api: Api.checkCode,
          body: body,
          headers: header,
          jsonBody: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              print("Bearer ${response["data"]["token"]}");
              CacheHelper.saveData(key: CacheKey.balance, value: response["data"]["users"]["balance"]);
              CacheHelper.saveData(key: CacheKey.loggedIn, value: true);
              CacheHelper.saveData(
                  key: CacheKey.token,
                  value: "Bearer ${response["data"]["token"]}");
            } else if (response["status_code"] == 400) {
              status = Status.codeNotCorrect;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in checking code $e");
    }
    return ResponseResult(status, "");
  }


  Future<ResponseResult> updateProfile({required String name,required String email,}) async {
    Status status = Status.error;
    Map<String, String> header = {'Content-Type' : 'application/json'};
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
          onSuccess: (response) async{
            if (response["status_code"] == 200) {
              print('service updated done');
              status = Status.success;
              userData = UpdateProfileModel.fromJson(response).data;

              await CacheHelper.saveData(key: CacheKey.userId, value: userData!.fwId);
              await CacheHelper.saveData(key: CacheKey.userName, value: name);
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

  // Future<ResponseResult> resetPassword(
  //     String email, String code, String password) async {
  //   Status status = Status.error;
  //   Map<String, dynamic> body = {
  //     "email": email,
  //     "code": code,
  //     "password": password,
  //     "password_confirmation": password
  //   };
  //   try {
  //     await requestFutureData(
  //         api: Api.resetPassword,
  //         body: body,
  //         requestType: Request.post,
  //         onSuccess: (response) {
  //           if (response["status_code"] == 200) {
  //             status = Status.success;
  //           } else if (response["status_code"] == 400) {
  //             status = Status.codeNotCorrect;
  //           }
  //         });
  //   } catch (e) {
  //     status = Status.error;
  //     logger.e("Error in checking code $e");
  //   }
  //   return ResponseResult(status, "");
  // }
  //
  // Future<ResponseResult> signUp(
  //     String phoneNumber, String name, String email, String password) async {
  //   Status status = Status.error;
  //   String updatedPhone = phoneNumber;
  //   if (updatedPhone.length == 10) {
  //     updatedPhone = "0$updatedPhone";
  //   }
  //   Map<String, dynamic> body = {
  //     "phone": updatedPhone,
  //     "name": name,
  //     "email": email,
  //     "password": password,
  //     "country_id": "1",
  //     "city_id": "1",
  //   };
  //
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //     "Accept": "application/json"
  //   };
  //
  //   try {
  //     await requestFutureData(
  //         api: Api.register,
  //         body: body,
  //         jsonBody: true,
  //         headers: headers,
  //         requestType: Request.post,
  //         onSuccess: (response) async {
  //           if (response['status_code'] == 200) {
  //             status = Status.success;
  //             // userDataModel = RegistrationModel.fromJson(response);
  //           } /*else if (response['code'] == 401) {
  //             status = Status.emailAlreadyInUse.toString();
  //           }*/
  //         });
  //   } catch (e) {
  //     status = Status.error;
  //     log("Error in creating user $e");
  //   }
  //   return ResponseResult(status, "");
  // }
  //
  // Future<ResponseResult> sendContactService(
  //     {required String name,
  //     required String email,
  //     required String message}) async {
  //   Status status = Status.error;
  //   Map<String, dynamic> body = {
  //     "name": name,
  //     "email": email,
  //     "message": message,
  //   };
  //
  //   Map<String, String> headers = {
  //     "Content-Type": "application/json",
  //     "Accept": "application/json"
  //   };
  //
  //   try {
  //     await requestFutureData(
  //         api: Api.contactUs,
  //         body: body,
  //         jsonBody: true,
  //         headers: headers,
  //         requestType: Request.post,
  //         onSuccess: (response) async {
  //           if (response['status_code'] == 200) {
  //             status = Status.success;
  //           }
  //         });
  //   } catch (e) {
  //     status = Status.error;
  //     log("Error in creating user $e");
  //   }
  //   return ResponseResult(status, "");
  // }

  Future<ResponseResult> registerOrLogin(
      String phoneNumber, String countryCode) async {
    Status status = Status.error;
    late LoginModel loginModel;
    UserData? userData;
    Map<String, dynamic> body = {
      "phone": phoneNumber,
      "country_code": countryCode
    };
    try {
      await requestFutureData(
          api: Api.registerOrLogin,
          body: body,
          requestType: Request.post,
          onSuccess: (response) async {
            if (response["status_code"] == 200) {
              status = Status.success;
              // loginModel = LoginModel.fromJson(response);

              // CacheHelper.saveData(key: CacheKey.loggedIn, value: true);
              // userData = LoginModel.fromJson(response).data!.user!;
              // await CacheHelper.saveData(
              //     key: CacheKey.userName, value: userData!.name!);
              // await CacheHelper.saveData(
              //     key: CacheKey.userImage, value: userData!.image!);
              // await CacheHelper.saveData(
              //     key: CacheKey.email, value: userData!.email);

              await CacheHelper.saveData(
                  key: CacheKey.phoneNumber, value: phoneNumber);
              await CacheHelper.saveData(
                  key: CacheKey.countryCode, value: countryCode);
            } else if (response["status_code"] == 400) {
              status = Status.invalidEmailOrPass;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error Signing in $e");
    }
    return ResponseResult(status, userData);
  }

  // Future<ResponseResult> getMyProfile() async {
  //   Status status = Status.error;
  //   late UserData userData;
  //   try {
  //     await requestFutureData(
  //         api: Api.getMyProfile,
  //         withToken: true,
  //         requestType: Request.get,
  //         onSuccess: (response) async {
  //           if (response["status_code"] == 200) {
  //             status = Status.success;
  //             userData = ProfileModel.fromJson(response).data!;
  //             await CacheHelper.saveData(
  //                 key: CacheKey.userName, value: userData.name!);
  //             await CacheHelper.saveData(
  //                 key: CacheKey.userImage, value: userData.image!);
  //             await CacheHelper.saveData(
  //                 key: CacheKey.email, value: userData.email);
  //             await CacheHelper.saveData(
  //                 key: CacheKey.phoneNumber, value: userData.phone);
  //             await CacheHelper.saveData(
  //                 key: CacheKey.countryCode, value: userData.countryCode);
  //           } else if (response["status_code"] == 400) {
  //             status = Status.invalidEmailOrPass;
  //           }
  //         });
  //   } catch (e) {
  //     status = Status.error;
  //     logger.e("Error Signing in $e");
  //   }
  //   return ResponseResult(status, userData);
  // }

  // Future<ResponseResult> getUserData() async {
  //   Status result = Status.error;
  //   InfoData? userData;
  //   Map<String, String> headers = {
  //     'locale': 'ar',
  //     'Accept': 'application/json'
  //   };
  //   try {
  //     await requestFutureData(
  //         api: Api.getUserData,
  //         withToken: true,
  //         requestType: Request.get,
  //         headers: headers,
  //         onSuccess: (response) async {
  //           if (response['status_code'] == 200) {
  //             result = Status.success;
  //             userData = InfoModel.fromJson(response).data;
  //             await CacheHelper.saveData(
  //                 key: CacheKey.userName, value: userData!.name);
  //             await CacheHelper.saveData(
  //                 key: CacheKey.email, value: userData!.email);
  //             await CacheHelper.saveData(
  //                 key: CacheKey.phoneNumber, value: userData!.phone ?? "");
  //           } else {
  //             result = Status.error;
  //           }
  //         });
  //   } catch (e) {
  //     result = Status.error;
  //     logger.e("Error in creating user $e");
  //   }
  //   return ResponseResult(result, userData);
  // }

  void signOut() async {
    try {
      CacheHelper.saveData(key: CacheKey.loggedIn, value: false);
      CacheHelper.saveData(key: CacheKey.userName, value: "");
      CacheHelper.saveData(key: CacheKey.email, value: "");
    } catch (e) {
      log("Error Signing out $e");
    }
  }
}
