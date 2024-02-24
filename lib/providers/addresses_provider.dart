
import 'package:flutter/material.dart';

import '../models/addressesModel.dart';
import '../models/requestResult.dart';
import '../services/addresses_services.dart';
import '../utils/enum/statuses.dart';

class AddressesProvider with ChangeNotifier{

  TextEditingController otherTextController = TextEditingController();

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
    dynamic message;
    await addressesService.storeAddress(type: type, locationName: locationName, lat: lat, long: long).then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        message = value.message;
        addressDetailsData = value.data;
      }else{
        message = value.message;
      }
    });
    return ResponseResult(state, addressDetailsData, message: message);
  }

  int currentPage= 1;
  int lastPage=1 ;


  List<AddressesData> addressesDataList = [];
  List<AddressesData> allAddressesDataList = [];
  Future getAddresses({int? page}) async {
    currentPage = addressesService.currentPage == null ? 1 : addressesService.currentPage!;
    lastPage = addressesService.lastPage == null ? 1 : addressesService.lastPage!;
    setLoading(true);
    if(page == null || page == 1){
      addressesDataList= [];
      allAddressesDataList = [];
    }
    await addressesService.getAddresses(page: page).then((value) {
      if (value.status == Status.success) {
        addressesDataList = value.data;
      }
    });
    allAddressesDataList.addAll(addressesDataList.toList());

    notifyListeners();
  }


  Future deleteAddress({required addressID}) async {
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