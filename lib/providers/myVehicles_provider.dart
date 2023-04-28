import 'package:flutter/material.dart';

import '../models/myVehiclesModel.dart';
import '../models/vehicleDetailsModel.dart';
import '../services/myVehicles_service.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesProvider with ChangeNotifier {

  MyVehiclesService myVehiclesService = MyVehiclesService();
  bool loadingMyVehicles = true;
  MyVehiclesData? myVehiclesData;

  VehicleDetailsData? vehicleDetailsData;
  Future addNewVehicle({
    required String vehicleTypeId,
    required int manufacture,
    required int model,
    String? numbers,
    String? letters,
    String? color,
    String? name,
    String? year,
  }) async {
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
        vehicleDetailsData = value.data;
        print('Added New Vehicle In Provider Successfully');
      }
    });
  }

  Future getMyVehicles() async {
    myVehiclesData = null;
    loadingMyVehicles = true;
    notifyListeners();
    await myVehiclesService.getMyVehicles().then((value) {
      loadingMyVehicles = false;
      if (value.status == Status.success) {
        myVehiclesData = value.data;
      }
    });
    notifyListeners();
  }
}
