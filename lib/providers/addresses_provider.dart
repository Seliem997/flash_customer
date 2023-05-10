

import 'package:flutter/material.dart';

import '../models/addressesModel.dart';
import '../models/requestResult.dart';
import '../services/addresses_services.dart';
import '../utils/enum/statuses.dart';

class AddressesProvider with ChangeNotifier{

  bool isLoading = true;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }


  List<AddressesData> addressesDataList = [];
  Future getAddresses() async {
    setLoading(true);
    AddressesService addressesService = AddressesService();
    await addressesService.getAddresses().then((value) {
      if (value.status == Status.success) {
        addressesDataList = value.data;
      }
    });
    notifyListeners();
  }

  AddressesData? addressDetailsData;
  Future<ResponseResult> storeAddress({
    String? type,
    String? locationName,
    required double lat,
    required double long,
  }) async {
    Status state = Status.error;
    AddressesService addressesService = AddressesService();
    await addressesService.storeAddress(type: type, locationName: locationName, lat: lat, long: long).then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        addressDetailsData = value.data;
       print('Added New address In Provider Successfully');
      }
    });
    return ResponseResult(state, addressDetailsData);
  }


}