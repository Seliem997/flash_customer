
import 'dart:developer';

import 'package:intl/intl.dart';

import '../base/service/base_service.dart';
import '../models/aboutModel.dart';
import '../models/otherServicesModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class AboutService extends BaseService {

  Future<ResponseResult> getAbout() async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};

    List<AboutData> aboutDataList = [];
    try {
      await requestFutureData(
          api: Api.getAbout,
          requestType: Request.get,
          jsonBody: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              aboutDataList = AboutModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response About Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting About Data$e");
    }
    return ResponseResult(result, aboutDataList);
  }

  Future<ResponseResult> getAboutImages() async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};

    List<AboutImagesData> aboutImagesDataList = [];
    try {
      await requestFutureData(
          api: Api.getAboutImages,
          requestType: Request.get,
          jsonBody: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              aboutImagesDataList = AboutImagesModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response About Images Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting About Images Data$e");
    }
    return ResponseResult(result, aboutImagesDataList);
  }


  Future<ResponseResult> contactUs({
    required String phoneNumber,
    required String message,
    String? name,
    String? email,
  }) async {
    Status status = Status.error;
    dynamic responseMessage;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};
    Map<String, dynamic> body = {"phone_number": phoneNumber, "phone_dial": '+966', "message": message, "name": name, "email": email};
    try {
      await requestFutureData(
          api: Api.contactUs,
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              responseMessage = response["message"];
            } else if (response["status_code"] == 422 ||
                response["status_code"] == 400) {
              status = Status.codeNotCorrect;
              responseMessage = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in Contact us $e");
    }
    return ResponseResult(status, '', message: responseMessage);
  }




}
