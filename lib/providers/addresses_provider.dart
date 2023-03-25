

import 'package:flutter/material.dart';

import '../models/addressesModel.dart';
import '../services/addresses_services.dart';
import '../utils/enum/statuses.dart';

class AddressesProvider with ChangeNotifier{

  List<AddressesData> addressesDataList = [];
  Future getAddresses() async {
    AddressesService addressesService = AddressesService();
    await addressesService.getAddresses().then((value) {
      if (value.status == Status.success) {
        addressesDataList = value.data;
      }
    });
    notifyListeners();
  }

}