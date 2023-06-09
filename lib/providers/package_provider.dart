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

  bool requiredManufacture = false;
  bool requiredModel = false;
  int vehicleTypeId = 1;
  int selectedVehicleTypeIndex = 0;
  int? selectedPackageIndex;
  int? packageWashingQuantities;

  Map washesTime = {};
  Map washesDate = {};

  void setSelectedVehicleType({required int index}) {
    selectedVehicleTypeIndex = index;
    notifyListeners();
  }

  void setVehicleTypeId({required int typeId}) {
    vehicleTypeId = typeId;
    notifyListeners();
  }

  void setRequiredManufacture() {
    requiredManufacture = true;
    notifyListeners();
  }

  void setRequiredModel() {
    requiredModel = true;
    notifyListeners();
  }

  bool chooseManufacture = false;
  bool chooseModel = false;

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
  Future getManufacturersOfType({required int vehicleTypeId}) async {
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
  Future getVehiclesModels({context, required int manufactureId}) async {
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
        required int cityId,
        required int packageId,
        required int vehicleId,
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
  Future getPackages({required int cityId}) async {
    await packageService.getPackages(cityId: cityId).then((value) {
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
  List<List<SlotData>> packageSlotsList = [];
  Future getPackageTimeSlots({
    required int cityId,
    required int packageId,
    required int packageDuration,
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
    notifyListeners();
  }

}
