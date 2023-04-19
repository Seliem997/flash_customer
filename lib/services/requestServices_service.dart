import 'dart:developer';

import 'package:flash_customer/models/servicesModel2.dart';
import 'package:flash_customer/models/taxModel.dart';

import '../base/service/base_service.dart';
import '../models/offerCouponModel.dart';
import '../models/requestResult.dart';
import '../models/servicesModel.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class RequestServicesService extends BaseService {
  Future<ResponseResult> getBasicServices() async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    List<ServiceData> basicServicesDataList = [];
    try {
      await requestFutureData(
          api: Api.getBasicServices,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              basicServicesDataList = ServicesModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Services Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Services Data$e");
    }
    return ResponseResult(result, basicServicesDataList);
  }

  Future<ResponseResult> getExtraServices() async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    List<ServiceData> extraServicesDataList = [];
    try {
      await requestFutureData(
          api: Api.getExtraServices,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              extraServicesDataList = ServicesModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Services Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Services Data$e");
    }
    return ResponseResult(result, extraServicesDataList);
  }

  Future<ResponseResult> getTax() async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    TaxData? taxData;
    try {
      await requestFutureData(
          api: Api.getActiveTax,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              taxData = TaxModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Tax Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Tax Data$e");
    }
    return ResponseResult(result, taxData);
  }

  Future<ResponseResult> checkCoupon({
    required String discountCode,
  }) async {
    Status status = Status.error;
    Map<String, String> header = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"offer_code": discountCode};
    CouponData? couponData;
    try {
      await requestFutureData(
          api: Api.checkOfferCoupon,
          body: body,
          headers: header,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              couponData = OfferCouponModel.fromJson(response).data!;
            } else if (response["status_code"] == 422) {
              status = Status.codeNotCorrect;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in Check Coupon $e");
    }
    return ResponseResult(status, couponData);
  }
}
