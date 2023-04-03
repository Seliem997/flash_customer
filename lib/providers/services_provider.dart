

import 'package:flutter/material.dart';

import '../models/servicesModel.dart';
import '../services/services_service.dart';
import '../utils/enum/statuses.dart';

class ServicesProvider with ChangeNotifier{

  bool onCheck = false;

  List<BasicServicesData> basicServicesList = [];
  Future getBasicServices() async {
    ServicesService servicesService = ServicesService();
    await servicesService.getBasicServices().then((value) {
      if (value.status == Status.success) {
        basicServicesList = value.data;
      }
    });
    notifyListeners();
  }

  void checkBasicService(){
    onCheck = !onCheck;
    notifyListeners();
  }

  List<BasicServicesData> extraServicesList = [];
  Future getExtraServices() async {
    ServicesService servicesService = ServicesService();
    await servicesService.getExtraServices().then((value) {
      if (value.status == Status.success) {
        extraServicesList = value.data;
      }
    });
    notifyListeners();
  }


}