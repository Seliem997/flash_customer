

import 'package:flutter/material.dart';

import '../models/addressesModel.dart';
import '../models/requestResult.dart';
import '../services/addresses_services.dart';
import '../utils/enum/statuses.dart';

class AddressesProvider with ChangeNotifier{

  bool isLoading = true;
  AddressesService addressesService = AddressesService();

  void setLoading(bool value) {
    isLoading = value;
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
    await addressesService.storeAddress(type: type, locationName: locationName, lat: lat, long: long).then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        addressDetailsData = value.data;
       print('Added New address In Provider Successfully');
      }
    });
    return ResponseResult(state, addressDetailsData);
  }

  List<AddressesData> addressesDataList = [];
  Future getAddresses() async {
    setLoading(true);
    await addressesService.getAddresses().then((value) {
      if (value.status == Status.success) {
        addressesDataList = value.data;
      }
    });
    notifyListeners();
  }

  Future deleteAddress({required int addressID}) async {
    isLoading = true;
    notifyListeners();
    Status state = Status.error;
    dynamic message;

    await addressesService.deleteAddress(addressID: addressID).then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        message = value.message;
      }else{
        message = value.message;
      }
    });
    getAddresses().then((value) => isLoading = false);
    notifyListeners();
    return ResponseResult(state, '',message: message);
  }


}