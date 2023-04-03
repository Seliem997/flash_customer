import 'dart:developer';

import '../base/service/base_service.dart';

import '../models/myVehiclesModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesService extends BaseService {

  Future<ResponseResult> addVehicle({
    required String vehicleTypeId,
    required int manufacture,
    required int model,
    required String numbers,
    required String letters,
    required String color,
    required String name,
    required String year,
  }) async {
    Status status = Status.error;
    Map<String, String> header = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "vehicle_type_id": vehicleTypeId,
      "name_en": name,
      "year": year,
      "color": color,
      "letters": letters,
      "numbers": numbers,
      "manufacturer_id": manufacture,
      "vehicle_model_id": model
    };
    try {
      await requestFutureData(
          api: Api.addNewVehicle,
          body: body,
          headers: header,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              print('Added New Vehicle Service Successfully');
            } else if (response["status_code"] == 400) {
              status = Status.codeNotCorrect;
              print("Error in response Added New Vehicle ");

            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in Added New Vehicle $e");
    }
    return ResponseResult(status, "");
  }

  Future<ResponseResult> getMyVehicles() async {
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
