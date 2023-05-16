import 'dart:developer';

import 'package:flash_customer/models/servicesModel.dart';
import 'package:flash_customer/models/taxModel.dart';

import '../base/service/base_service.dart';
import '../models/bookServicesModel.dart';
import '../models/cityIdModel.dart';
import '../models/offerCouponModel.dart';
import '../models/requestDetailsModel.dart';
import '../models/requestResult.dart';
import '../models/request_details_model.dart';
import '../models/slotsModel.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class RequestServicesService extends BaseService {
  Future<ResponseResult> getBasicServices({
    required int cityId,
    required int vehicleId,
  }) async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    List<ServiceData> basicServicesDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getBasicServices}&vehicle_id=$vehicleId&city_id=$cityId',
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

  Future<ResponseResult> getExtraServices(
      {required int cityId, required int vehicleId}) async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    List<ServiceData> extraServicesDataList = [];
    try {
      await requestFutureData(
          api: '${Api.getExtraServices}&vehicle_id=$vehicleId&city_id=$cityId',
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

  Future<ResponseResult> getCityId({
    required double lat,
    required double lng,
  }) async {
    Status status = Status.error;
    Map<String, String> header = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"lat": lat, "lng": lng};
    CityIdData? cityIdData;
    try {
      await requestFutureData(
          api: Api.getCityId,
          body: body,
          headers: header,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              cityIdData = CityIdModel.fromJson(response).data!;
            } else if (response["status_code"] == 422) {
              status = Status.codeNotCorrect;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in get city Id $e");
    }
    return ResponseResult(status, cityIdData);
  }

  Future<ResponseResult> bookServices({
    required int cityId,
    required int addressId,
    required int vehicleId,
    required int basicServiceId,
    required List<ExtraServicesItem> selectedExtraServices,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> header = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "city_id": cityId,
      "address_id": addressId,
      "vehicle_id": vehicleId,
      "basic_service_id": basicServiceId,
      "extra_services_ids":
          selectedExtraServices.map((element) => element.toJson()).toList(),
    };
    BookServicesData? bookServicesData;
    try {
      await requestFutureData(
          api: Api.bookServices,
          body: body,
          headers: header,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              bookServicesData = BookServicesModel.fromJson(response).data!;
            } else if (response["status_code"] == 422 ||
                response["status_code"] == 400) {
              status = Status.codeNotCorrect;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in book Services $e");
    }
    return ResponseResult(status, bookServicesData, message: message);
  }

  Future<ResponseResult> assignEmployee({
    required List slotsIds,
    required String slotsDate,
    required int id,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> header = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "slots_ids": slotsIds,
      "slots_date": slotsDate,
      "id": id,
    };
    EmployeeDetailsData? employeeDetailsData;
    try {
      await requestFutureData(
          api: Api.assignEmployee,
          body: body,
          headers: header,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              employeeDetailsData =
                  EmployeeDetailsModel.fromJson(response).data!;
            } else if (response["status_code"] == 422 ||
                response["status_code"] == 400) {
              status = Status.codeNotCorrect;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in assign employee $e");
    }
    return ResponseResult(status, employeeDetailsData, message: message);
  }

  Future<ResponseResult> getRequestDetails({required int requestId}) async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    DetailsRequestData? detailsRequestData;
    try {
      await requestFutureData(
          api: '${Api.getRequestDetails}$requestId',
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              detailsRequestData = DetailsRequestModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Request Details Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Request Details Data$e");
    }
    return ResponseResult(result, detailsRequestData);
  }

  Future<ResponseResult> updateRequestSlots({
    required int requestId,
    required String payBy,
  }) async {
    Status result = Status.error;
    dynamic message;
    Map<String, String> headers = const {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"id": requestId, "pay_by": payBy};

    RequestDetailsData? updatedRequestDetailsData;
    try {
      await requestFutureData(
          api: Api.updateInitialRequest,
          requestType: Request.patch,
          jsonBody: true,
          withToken: true,
          body: body,
          headers: headers,
          onSuccess: (response) async {
            try {
              if (response["status_code"] == 200) {
                result = Status.success;
                updatedRequestDetailsData =
                    RequestDetailsModel.fromJson(response).data!;
              } else if (response["status_code"] == 422 ||
                  response["status_code"] == 400) {
                result = Status.codeNotCorrect;
                message = response["message"];
              }
            } catch (e) {
              logger.e("Error getting response update Request Slots Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting update Request Slots Data$e");
    }
    return ResponseResult(result, updatedRequestDetailsData, message: message);
  }

  Future<ResponseResult> getTimeSlots({
    required int cityId,
    required int basicId,
    required double duration,
    String? service,
    required String date,
  }) async {
    Status result = Status.error;
    Map<String, String> headers = const {'Content-Type': 'application/json'};

    List<List<SlotData>>? slots = [];
    try {
      await requestFutureData(
          api: Api.getTimeSlots(
              cityId: cityId,
              basicId: basicId,
              date: date,
              duration: duration,
              service: service ?? ''),
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              slots = SlotsModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Get Time Slot\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Request Details Data$e");
    }
    return ResponseResult(result, slots);
  }

  Future<ResponseResult> submitFinialRequest({
    required int requestId,
    required String payBy,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> header = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"id": requestId, "pay_by": payBy};
    try {
      await requestFutureData(
          api: Api.submitFinialRequest,
          body: body,
          headers: header,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              message = response["message"];
            } else if (response["status_code"] == 422 ||
                response["status_code"] == 400) {
              status = Status.codeNotCorrect;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in submit Finial Request $e");
    }
    return ResponseResult(status, '', message: message);
  }
}
