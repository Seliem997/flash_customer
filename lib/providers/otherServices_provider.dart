

import 'package:flutter/material.dart';

import '../models/bookServicesModel.dart';
import '../models/otherServicesModel.dart';
import '../models/requestResult.dart';
import '../models/slotsModel.dart';
import '../services/otherServices_service.dart';
import '../services/requestServices_service.dart';
import '../utils/enum/statuses.dart';

class OtherServicesProvider with ChangeNotifier{
  OtherServicesService otherServicesService = OtherServicesService();


  bool isLoading = true;

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  int selectedOtherServiceId = 0;

  int? selectedServiceIndex;

  void selectedService({required int index}) {
    selectedServiceIndex = index;
    otherServicesList[selectedServiceIndex!].quantity == 0
        ? otherServicesList[selectedServiceIndex!].quantity = 1
        : otherServicesList[selectedServiceIndex!].quantity = otherServicesList[selectedServiceIndex!].quantity ;
    notifyListeners();
  }

  int selectedServiceQuantity = 0;

  void decreaseQuantityService(){
    selectedOtherServiceId = otherServicesList[selectedServiceIndex!].id!;
    if (otherServicesList[selectedServiceIndex!].quantity > 0) {
      otherServicesList[selectedServiceIndex!].quantity = otherServicesList[selectedServiceIndex!].quantity -1;
    }else{
      selectedServiceIndex = null;
    }
    notifyListeners();

  }

  void increaseQuantityService({required int selectedServiceIndex}){
    selectedOtherServiceId = otherServicesList[selectedServiceIndex].id!;
    if(otherServicesList[selectedServiceIndex].quantity ==0){
      otherServicesList[selectedServiceIndex].quantity =1;
    }else {
      otherServicesList[selectedServiceIndex].quantity++;
    }
    notifyListeners();
  }

  List<OtherServicesData> otherServicesList = [];
  Future getOtherServices({
    required cityId,
  }) async {
    isLoading = true;
    Status state = Status.error;
    dynamic message;
    await otherServicesService.getOtherServices(cityId: cityId).then((value) {
      isLoading = false;
      if (value.status == Status.success) {
        state = Status.success;
        otherServicesList = value.data;
      }else{
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, otherServicesList, message: message);
  }

  BookServicesData? storeServicesData;
  Future<ResponseResult> storeInitialOtherServices(
      BuildContext context, {
        required cityId,
        required addressId,
        required otherServiceId,
        required numberOfUnits,
      }) async {
    Status state = Status.error;
    dynamic message;

    await otherServicesService
        .storeInitialOtherService(cityId: cityId, addressId: addressId, otherServiceId: otherServiceId, numberOfUnits: numberOfUnits)
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        storeServicesData = value.data;
      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, storeServicesData, message: message);
  }


  List<List<SlotData>> slotsList = [];
  Future getOtherServicesSlots({
    required cityId,
    required serviceId,
    required double duration,
    required String date,
    required addressId,
  }) async {
    isLoading = true;
    notifyListeners();
    RequestServicesService servicesService = RequestServicesService();
    await servicesService
        .getTimeSlots(
      cityId: cityId,
      basicId: serviceId,
      duration: duration,
      date: date,
      addressId: addressId,
    )
        .then((value) {
      isLoading = false;
      if (value.status == Status.success) {
        slotsList = value.data;
      }
    });
    notifyListeners();
  }

  int? selectedSlotIndex;
  List slotsIds = [];
  String? selectedDate;

  void selectedTimeSlot({int? index}) {
    if(index == null){
      selectedSlotIndex = null;
    }else{
      selectedSlotIndex = index;
    }
    notifyListeners();
  }

  void clearServices() {
    slotsIds = [];
    selectedServiceIndex = null;
    selectedSlotIndex = null;
    notifyListeners();
  }

}