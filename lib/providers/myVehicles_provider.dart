import 'package:flutter/material.dart';

import '../models/myVehiclesModel.dart';
import '../services/myVehicles_service.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesProvider with ChangeNotifier {
  MyVehiclesService myVehiclesService = MyVehiclesService();
  bool loadingMyVehicles = true;
  MyVehiclesData? myVehiclesData;

  Future addNewVehicle({
    required String vehicleTypeId,
    required int manufacture,
    required int model,
    required String numbers,
    required String letters,
    required String color,
    required String name,
    required String year,
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
