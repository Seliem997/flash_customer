

import 'package:flash_customer/models/requestResult.dart';
import 'package:flutter/material.dart';

import '../models/transactionHistoryModel.dart';
import '../services/transactionHistory_service.dart';
import '../utils/enum/statuses.dart';

class TransactionHistoryProvider with ChangeNotifier{

  TextEditingController? rechargeAmountController= TextEditingController() ;

bool isLoading = false;
  TransactionData? transactionData;
  Future getTransactionHistory() async {
    TransactionHistoryService transactionHistoryService = TransactionHistoryService();
    await transactionHistoryService.getTransactionHistory().then((value) {
      isLoading = true;
      notifyListeners();
      if (value.status == Status.success) {
        transactionData = value.data;
        isLoading = false;
      }
    });
    notifyListeners();
  }

  RechargeWalletData? rechargeWalletData;

  Future<ResponseResult> rechargeWallet({
    required String chargeId,
  }) async {
    Status state = Status.error;
    dynamic message;
    TransactionHistoryService transactionHistoryService = TransactionHistoryService();
    await transactionHistoryService.rechargeWallet(chargeId: chargeId).then((value) {
      isLoading = true;
      notifyListeners();
      if (value.status == Status.success) {
        state = Status.success;
        rechargeWalletData = value.data;
        getTransactionHistory();
      }
      isLoading = false;
    });
    notifyListeners();
    return ResponseResult(state, rechargeWalletData, message: message);
  }


}