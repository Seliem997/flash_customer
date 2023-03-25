

import 'package:flutter/material.dart';

import '../models/otherServicesModel.dart';
import '../services/otherServices_service.dart';
import '../utils/enum/statuses.dart';

class OtherServicesProvider with ChangeNotifier{

  List<OtherServicesData> otherServicesList = [];
  Future getOtherServices() async {
    OtherServicesService otherServicesService = OtherServicesService();
    await otherServicesService.getOtherServices().then((value) {
      if (value.status == Status.success) {
        otherServicesList = value.data;
      }
    });
    notifyListeners();
  }

}