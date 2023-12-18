import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import '../models/myVehiclesModel.dart';
import '../models/requestResult.dart';
import '../models/vehicleDetailsModel.dart';
import '../services/myVehicles_service.dart';
import '../utils/enum/statuses.dart';

class MyVehiclesProvider with ChangeNotifier {
  MyVehiclesService myVehiclesService = MyVehiclesService();

  TextEditingController? nameController;
  TextEditingController yearController = TextEditingController();
  TextEditingController numbersController = TextEditingController();
  TextEditingController lettersController = TextEditingController();
  String? vehicleColor;
  Color screenPickerColor = Colors.white;
  final Map<String, String> vehiclePlate = {
    'J': 'ح',
    'j': 'ح',
    'x': 'ص',
    'X': 'ص',
    'e': 'ع',
    'E': 'ع',
    'D': 'د',
    'd': 'د',
    'R': 'ر',
    'r': 'ر',
    'k': 'ك',
    'K': 'ك',
    'L': 'ل',
    'l': 'ل',
    'U': 'و',
    'u': 'و',
    'G': 'ق',
    'g': 'ق',
    'H': 'ه',
    'h': 'ه',
    'A': 'أ',
    'a': 'أ',
    'V': 'ى',
    'v': 'ى',
    'S': 'س',
    's': 'س',
    'B': 'ب',
    'b': 'ب',
    'T': 'ط',
    't': 'ط',
    'z': 'م',
    'Z': 'م',
  };

  String plateCharacters = '';
  String? plateTranslate(String plateLetters) {
    plateCharacters = '';
    List letters = plateLetters.split('');

    letters.reversed.forEach((elementLetter) {
      vehiclePlate.keys.forEach((element) {
        if (element == elementLetter) {
          plateCharacters = '$plateCharacters ${vehiclePlate[element]!}';
        }
      });
    });
    notifyListeners();
    return plateCharacters;
  }

  final Map<ColorSwatch<Object>, String> customSwatches =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(const Color(0xFFBC350F)): 'Rust',
    ColorTools.createPrimarySwatch(const Color(0xFFFFFFFF)): 'White',
    ColorTools.createPrimarySwatch(const Color(0xFF000000)): 'Black',
    ColorTools.createAccentSwatch(const Color(0xFF412D2E)): 'brown',
    ColorTools.createAccentSwatch(const Color(0xFF014D33)): 'dark green',
    ColorTools.createAccentSwatch(Colors.grey): 'Grey',
    ColorTools.createAccentSwatch(Colors.blue): 'Blue',
  };

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
      }
    });
    return ResponseResult(state, vehicleDetailsData);
  }

  Future<ResponseResult> updateVehicle({
    required int vehicleId,
    required int vehicleTypeId,
    int? subVehicleTypeId,
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
            name: name)
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        vehicleDetailsData = value.data;
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

  Future<ResponseResult> deleteVehicle({required int vehicleID}) async {
    loadingMyVehicles = true;
    notifyListeners();
    Status state = Status.error;
    dynamic message;

    await myVehiclesService.deleteVehicle(vehicleID: vehicleID).then((value) {
      if (value.status == Status.success) {
        loadingMyVehicles = false;
        state = Status.success;
        message = value.message;
      } else {
        message = value.message;
      }
    });
    getMyVehicles();
    notifyListeners();
    return ResponseResult(state, '', message: message);
  }

  void resetFields() {
    nameController = TextEditingController(text: '');
    yearController = TextEditingController(text: '');
    numbersController = TextEditingController(text: '');
    lettersController = TextEditingController(text: '');
    vehicleColor = null;
    // vehicleColor= '4294967295';
    screenPickerColor = Colors.white;
    notifyListeners();
  }
}
