import 'dart:developer';

import 'package:intl/intl.dart';

import '../base/service/base_service.dart';
import '../models/addressesModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class AddressesService extends BaseService {

  Future<ResponseResult> storeAddress({
    String? type,
    String? locationName,
    required double lat,
    required double long,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};
    Map<String, dynamic> body = {
      "type": type ?? "Home",
      "latitude": lat,
      "langitude": long,
      "location_name": locationName ?? "Location Name"
    };
    AddressesData? addressesData;
    try {
      await requestFutureData(
          api: Api.storeAddress,
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              message = response["message"];
              addressesData = AddressDetailsModel.fromJson(response).data!;
            } else if (response["status_code"] == 422) {
              status = Status.codeNotCorrect;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in store address $e");
    }
    return ResponseResult(status, addressesData, message: message);
  }

  int? currentPage;
  int? lastPage;

  Future<ResponseResult> getAddresses({int? page}) async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};

    List<AddressesData> addressesDataList = [];
    try {
      await requestFutureData(
          api: Api.getAddresses(page: page),
          requestType: Request.get,
          headers: headers,
          jsonBody: true,
          withToken: true,
          onSuccess: (response) async {
            try {
              result = Status.success;
              currentPage= response["data"]["current_page"];
              lastPage= response["data"]["last_page"];
              addressesDataList = AddressesModel.fromJson(response).data!.addressesData!;
            } catch (e) {
              logger.e("Error getting response Addresses Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Addresses Data$e");
    }
    return ResponseResult(result, addressesDataList);
  }

  Future<ResponseResult> deleteAddress({required addressID}) async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    dynamic message;

    try {
      await requestFutureData(
          api: '${Api.deleteAddress}$addressID',
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
              logger.e("Error getting response delete Address\n$e");
              message = response["message"];
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in deleting Address $e");
    }
    return ResponseResult(result, '', message: message);
  }

}
