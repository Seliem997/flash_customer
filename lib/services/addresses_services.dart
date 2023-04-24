import 'dart:developer';

import '../base/service/base_service.dart';
import '../models/addressesModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class AddressesService extends BaseService {

  Future<ResponseResult> storeAddress({
    required String type,
    String? locationName,
    required double lat,
    required double long,
  }) async {
    Status status = Status.error;
    Map<String, String> header = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "type": type,
      "latitude": lat,
      "langitude": long,
      "location_name": locationName ?? "Location Name"
    };
    try {
      await requestFutureData(
          api: Api.storeAddress,
          body: body,
          headers: header,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
            } else if (response["status_code"] == 422) {
              status = Status.codeNotCorrect;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in store address $e");
    }
    return ResponseResult(status, '');
  }



  Future<ResponseResult> getAddresses() async {
    Status result = Status.error;

    List<AddressesData> addressesDataList = [];
    try {
      await requestFutureData(
          api: Api.getAddresses,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          onSuccess: (response) async {
            try {
              result = Status.success;
              addressesDataList = AddressesModel.fromJson(response).data!;

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

}
