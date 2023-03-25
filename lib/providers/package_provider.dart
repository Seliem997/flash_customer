

import 'package:flutter/material.dart';

import '../models/manufacturersModel.dart';

import '../models/packagesModel.dart';
import '../models/vehiclesModelsModel.dart';
import '../services/package_service.dart';
import '../utils/enum/statuses.dart';

class PackageProvider with ChangeNotifier{

  ManufacturerData? selectedManufacture;

  List<ManufacturerData> manufacturerDataList = [];
  Future getManufacturers() async {
    PackageService packageService = PackageService();
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