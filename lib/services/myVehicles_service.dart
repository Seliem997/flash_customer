
import 'dart:developer';

import '../base/service/base_service.dart';

import '../models/myVehiclesModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesService extends BaseService {

  Future<ResponseResult> getMyVehicles () async {
    Status result = Status.error;
    Map<String, String> headers = const {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    MyVehiclesData? myVehiclesData;
    try {
      await requestFutureData(
          api: Api.getMyVehicles,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              myVehiclesData = MyVehiclesModel.fromJson(response).data!;

            } catch (e) {
              logger.e("Error getting response MyVehicles Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting MyVehicles Data$e");
    }
    return ResponseResult(result, myVehiclesData);
  }
}
