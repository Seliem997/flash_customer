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


  Future<ResponseResult> getMyRequests() async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };

    List<MyRequestsData>? myRequestsDataList;
    try {
      await requestFutureData(
          api: Api.getMyRequests,
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
}
