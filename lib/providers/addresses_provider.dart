

import 'package:flutter/material.dart';

import '../models/addressesModel.dart';
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


  Future storeAddress({
    required String type,
    String? locationName,
    required double lat,
    required double long,
  }) async {
    AddressesService addressesService = AddressesService();
    await addressesService.storeAddress(type: type, locationName: locationName, lat: lat, long: long).then((value) {
      if (value.status == Status.success) {
       print('Added New address In Provider Successfully');
      }
    });
  }

}