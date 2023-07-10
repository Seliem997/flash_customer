import 'package:flutter/material.dart';

import '../models/myVehiclesModel.dart';
import '../models/requestResult.dart';
import '../models/vehicleDetailsModel.dart';
import '../services/myVehicles_service.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesProvider with ChangeNotifier {

  MyVehiclesService myVehiclesService = MyVehiclesService();

  TextEditingController? nameController ;
  TextEditingController yearController = TextEditingController();
  TextEditingController numbersController = TextEditingController();
  TextEditingController lettersController = TextEditingController();
  String? vehicleColor;
  // String vehicleColor= '4294967295';
  Color screenPickerColor= Colors.white;

  bool loadingMyVehicles = true;
  MyVehiclesData? myVehiclesData;
  int? selectedMyVehicleIndex;

  void setSelectedMyVehicle({required int index}) {
    selectedMyVehicleIndex = index;
    notifyListeners();
  }

  VehicleDetailsData? vehicleDetailsData;
  Future<ResponseResult> addNewVehicle({
    required int vehicleTypeId,
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



  Future<ResponseResult> updateVehicle({
    required int vehicleId,
    required int vehicleTypeId,
    required int subVehicleTypeId,
    required int manufacture,
    required int model,
    required int customerId,
    String? numbers,
    String? letters,
    String? color,
    String? name,
    String? year,
  }) async {
    Status state = Status.error;
    await myVehiclesService
        .updateVehicle(
      vehicleId: vehicleId,
      vehicleTypeId: vehicleTypeId,
      subVehicleTypeId: subVehicleTypeId,
      manufacture: manufacture,
      model: model,
      customerId: customerId,
      year: year,
      letters: letters,
      numbers: numbers,
      color: color,
      name: name
    )
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        vehicleDetailsData = value.data;
        print('Update Vehicle In Provider Successfully');
      }
    });
    return ResponseResult(state, vehicleDetailsData);
  }

  Future getMyVehicles() async {
    myVehiclesData = null;
    selectedMyVehicleIndex = null;
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

  Future deleteVehicle({required int vehicleID}) async {
    loadingMyVehicles = true;
    notifyListeners();
    Status state = Status.error;
    dynamic message;

    await myVehiclesService.deleteVehicle(vehicleID: vehicleID).then((value) {
      if (value.status == Status.success) {
        loadingMyVehicles = false;
        state = Status.success;
        message = value.message;
      }else{
        message = value.message;
      }
    });
    getMyVehicles();
    notifyListeners();
    return ResponseResult(state, '',message: message);
  }

  void resetFields(){
    nameController = TextEditingController(text: '');
    yearController = TextEditingController(text: '');
    numbersController = TextEditingController(text: '');
    lettersController = TextEditingController(text: '');
    vehicleColor= null;
    // vehicleColor= '4294967295';
    screenPickerColor= Colors.white;
    notifyListeners();
  }
}
