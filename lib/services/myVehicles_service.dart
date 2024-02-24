import 'dart:developer';

import 'package:intl/intl.dart';

import '../base/service/base_service.dart';

import '../models/myVehiclesModel.dart';
import '../models/requestResult.dart';
import '../models/vehicleDetailsModel.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesService extends BaseService {

  Future<ResponseResult> addVehicle({
    required vehicleTypeId,
    required manufacture,
    required model,
    String? numbers,
    String? letters,
    String? color,
    String? name,
    String? year,
  }) async {
    Status status = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};
    Map<String, dynamic> body = {
      "vehicle_type_id": vehicleTypeId,
      if(name != null)"name_en": name,
      if(year != null)"year": year,
      if(color != null)"color": color,
      if(letters != null)"letters": letters,
      if(numbers != null)"numbers": numbers,
      "manufacturer_id": manufacture,
      "vehicle_model_id": model
    };
    VehicleDetailsData? vehicleDetailsData;
    try {
      await requestFutureData(
          api: Api.addNewVehicle,
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              vehicleDetailsData = VehicleDetailsModel.fromJson(response).data!;
            } else if (response["status_code"] == 400) {
              status = Status.codeNotCorrect;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in Added New Vehicle $e");
    }
    return ResponseResult(status, vehicleDetailsData);
  }

  Future<ResponseResult> updateVehicle({
    required vehicleId,
    required vehicleTypeId,
     subVehicleTypeId,
    required manufacture,
    required model,
    required customerId,
    String? numbers,
    String? letters,
    String? color,
    String? name,
    String? year,
  }) async {
    Status status = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};
    Map<String, dynamic> body = {
      "vehicle_type_id": vehicleTypeId,
      "name_en": name,
      "year": year,
      "color": color,
      "letters": letters,
      "numbers": numbers,
      "manufacturer_id": manufacture,
      "vehicle_model_id": model,
      // "sub_vehicle_type_id":subVehicleTypeId,
      if(subVehicleTypeId != null)"sub_vehicle_type_id": subVehicleTypeId,
      "customer_id":customerId
    };
    VehicleDetailsData? vehicleDetailsData;
    try {

      await requestFutureData(
          api: Api.updateVehicle(requestId: vehicleId),
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.put,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              vehicleDetailsData = VehicleDetailsModel.fromJson(response).data!;
            } else if (response["status_code"] == 400) {
              status = Status.codeNotCorrect;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in Added New Vehicle $e");
    }
    return ResponseResult(status, vehicleDetailsData);
  }

  Future<ResponseResult> getMyVehicles() async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
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

  Future<ResponseResult> deleteVehicle({required vehicleID}) async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    dynamic message;

    try {
      await requestFutureData(
          api: '${Api.deleteVehicle}$vehicleID',
          requestType: Request.delete,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              if (response["status_code"] == 200) {
                result = Status.success;
                message = response["message"];
              } else if (response["status_code"] == 400 || response["status_code"] == 401) {
                result = Status.codeNotCorrect;
                message = response["message"];
              }
            } catch (e) {
              logger.e("Error getting response delete Vehicle\n$e");
              message = response["message"];
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in deleting Vehicle $e");
    }
    return ResponseResult(result, '', message: message);
  }
}
