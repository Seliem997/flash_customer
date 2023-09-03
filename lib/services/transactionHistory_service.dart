
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


  Future<ResponseResult> rechargeWallet({
    required String chargeId,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {"charge_id": chargeId,};
    RechargeWalletData? rechargeWalletData;
    try {
      await requestFutureData(
          api: Api.walletCharge,
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              message = response["message"];
              rechargeWalletData = RechargeWalletModel.fromJson(response).data;
            } else if (response["status_code"] == 422 ||
                response["status_code"] == 400) {
              status = Status.error;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in Wallet Charging Request $e");
    }
    return ResponseResult(status, rechargeWalletData, message: message);
  }
}
