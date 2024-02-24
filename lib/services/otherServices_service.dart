
import 'dart:developer';

import 'package:intl/intl.dart';

import '../base/service/base_service.dart';
import '../models/bookServicesModel.dart';
import '../models/otherServicesModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class OtherServicesService extends BaseService {

  Future<ResponseResult> getOtherServices({
    required cityId,
}) async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};
    dynamic message;

    List<OtherServicesData> otherServicesData = [];
    try {
      await requestFutureData(
          api: '${Api.getOtherServices}&city_id=$cityId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              otherServicesData = OtherServicesModel.fromJson(response).data!;
              message = response["message"];

            } catch (e) {
              logger.e("Error getting response Other Services Data\n$e");
              message = response["message"];
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Other Services Data$e");
    }
    return ResponseResult(result, otherServicesData, message: message);
  }

  Future<ResponseResult> storeInitialOtherService({
    required cityId,
    required addressId,
    required otherServiceId,
    required numberOfUnits,

  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};
    Map<String, dynamic> body = {
      "city_id": cityId,
      "address_id": addressId,
      "other_service_id": otherServiceId,
      "number_of_units": numberOfUnits,
    };
    BookServicesData? storeServicesData;
    try {
      await requestFutureData(
          api: Api.bookServices,
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              storeServicesData = BookServicesModel.fromJson(response).data!;
            } else if (response["status_code"] == 422 ||
                response["status_code"] == 400) {
              status = Status.codeNotCorrect;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in Store Initial Other Services $e");
    }
    return ResponseResult(status, storeServicesData, message: message);
  }

}
