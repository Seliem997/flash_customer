import 'package:flash_customer/providers/requestServices_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/manufacturersModel.dart';

import '../models/packagesModel.dart';
import '../models/requestResult.dart';
import '../models/request_details_model.dart';
import '../models/slotsModel.dart';
import '../models/vehiclesModelsModel.dart';
import '../models/vehiclesTypesActiveModel.dart';
import '../services/package_service.dart';
import '../utils/enum/statuses.dart';

class PackageProvider with ChangeNotifier {
  PackageService packageService = PackageService();


  int vehicleTypeId = 1;
  int selectedVehicleTypeIndex = 0;
  int? selectedPackageIndex;
  int? packageWashingQuantities;

  Map washesTime = {};
  Map washesDate = {};
  List employeeIdsList = [];
  List slotsIdsList = [];
  Map<String, List> washSlotsIdsMap = {};

  void setSelectedVehicleType({required int index}) {
    selectedVehicleTypeIndex = index;
    notifyListeners();
  }

  void setVehicleTypeId({required typeId}) {
    vehicleTypeId = typeId;
    notifyListeners();
  }


  bool requiredManufacture = false;
  bool requiredModel = false;
  bool chooseManufacture = false;
  bool chooseModel = false;

  void chooseRequiredManufacture({required bool value}) {
    requiredManufacture = value;
    notifyListeners();
  }

  void chooseRequiredModel({required bool value}) {
    requiredModel = value;
    notifyListeners();
  }

  List<VehiclesActiveTypesData> vehiclesTypesDataList = [];
  Future getVehiclesTypeActive() async {
    vehiclesTypesDataList = [];
    manufacturerDataList = [];
    notifyListeners();
    await packageService.getVehiclesTypes().then((value) {
      if (value.status == Status.success) {
        vehiclesTypesDataList = value.data;
      }
    });
    notifyListeners();
  }

  ManufacturerData? selectedManufacture;

  List<ManufacturerData> manufacturerDataList = [];
  Future getManufacturersOfType({required vehicleTypeId}) async {
    resetDropDownValues();
    await packageService
        .getManufacturersOfType(vehicleTypeId: vehicleTypeId)
        .then((value) {
      if (value.status == Status.success) {
        manufacturerDataList = value.data;
      }
    });
    notifyListeners();
  }

  Future getManufacturers() async {
    resetDropDownValues();
    await packageService
        .getManufacturersOfType(vehicleTypeId: vehicleTypeId)
        .then((value) {
      if (value.status == Status.success) {
        manufacturerDataList = value.data;
      }
    });
    notifyListeners();
  }

  void setSelectedManufacture(ManufacturerData manufacture) {
    selectedVehicleModel = null;
    selectedManufacture = manufacture;
    notifyListeners();
  }

  VehiclesModelsData? selectedVehicleModel;

  List<VehiclesModelsData> vehiclesModelsDataList = [];
  Future getVehiclesModels({context, required manufactureId}) async {
    final RequestServicesProvider requestServicesProvider =
        Provider.of<RequestServicesProvider>(context, listen: false);
    requestServicesProvider.isLoading = true;
    await packageService
        .getVehiclesModels(manufactureId: manufactureId)
        .then((value) {
      if (value.status == Status.success) {
        vehiclesModelsDataList = value.data;
      }
    });
    notifyListeners();
  }

  DetailsRequestData? detailsRequestData;
  Future<ResponseResult> storeInitialPackageRequest(
      BuildContext context, {
        required cityId,
        required packageId,
        required vehicleId,
      }) async {
    Status state = Status.error;
    dynamic message;

    await packageService
        .storeInitialPackageRequest(cityId: cityId, packageId: packageId, vehicleId: vehicleId)
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        detailsRequestData = value.data;
      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, detailsRequestData, message: message);
  }

  Map<String, dynamic> mapBody={};
  Future<ResponseResult> saveSlotsPackageRequest({required requestId}) async {
    Status state = Status.error;

    dynamic message;
    mapBody["id"] = requestId;
    for(int i=0; i<washesDate.length; i++){
      mapBody["date[$i]"] = washesDate[i];
      mapBody["employee[$i]"] = employeeIdsList[i];
      for(int x=0; x<washSlotsIdsMap["$i"]!.length; x++){
        mapBody["slots_id[$i][$x]"] = washSlotsIdsMap["$i"]![x];
      }
    }
    await packageService
        .saveSlotsPackageRequest(mapBody: mapBody)
        .then((value) {
        if (value.status == Status.success) {
        state = Status.success;
        washesTime = {};
        washesDate = {};
      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, '', message: message);
  }


  Future<ResponseResult> reserveRequestPackageSlots({required List slotsId, required String slotsDate, required reqId}) async {
    Status state = Status.error;

    dynamic message;

    await packageService
        .reserveRequestPackageSlots(slotsId: slotsId, slotsDate: slotsDate, reqId: reqId)
        .then((value) {
        if (value.status == Status.success) {
        state = Status.success;

      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, '', message: message);
  }

  void setSelectedVehicle(VehiclesModelsData vehicle) {
    selectedVehicleModel = vehicle;
    notifyListeners();
  }

  void resetDropDownValues() {
    manufacturerDataList = [];
    vehiclesModelsDataList = [];
    selectedVehicleModel = null;
    selectedManufacture = null;
    notifyListeners();
  }

  bool newVehicleLabel = true;
  bool myVehicleLabel = false;

  void selectedNewVehicleLabel() {
    newVehicleLabel = true;
    myVehicleLabel = false;
    notifyListeners();
  }

  void selectedMyVehicleLabel() {
    newVehicleLabel = false;
    myVehicleLabel = true;
    notifyListeners();
  }

  List<PackagesData> packagesDataList = [];
  Future getPackages({required vehicleTypeId, required vehicleSubTypeId, required cityId, }) async {
    await packageService.getPackages(vehicleTypeId: vehicleTypeId, vehicleSubTypeId: vehicleSubTypeId, cityId: cityId).then((value) {
      if (value.status == Status.success) {
        packagesDataList = value.data;
      }
    });
    notifyListeners();
  }

  void setSelectedPackage({required int index}) {
    selectedPackageIndex = index;
    notifyListeners();
  }

  bool isLoading = true;
  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
  List<List<SlotData>> packageSlotsList = [];
  Future getPackageTimeSlots({
    required cityId,
    required packageId,
    required packageDuration,
    required String date,
  }) async {
    isLoading = true;
    notifyListeners();
    await packageService
        .getPackageTimeSlots(cityId: cityId, packageId: packageId, packageDuration: packageDuration, date: date,)
        .then((value) {
      isLoading = false;
      if (value.status == Status.success) {
        packageSlotsList = value.data;
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
    selectedSlotIndex = null;
    washesTime = {};
    washesDate = {};
    notifyListeners();
  }

  void clearBorder() {
    requiredManufacture = false;
    requiredModel = false;
    chooseManufacture = false;
    chooseModel = false;
    notifyListeners();
  }

}
