import 'dart:developer';

import '../base/service/base_service.dart';
import '../models/addressesModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class AddressesService extends BaseService {

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
