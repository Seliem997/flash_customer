
import 'dart:developer';

import '../base/service/base_service.dart';
import '../models/otherServicesModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class OtherServicesService extends BaseService {

  Future<ResponseResult> getOtherServices() async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    List<OtherServicesData> otherServicesData = [];
    try {
      await requestFutureData(
          api: Api.getOtherServices,
          requestType: Request.get,
          jsonBody: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              otherServicesData = OtherServicesModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Other Services Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Other Services Data$e");
    }
    return ResponseResult(result, otherServicesData);
  }
}
