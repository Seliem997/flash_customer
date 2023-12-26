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

  String? filterDateText;
  String? filterDateStatus;

  DateTime? _selectedDateFrom;
  DateTime? _selectedDateTo;

  DateTime? get selectedDateTo => _selectedDateTo;

  set selectedDateTo(DateTime? value) {
    _selectedDateTo = value;
    if(_selectedDateTo != null){
      filterDateText = '${DateFormat(DFormat.ymd.key,('en-IN')).format(_selectedDateFrom!).toString()}:${DateFormat(DFormat.ymd.key,('en-IN')).format(_selectedDateTo!).toString()}';
    }
    getMyRequests();
  }

  DateTime? get selectedDateFrom => _selectedDateFrom;

  set selectedDateFrom(DateTime? value) {
    _selectedDateFrom = value;
    notifyListeners();
  }


  Future getMyRequests({String? status,}) async {
    setLoading(true);
    await myRequestsService.getMyRequests(dateFrom: _selectedDateFrom != null
        ? DateFormat(DFormat.ymd.key,('en-IN')).format(_selectedDateFrom!)
        : null,dateTo: _selectedDateTo != null
        ? DateFormat(DFormat.ymd.key,('en-IN')).format(_selectedDateTo!)
        : null, status: status).then((value) {
      if (value.status == Status.success) {

        myRequestsDataList = value.data;
        loadingMyRequests = false;

      }
    });
    notifyListeners();
  }

  Future updateRequestStatus({
    required int requestId,
    required String status,

  }) async {
    Status state = Status.error;
    dynamic message;
    await myRequestsService
        .updateRequestStatus(requestId: requestId, status: status).then((value) {
          setLoading(true);
      if (value.status == Status.success) {
        state = Status.success;
        getMyRequests();
      } else {
        setLoading(false);
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, '', message: message);
  }

  void setLoading(bool value){
    loadingMyRequests = value;
    notifyListeners();
  }

}
