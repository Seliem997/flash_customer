import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/myRequestsModel.dart';
import '../models/myVehiclesModel.dart';
import '../models/requestResult.dart';
import '../models/vehicleDetailsModel.dart';
import '../services/myRequests_service.dart';
import '../services/myVehicles_service.dart';
import '../utils/enum/date_formats.dart';
import '../utils/enum/statuses.dart';

class MyRequestsProvider with ChangeNotifier {

  MyRequestsService myRequestsService = MyRequestsService();

  bool loadingMyRequests = true;

  List<MyRequestsData> myRequestsDataList=[];

  DateTime? _selectedDate;

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    getMyRequests();
  }


  Future getMyRequests({String? status,}) async {
    setLoading(true);
    await myRequestsService.getMyRequests(date: _selectedDate != null
        ? DateFormat(DFormat.ymd.key).format(_selectedDate!)
        : null, status: status).then((value) {
      if (value.status == Status.success) {

        myRequestsDataList = value.data;
        loadingMyRequests = false;

      }
    });
    notifyListeners();
  }


  void setLoading(bool value){
    loadingMyRequests = value;
    notifyListeners();
  }

}
