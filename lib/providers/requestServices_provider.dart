

import 'package:flash_customer/models/taxModel.dart';
import 'package:flutter/material.dart';

import '../models/offerCouponModel.dart';
import '../models/servicesModel.dart';
import '../services/requestServices_service.dart';
import '../utils/enum/statuses.dart';

class RequestServicesProvider with ChangeNotifier{
  TextEditingController discountCodeController = TextEditingController(text: '');
  int discountAmount = 0;
  int selectedBasicServiceAmount = 0;
  int selectedBasicServiceDuration = 0;
  int? selectedBasicIndex;

  void selectedBasicService({required int index}){
    selectedBasicIndex = index;

    notifyListeners();
  }


  List<BasicServicesData> basicServicesList = [];
  Future getBasicServices() async {
    RequestServicesService servicesService = RequestServicesService();
    await servicesService.getBasicServices().then((value) {
      if (value.status == Status.success) {
        basicServicesList = value.data;
      }
    });
    notifyListeners();
  }


  List<ExtraServiceData> extraServicesList = [];
  Future getExtraServices() async {
    RequestServicesService servicesService = RequestServicesService();
    await servicesService.getExtraServices().then((value) {
      if (value.status == Status.success) {
        extraServicesList = value.data;
      }
    });
    notifyListeners();
  }


  TaxData? taxData;
  Future getTax() async {
    RequestServicesService servicesService = RequestServicesService();
    await servicesService.getTax().then((value) {
      if (value.status == Status.success) {
        taxData = value.data;
      }
    });
    notifyListeners();
  }

  CouponData? couponData;
  Future checkOfferCoupon({required String discountCode,}) async {
    RequestServicesService servicesService = RequestServicesService();
    await servicesService.checkCoupon(discountCode: discountCode).then((value) {
      if (value.status == Status.success) {
        couponData = value.data;
      }
    });
    notifyListeners();
  }

}