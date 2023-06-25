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
  String? status;

  List<MyRequestsData> myRequestsDataList=[];
  List<MyRequestsData> pendingRequestsDataList=[];
  List<MyRequestsData> onTheWayRequestsDataList=[];
  List<MyRequestsData> arrivedRequestsDataList=[];
  List<MyRequestsData> completedRequestsDataList=[];
  List<MyRequestsData> canceledRequestsDataList=[];


  Future getMyRequests() async {
    await myRequestsService.getMyRequests().then((value) {
      if (value.status == Status.success) {
        pendingRequestsDataList=[];
        onTheWayRequestsDataList=[];
        arrivedRequestsDataList=[];
        completedRequestsDataList=[];
        canceledRequestsDataList=[];
        myRequestsDataList = value.data;
        loadingMyRequests = false;
        for (var element in myRequestsDataList) {
          switch(element.status) {
            case 'Pending': {
              pendingRequestsDataList.add(element);
            }
            break;

            case 'On The Way': {
              onTheWayRequestsDataList.add(element);
            }
            break;
            case 'Arrived': {
              arrivedRequestsDataList.add(element);
            }
            break;
            case 'Complete': {
              completedRequestsDataList.add(element);
            }
            break;
            default: {
              canceledRequestsDataList.add(element);
            }
            break;
          }
        }
      }
    });
    notifyListeners();
  }

  void changeStatusFilter(List<MyRequestsData> list){
    myRequestsDataList = list;
    notifyListeners();
  }

  void setLoading(bool value){
    loadingMyRequests = value;
    notifyListeners();
  }

}
