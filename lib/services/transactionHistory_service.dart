
import 'dart:developer';

import 'package:intl/intl.dart';

import '../base/service/base_service.dart';

import '../models/requestResult.dart';
import '../models/transactionHistoryModel.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class TransactionHistoryService extends BaseService {

  Future<ResponseResult> getTransactionHistory () async {
    Status result = Status.error;
    Map<String, String> headers = {'Content-Type': 'application/json', 'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',};


    TransactionData? transactionData;
    try {
      await requestFutureData(
          api: Api.getTransactionHistory,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              transactionData = TransactionHistoryModel.fromJson(response).data!;

            } catch (e) {
              logger.e("Error getting response transaction Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting transaction Data$e");
    }
    return ResponseResult(result, transactionData);
  }

}
