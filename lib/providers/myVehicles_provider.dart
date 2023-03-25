

import 'package:flutter/material.dart';

import '../models/myVehiclesModel.dart';
import '../services/myVehicles_service.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesProvider with ChangeNotifier{

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