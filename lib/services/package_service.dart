import 'dart:developer';

import 'package:intl/intl.dart';

import '../base/service/base_service.dart';
import '../models/manufacturersModel.dart';
import '../models/otherServicesModel.dart';
import '../models/packagesModel.dart';
import '../models/requestResult.dart';
import '../models/request_details_model.dart';
import '../models/slotsModel.dart';
import '../models/vehiclesModelsModel.dart';
import '../models/vehiclesTypesActiveModel.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class PackageService extends BaseService {
  Future<ResponseResult> getVehiclesTypes() async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};

    List<VehiclesActiveTypesData> vehiclesTypesDataList = [];
    try {
      await requestFutureData(
          api: Api.getVehicles,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              vehiclesTypesDataList =
                  VehiclesActiveTypesModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Vehicle Models Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Vehicle Models Data$e");
    }
    return ResponseResult(result, vehiclesTypesDataList);
  }

  Future<ResponseResult> getManufacturers() async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};


    List<ManufacturerData> manufacturerDataList = [];
    try {
      await requestFutureData(
          api: Api.getManufacturers,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              manufacturerDataList =
                  ManufacturersModel.fromJson(response).data!;
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

  Future<ResponseResult> getManufacturersOfType(
      {required int vehicleTypeId}) async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};
    List<ManufacturerData> manufacturerDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getManufacturersOfType}$vehicleTypeId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              manufacturerDataList =
                  ManufacturersModel.fromJson(response).data!;
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
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};

    List<VehiclesModelsData> vehiclesModelsDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getVehiclesModels}$manufactureId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              vehiclesModelsDataList =
                  VehicleModelsModel.fromJson(response).data!;
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

  Future<ResponseResult> getPackages({required int cityId}) async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};

    List<PackagesData> packagesDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getPackages}city_id=$cityId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
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

  Future<ResponseResult> getPackageTimeSlots({
    required int cityId,
    required int packageId,
    required int packageDuration,
    required String date,
  }) async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};

    List<List<SlotData>>? slots = [];
    try {
      await requestFutureData(
          api: Api.getPackageSlots(
            cityId: cityId,
            packageId: packageId,
            packageDuration: packageDuration,
            date: date,
          ),
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              slots = SlotsModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Get Package Time Slot\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Get Package Time Slot$e");
    }
    return ResponseResult(result, slots);
  }

  Future<ResponseResult> storeInitialPackageRequest({
    required int cityId,
    required int packageId,
    required int vehicleId,
  }) async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};
    dynamic message;
    Map<String, dynamic> body = {
      "city_id": cityId,
      "package_id": packageId,
      "vehicle_id": vehicleId,
    };
    DetailsRequestData? detailsRequestData;
    try {
      await requestFutureData(
          api: Api.storeInitialPackageRequest,
          requestType: Request.post,
          body: body,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              if (response["status_code"] == 200) {
                result = Status.success;
                detailsRequestData = DetailsRequestModel.fromJson(response).data!;
              } else if (response["status_code"] == 422 ||
                  response["status_code"] == 400) {
                // result = Status.success;
                result = Status.error;
                message = response["message"];
              }
            } catch (e) {
              message = response["message"];
              logger.e(
                  "Error getting response store Initial Package Request Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting store Initial Package Request Data$e");
    }
    return ResponseResult(result, detailsRequestData, message: message);
  }

  Future<ResponseResult> saveSlotsPackageRequest({required Map<String, dynamic> mapBody}) async {
    Status result = Status.error;

    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};
    dynamic message;
    Map<String, dynamic> body = mapBody;
    // DetailsRequestData? detailsRequestData;
    try {
      print('object in out of service');
      await requestFutureData(
          api: Api.saveSlotsPackageRequest,
          requestType: Request.post,
          body: body,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            print('object in service');

            try {
              if (response["status_code"] == 200) {
                result = Status.success;
                // detailsRequestData = DetailsRequestModel.fromJson(response).data!;
              } else if (response["status_code"] == 422 ||
                  response["status_code"] == 400) {
                // result = Status.success;
                result = Status.error;
                message = response["message"];
              }
            } catch (e) {
              message = response["message"];
              logger.e(
                  "Error getting response save Slots Package Request Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting save Slots Package Request Data$e");
    }
    return ResponseResult(result, ''/*detailsRequestData*/, message: message);
  }


}
