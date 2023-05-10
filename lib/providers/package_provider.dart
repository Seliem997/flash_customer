import 'package:flash_customer/providers/requestServices_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/manufacturersModel.dart';

import '../models/packagesModel.dart';
import '../models/vehiclesModelsModel.dart';
import '../models/vehiclesTypesActiveModel.dart';
import '../services/package_service.dart';
import '../utils/enum/statuses.dart';

class PackageProvider with ChangeNotifier {
  bool requiredManufacture = false;
  bool requiredModel = false;
  int vehicleTypeId = 1;
  int selectedVehicleTypeIndex = 0;

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
    PackageService packageService = PackageService();
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
    PackageService packageService = PackageService();
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
    PackageService packageService = PackageService();
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
    PackageService packageService = PackageService();
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
  Future getPackages() async {
    PackageService packageService = PackageService();
    await packageService.getPackages().then((value) {
      if (value.status == Status.success) {
        packagesDataList = value.data;
      }
    });
    notifyListeners();
  }
}
