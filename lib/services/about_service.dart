
import 'dart:developer';

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
    Map<String, String> headers = const {'Content-Type': 'application/json'};

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
    Map<String, String> headers = const {'Content-Type': 'application/json'};

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
}
