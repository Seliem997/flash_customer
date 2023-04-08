

import 'package:flutter/material.dart';

import '../models/manufacturersModel.dart';

import '../models/packagesModel.dart';
import '../models/vehiclesModelsModel.dart';
import '../services/package_service.dart';
import '../utils/enum/statuses.dart';

class PackageProvider with ChangeNotifier{

  bool requiredManufacture = false;
  bool requiredModel = false;

  void setRequiredManufacture(){
    requiredManufacture = true;
    notifyListeners();
  }
  void setRequiredModel(){
    requiredModel = true;
    notifyListeners();
  }

  bool chooseManufacture = false;
  bool chooseModel = false;

  ManufacturerData? selectedManufacture;

  List<ManufacturerData> manufacturerDataList = [];
  Future getManufacturers() async {
    PackageService packageService = PackageService();
    resetDropDownValues();
    await packageService.getManufacturers().then((value) {
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
  Future getVehiclesModels({required int manufactureId}) async {
    PackageService packageService = PackageService();
    await packageService.getVehiclesModels(manufactureId: manufactureId).then((value) {
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


  void resetDropDownValues(){
    selectedVehicleModel = null;
    selectedManufacture = null;
    notifyListeners();
  }


  bool newVehicleLabel = true;
  bool myVehicleLabel = false;

  void selectedNewVehicleLabel(){
    newVehicleLabel = true;
    myVehicleLabel = false;
    notifyListeners();
  }
  void selectedMyVehicleLabel(){
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