

import 'package:flutter/material.dart';

import '../models/transactionHistoryModel.dart';
import '../services/transactionHistory_service.dart';
import '../utils/enum/statuses.dart';

class TransactionHistoryProvider with ChangeNotifier{

  TextEditingController? rechargeAmountController ;


  TransactionData? transactionData;
  Future getTransactionHistory() async {
    TransactionHistoryService transactionHistoryService = TransactionHistoryService();
    await transactionHistoryService.getTransactionHistory().then((value) {
      if (value.status == Status.success) {
        transactionData = value.data;
      }
    });
    notifyListeners();
  }

  ChargeWalletUrl? chargeWalletUrl;
  Future chargingWalletUrl({required int amount, required String payBy,}) async {
    TransactionHistoryService transactionHistoryService = TransactionHistoryService();
    await transactionHistoryService.chargingWalletUrl(amount: amount, payBy: payBy).then((value) {
      if (value.status == Status.success) {
        chargeWalletUrl = value.data;
      }
    });
    notifyListeners();
  }

}