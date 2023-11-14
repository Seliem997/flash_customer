import 'dart:convert';
import 'dart:developer';

import 'package:flash_customer/models/servicesModel.dart';
import 'package:intl/intl.dart';

import '../base/service/base_service.dart';
import '../models/bankAccountsModel.dart';
import '../models/bookServicesModel.dart';
import '../models/cityIdModel.dart';
import '../models/offerCouponModel.dart';
import '../models/rateDetailsModel.dart';
import '../models/requestDetailsModel.dart';
import '../models/requestResult.dart';
import '../models/request_details_model.dart';
import '../models/slotsModel.dart';
import '../utils/apis.dart';
import '../utils/cache_helper.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/shared_preference_keys.dart';
import '../utils/enum/statuses.dart';
import 'package:http/http.dart' as http;

class RequestServicesService extends BaseService {
  Future<ResponseResult> getBasicServices({
    required int cityId,
    required int vehicleId,
  }) async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };

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
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };

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

  Future<ResponseResult> checkCoupon({
    required String discountCode,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {"offer_code": discountCode};
    CouponData? couponData;
    try {
      await requestFutureData(
          api: Api.checkOfferCoupon,
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              message = response["message"];

              couponData = OfferCouponModel.fromJson(response).data!;
            } else if (response["status_code"] == 422) {
              status = Status.codeNotCorrect;
              message = response["message"];
            }else{
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in Check Coupon $e");
    }
    return ResponseResult(status, couponData, message: message);
  }

  Future<ResponseResult> getCityId({
    required double lat,
    required double lng,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {"lat": lat, "lng": lng};
    CityIdData? cityIdData;
    try {
      await requestFutureData(
          api: Api.getCityId,
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              message = response["message"];
              cityIdData = CityIdModel.fromJson(response).data!;
            } else if (response["status_code"] == 422|| response["status_code"] == 401) {
              status = Status.codeNotCorrect;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in get city Id $e");
    }
    return ResponseResult(status, cityIdData, message: message);
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
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
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
          headers: headers,
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
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
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
          headers: headers,
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
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };

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
    String? offerCode,
    dynamic employeeId,
  }) async {
    Status result = Status.error;
    dynamic message;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {"id": requestId, "pay_by": payBy,
      offerCode != null ? "offer_code" : '' : offerCode ?? '', "employee_id": employeeId};

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
    required int addressId,
  }) async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };

    List<List<SlotData>>? slots = [];
    try {
      await requestFutureData(
          api: Api.getTimeSlots(
              cityId: cityId,
              basicId: basicId,
              date: date,
              duration: duration,
              service: service ?? '',
            addressId: addressId,
          ),
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
    num? walletAmount,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {"id": requestId, "pay_by": payBy, "wallet_amount": walletAmount};
    PaymentUrlData? paymentUrlData;
    try {
      await requestFutureData(
          api: Api.submitFinialRequest,
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              paymentUrlData = PaymentUrlModel.fromJson(response).data!;
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
    return ResponseResult(status, paymentUrlData, message: message);
  }


  Future<ResponseResult> creditRequestPayment({
    required String chargeId,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {"charge_id": chargeId,};
    try {
      await requestFutureData(
          api: Api.walletCharge,
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              message = response["message"];
            } else if (response["status_code"] == 422 ||
                response["status_code"] == 400) {
              status = Status.error;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in credit Request Payment  $e");
    }
    return ResponseResult(status, '', message: message);
  }

  Future<ResponseResult> rateRequest({
    required int requestId,
    required int rate,
    required String feedBack,
  }) async {
    Status status = Status.error;
    dynamic message;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };
    Map<String, dynamic> body = {"rate": rate, "feedback": feedBack};
    RatingData? ratingData;
    try {
      await requestFutureData(
          api: Api.rateRequest(requestId: requestId),
          body: body,
          headers: headers,
          jsonBody: true,
          withToken: true,
          requestType: Request.post,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              ratingData = RateDetailsModel.fromJson(response).data!;
              message = response["message"];
            } else if (response["status_code"] == 422 ||
                response["status_code"] == 400) {
              status = Status.codeNotCorrect;
              message = response["message"];
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in submit Rating Request $e");
    }
    return ResponseResult(status, ratingData, message: message);
  }

  Future<ResponseResult> getBankAccounts() async {
    Status result = Status.error;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'lang': Intl.getCurrentLocale() == 'ar' ? 'ar' : 'en',
    };

    List<BankAccountsData> bankAccountsList = [];
    try {
      await requestFutureData(
          api: Api.bankAccounts,
          requestType: Request.get,
          jsonBody: true,
          withToken: true,
          headers: headers,
          onSuccess: (response) async {
            try {
              result = Status.success;
              bankAccountsList = BankAccountsModel.fromJson(response).data!;
            } catch (e) {
              logger.e("Error getting response Bank Accounts Data\n$e");
            }
          });
    } catch (e) {
      result = Status.error;
      log("Error in getting Bank Accounts Details Data$e");
    }
    return ResponseResult(result, bankAccountsList);
  }

  Future<ResponseResult> uploadPaymentFile(
    String imagePath, {
    required int bankAccountId,
    required int requestId,
  }) async {
    Status status = Status.error;

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer ${CacheHelper.returnData(key: CacheKey.token)}"
    };

    try {
      var request =
          http.MultipartRequest("POST", Uri.parse(Api.submitFinialRequest));

      request.headers.addAll(headers);

      request.fields['id'] = '$requestId';
      request.fields['pay_by'] = 'bank_transfer';
      // request.fields['_method'] = "PUT";
      request.fields['bank_account_id'] = '$bankAccountId';

      request.files.add(await http.MultipartFile.fromPath("image", imagePath));

      logger.i(
          "Request Called: ${Api.submitFinialRequest}\nHeaders: ${request.headers}\nBody:${request.fields}\nFiles:${request.files}");

      await request.send().then((stream) async {
        await http.Response.fromStream(stream).then((value) {
          final response = jsonDecode(value.body);
          BankTransferModel model = BankTransferModel.fromJson(response);
          logger.i("Response: $response");
          if (model.statusCode == 200) {
            log("Successss");
            status = Status.success;
          } else if (model.statusCode == 400) {
            status = Status.error;
            log("Failureee");
          }
        });
      }).timeout(const Duration(seconds: 30));
    } catch (e) {
      logger.e("Error in Uploading payment file $e");
      status = Status.error;
    }
    log("Status ${status.key}");
    return ResponseResult(status, "");
  }

}
