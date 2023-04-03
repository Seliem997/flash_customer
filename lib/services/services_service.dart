
import 'dart:developer';

import '../base/service/base_service.dart';
import '../models/requestResult.dart';
import '../models/servicesModel.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class ServicesService extends BaseService {

  Future<ResponseResult> getBasicServices() async {
    Status result = Status.error;
    Map<String, String> headers = const {
      'Content-Type': 'application/json'};

    List<BasicServicesData> basicServicesDataList = [];
    try {
      await requestFutureData(
          api: Api.getBasicServices,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              basicServicesDataList = BasicServicesModel.fromJson(response).data!;

            } catch (e) {
              logger.e("Error getting response Services Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Services Data$e");
    }
    return ResponseResult(result, basicServicesDataList);
  }

  Future<ResponseResult> getExtraServices() async {
    Status result = Status.error;
    Map<String, String> headers = const {
      'Content-Type': 'application/json'};

    List<BasicServicesData> extraServicesDataList = [];
    try {
      await requestFutureData(
          api: Api.getExtraServices,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              extraServicesDataList = BasicServicesModel.fromJson(response).data!;

            } catch (e) {
              logger.e("Error getting response Services Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Services Data$e");
    }
    return ResponseResult(result, extraServicesDataList);
  }
}
