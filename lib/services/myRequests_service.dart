import 'dart:developer';

import 'package:intl/intl.dart';

import '../base/service/base_service.dart';

import '../models/myRequestsModel.dart';
import '../models/myVehiclesModel.dart';
import '../models/requestResult.dart';
import '../models/vehicleDetailsModel.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class MyRequestsService extends BaseService {


  Future<ResponseResult> getMyRequests({String? status, String? dateFrom, String? dateTo}) async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };

    List<MyRequestsData>? myRequestsDataList;
    try {
      await requestFutureData(
          api: Api.getMyRequests(status: status, dateFrom: dateFrom, dateTo: dateTo),
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              myRequestsDataList = MyRequestsModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response my Requests Data List\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting my Requests Data List $e");
    }
    return ResponseResult(result, myRequestsDataList);
  }


  Future<ResponseResult> updateRequestStatus({
    required int requestId,
    required String status,
  }) async {
    Status result = Status.error;
    dynamic message;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {"status": status};
    try {
      await requestFutureData(
          api: Api.updateRequestStatus(requestId: requestId),
          requestType: Request.patch,
          jsonBody: true,
          withToken: true,
          body: body,
          headers: headers,
          onSuccess: (response) async {
            try {
              if (response["status_code"] == 200) {
                result = Status.success;

              } else if (response["status_code"] == 422 || response["status_code"] == 400) {
                result = Status.codeNotCorrect;
                message = response["message"];
              }
            } catch (e) {
              logger.e("Error getting response update Request status Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting update Request status Data$e");
    }
    return ResponseResult(result, '', message: message);
  }

}
