
import 'dart:developer';

import '../base/service/base_service.dart';
import '../models/manufacturersModel.dart';
import '../models/otherServicesModel.dart';
import '../models/packagesModel.dart';
import '../models/requestResult.dart';
import '../models/vehiclesModelsModel.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class PackageService extends BaseService {

  Future<ResponseResult> getManufacturers() async {
    Status result = Status.error;
    /*Map<String, String> headers = const {
      'Content-Type': 'application/json'};*/

    List<ManufacturerData> manufacturerDataList = [];
    try {
      await requestFutureData(
          api: Api.getManufacturers,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          // headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              manufacturerDataList = ManufacturersModel.fromJson(response).data!;

            } catch (e) {
              logger.e("Error getting response Manufacturer Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Manufacturer Data$e");
    }
    return ResponseResult(result, manufacturerDataList);
  }

  Future<ResponseResult> getVehiclesModels({required int manufactureId}) async {
    Status result = Status.error;

    List<VehiclesModelsData> vehiclesModelsDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getVehiclesModels}/$manufactureId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          onSuccess: (response) async {
            try {
              result = Status.success;
              vehiclesModelsDataList = VehicleModelsModel.fromJson(response).data!;

            } catch (e) {
              logger.e("Error getting response Vehicle Models Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Vehicle Models Data$e");
    }
    return ResponseResult(result, vehiclesModelsDataList);
  }

  Future<ResponseResult> getPackages() async {
    Status result = Status.error;

    List<PackagesData> packagesDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getPackages}per=month',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,

          onSuccess: (response) async {
            try {
              result = Status.success;
              packagesDataList = PackagesModel.fromJson(response).data!;

            } catch (e) {
              logger.e("Error getting response packages Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting packages Data$e");
    }
    return ResponseResult(result, packagesDataList);
  }

}
