import 'package:flutter/material.dart';

import '../models/myRequestsModel.dart';
import '../models/myVehiclesModel.dart';
import '../models/requestResult.dart';
import '../models/vehicleDetailsModel.dart';
import '../services/myRequests_service.dart';
import '../services/myVehicles_service.dart';
import '../utils/enum/statuses.dart';

class MyRequestsProvider with ChangeNotifier {

  MyRequestsService myRequestsService = MyRequestsService();

  bool loadingMyRequests = true;

  List<MyRequestsData> myRequestsDataList=[];
  Future getMyRequests() async {
    loadingMyRequests = true;
    await myRequestsService.getMyRequests().then((value) {
      if (value.status == Status.success) {
        myRequestsDataList = value.data;
        loadingMyRequests = false;
      }
    });
    notifyListeners();
  }
}
