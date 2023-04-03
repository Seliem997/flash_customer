import 'package:flutter/material.dart';

import '../models/myVehiclesModel.dart';
import '../services/myVehicles_service.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesProvider with ChangeNotifier {

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
    MyVehiclesService myVehiclesService = MyVehiclesService();
    await myVehiclesService.addVehicle(
      vehicleTypeId: vehicleTypeId,
      manufacture: manufacture,
      model: model,
      numbers: numbers,
      letters: letters,
      color: color,
      name: name,
      year: year,
    ).then((value) {
      if (value.status == Status.success) {
        print('Added New Vehicle In Provider Successfully');
      }
    });
  }


  MyVehiclesData? myVehiclesData;
  Future getMyVehicles() async {
    MyVehiclesService myVehiclesService = MyVehiclesService();
    await myVehiclesService.getMyVehicles().then((value) {
      if (value.status == Status.success) {
        myVehiclesData = value.data;
      }
    });
    notifyListeners();
  }
}
