import 'package:flutter/material.dart';

import '../models/myVehiclesModel.dart';
import '../models/requestResult.dart';
import '../models/vehicleDetailsModel.dart';
import '../services/myVehicles_service.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesProvider with ChangeNotifier {

  MyVehiclesService myVehiclesService = MyVehiclesService();
  bool loadingMyVehicles = true;
  MyVehiclesData? myVehiclesData;
  int? selectedMyVehicleIndex;

  void setSelectedMyVehicle({required int index}) {
    selectedMyVehicleIndex = index;
    notifyListeners();
  }

  VehicleDetailsData? vehicleDetailsData;
  Future<ResponseResult> addNewVehicle({
    required String vehicleTypeId,
    required int manufacture,
    required int model,
    String? numbers,
    String? letters,
    String? color,
    String? name,
    String? year,
  }) async {
    Status state = Status.error;
    await myVehiclesService
        .addVehicle(
      vehicleTypeId: vehicleTypeId,
      manufacture: manufacture,
      model: model,
      numbers: numbers,
      letters: letters,
      color: color,
      name: name,
      year: year,
    )
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        vehicleDetailsData = value.data;
        print('Added New Vehicle In Provider Successfully');
      }
    });
    return ResponseResult(state, vehicleDetailsData);
  }

  Future getMyVehicles() async {
    myVehiclesData = null;
    loadingMyVehicles = true;
    notifyListeners();
    await myVehiclesService.getMyVehicles().then((value) {
      if (value.status == Status.success) {
        myVehiclesData = value.data;
        loadingMyVehicles = false;
      }
    });
    notifyListeners();
  }
}
