import 'dart:developer';

import 'package:flash_customer/models/taxModel.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/bankAccountsModel.dart';
import '../models/bookServicesModel.dart';
import '../models/cityIdModel.dart';
import '../models/offerCouponModel.dart';
import '../models/rateDetailsModel.dart';
import '../models/requestDetailsModel.dart';
import '../models/requestResult.dart';
import '../models/request_details_model.dart';
import '../models/servicesModel.dart';
import '../models/slotsModel.dart';
import '../services/requestServices_service.dart';
import '../utils/enum/statuses.dart';
import '../utils/snack_bars.dart';

class RequestServicesProvider with ChangeNotifier {
  RequestServicesService servicesService = RequestServicesService();

  TextEditingController discountCodeController =
      TextEditingController(text: '');
  TextEditingController ratingFeedbackController =
      TextEditingController(text: '');
  int ratingValue = 0;
  double totalAmount = 0;
  double totalDuration = 0;
  num? totalAmountAfterDiscount = 0;
  num discountAmount = 0;
  dynamic totalTaxes = 0;
  int selectedBasicServiceAmount = 0;
  int selectedBasicServiceDuration = 0;
  int selectedBasicServiceId = 0;
  int? selectedBasicIndex;
  int? selectedSlotIndex;
  bool isLoading = true;
  List<ExtraServicesItem> selectedExtraServices = [];
  bool selectedCreditCardPayment = false;
  bool selectedCashPayment = false;
  String? selectedDate;
  List slotsIds = [];

  var date = DateTime.now();

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void calculateTotal() {
    print('Start calc');
    totalAmount = 0;
    totalDuration = 0;
    totalTaxes = 0;
    if (selectedBasicIndex != null) {
      totalAmount +=
          (double.parse(basicServicesList[selectedBasicIndex!].selectedPrice!));
      totalDuration += basicServicesList[selectedBasicIndex!].duration!;
      totalTaxes = (((basicServicesList[selectedBasicIndex!].tax!) *
              (double.parse(
                  basicServicesList[selectedBasicIndex!].selectedPrice!))) /
          100);
    }

    for (int i = 0; i < extraServicesList.length; i++) {
      if (extraServicesList[i].quantity > 0 ||
          extraServicesList[i].isSelected) {
        if (extraServicesList[i].countable!) {
          totalAmount += (extraServicesList[i].quantity *
              double.parse(extraServicesList[i].selectedPrice!).toInt());
          totalDuration +=
              (extraServicesList[i].quantity * extraServicesList[i].duration!);
          totalTaxes +=
              (extraServicesList[i].quantity * extraServicesList[i].tax!);
        } else if (extraServicesList[i].isSelected) {
          totalAmount +=
              double.parse(extraServicesList[i].selectedPrice!).toInt();
          totalTaxes += extraServicesList[i].tax!;
          totalDuration += extraServicesList[i].duration!;
        }
      }
    }
    notifyListeners();
  }

  void selectCreditCardPayment(bool value) {
    selectedCreditCardPayment = value;
    notifyListeners();
  }

  void selectCashPayment(bool value) {
    selectedCashPayment = value;
    notifyListeners();
  }

  void selectedBasicService({required int index}) {
    selectedBasicIndex = index;
    notifyListeners();
  }

  void selectedTimeSlot({required int index}) {
    selectedSlotIndex = index;
    notifyListeners();
  }

  List<ServiceData> basicServicesList = [];
  Future getBasicServices({
    required int cityId,
    required int vehicleId,
  }) async {
    await servicesService
        .getBasicServices(cityId: cityId, vehicleId: vehicleId)
        .then((value) {
      if (value.status == Status.success) {
        basicServicesList = value.data;
      }
    });
    print('basic ${basicServicesList[0].tax}');
    notifyListeners();
  }

  List<ServiceData> extraServicesList = [];
  Future getExtraServices({required int cityId, required int vehicleId}) async {
    await servicesService
        .getExtraServices(
      cityId: cityId,
      vehicleId: vehicleId,
    )
        .then((value) {
      if (value.status == Status.success) {
        extraServicesList = value.data;
      }
    });
    notifyListeners();
  }

  /*TaxData? taxData;
  Future getTax() async {
      await servicesService.getTax().then((value) {
      if (value.status == Status.success) {
        taxData = value.data;
      }
    });
    notifyListeners();
  }*/

  CouponData? couponData;
  Future checkOfferCoupon(BuildContext context) async {
    if (discountCodeController.text.isNotEmpty) {
      AppLoader.showLoader(context);
      await servicesService
          .checkCoupon(discountCode: discountCodeController.text)
          .then((value) {
        AppLoader.stopLoader();
        if (value.status == Status.success) {
          couponData = value.data;
          if (couponData!.isActive == 1) {
            CustomSnackBars.successSnackBar(
                context, S.of(context).offerAppliedSuccessfully);
            discountAmount = couponData!.discountAmount!;
            totalAmountAfterDiscount =
                updatedRequestDetailsData!.totalAmount! - discountAmount;
          } else {
            CustomSnackBars.successSnackBar(
                context, S.of(context).codeNotAccepted);
          }
        } else {
          CustomSnackBars.failureSnackBar(context, S.of(context).codeIsInvalid);
        }
      });
    } else {
      CustomSnackBars.failureSnackBar(context, S.of(context).enterCodeFirst);
    }

    notifyListeners();
  }

  CityIdData? cityIdData;
  Future getCityId({required double lat, required double long}) async {
    await servicesService.getCityId(lat: lat, lng: long).then((value) {
      if (value.status == Status.success) {
        cityIdData = value.data;
      }
    });
    notifyListeners();
  }

  BookServicesData? bookServicesData;
  Future<ResponseResult> bookServices(
    BuildContext context, {
    required int cityId,
    required int addressId,
    required int vehicleId,
    required int basicServiceId,
  }) async {
    Status state = Status.error;
    dynamic message;
    extraServicesList.forEach((element) {
      if (element.quantity > 0 || element.isSelected) {
        selectedExtraServices
            .add(ExtraServicesItem(element.id!, element.quantity));
      }
    });
    await servicesService
        .bookServices(
            cityId: cityId,
            vehicleId: vehicleId,
            basicServiceId: basicServiceId,
            selectedExtraServices: selectedExtraServices,
            addressId: addressId)
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        bookServicesData = value.data;
      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, bookServicesData, message: message);
  }

  DetailsRequestData? detailsRequestData;
  Future getRequestDetails({required int requestId}) async {
    setLoading(true);
    await servicesService.getRequestDetails(requestId: requestId).then((value) {
      if (value.status == Status.success) {
        detailsRequestData = value.data;
      }
    });
    notifyListeners();
  }

  // List<List<SlotData>> slotsList = [];
  Map<String, dynamic>? slotsMap;
  Future getTimeSlots({
    required int cityId,
    required int basicId,
    required double duration,
    required String date,
  }) async {
    isLoading = true;
    notifyListeners();
    String services = "";
    for (int i = 0; i < selectedExtraServices.length; i++) {
      services +=
          "&services[${i + 1}]= ${selectedExtraServices[i].extraServiceId}";
    }
    await servicesService
        .getTimeSlots(
      cityId: cityId,
      basicId: basicId,
      duration: duration,
      date: date,
      service: services,
    )
        .then((value) {
      isLoading = false;
      if (value.status == Status.success) {
        /*slotsList = value.data;
        print('Time Slot in provider Success');
        print(slotsList);*/
        slotsMap = value.data;
        /*for(var v in slotsMap!.values) {
          print(v);
          //below is the solution
          v.asMap().forEach((i, value) {
            print('index=$i, value=${value}');
          });
              }*/
      }
    });
    notifyListeners();
  }

  RequestDetailsData? updatedRequestDetailsData;
  Future updateRequestSlots({
    required int requestId,
    required String payBy,
  }) async {
    Status state = Status.error;
    dynamic message;
    await servicesService
        .updateRequestSlots(
      requestId: requestId,
      payBy: payBy,
    )
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        updatedRequestDetailsData = value.data;
        totalAmountAfterDiscount = updatedRequestDetailsData!.totalAmount!;
      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, updatedRequestDetailsData, message: message);
  }

  PaymentUrlData? paymentUrlData;
  Future<ResponseResult> submitFinialRequest({
    required int requestId,
    required String payBy,
  }) async {
    Status state = Status.error;
    dynamic message;
    await servicesService
        .submitFinialRequest(requestId: requestId, payBy: payBy)
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        paymentUrlData = value.data;
        message = value.message;
      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, paymentUrlData, message: message);
  }

  RatingData? ratingData;
  Future<ResponseResult> rateRequest({
    required int requestId,
    required int rate,
    required String feedBack,
  }) async {
    Status state = Status.error;
    dynamic message;
    await servicesService
        .rateRequest(requestId: requestId, rate: rate, feedBack: feedBack)
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        ratingData = value.data;
        message = value.message;
      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, ratingData, message: message);
  }

  EmployeeDetailsData? employeeDetailsData;
  Future<ResponseResult> assignEmployee({
    required List slotsIds,
    required String slotsDate,
    required int id,
  }) async {
    Status state = Status.error;
    dynamic message;

    await servicesService
        .assignEmployee(slotsIds: slotsIds, slotsDate: slotsDate, id: id)
        .then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        message = value.message;
        employeeDetailsData = value.data;
      } else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, employeeDetailsData, message: message);
  }

  List<BankAccountsData> bankAccountsList = [];
  Future getBankAccounts() async {
    setLoading(true);
    await servicesService.getBankAccounts().then((value) {
      if (value.status == Status.success) {
        bankAccountsList = value.data;
      }
    });
    notifyListeners();
  }

  void resetCoupon() {
    couponData = null;
    discountCodeController = TextEditingController();
    totalAmountAfterDiscount = updatedRequestDetailsData?.totalAmount;
    notifyListeners();
  }

  void clearServices() {
    isLoading = true;
    basicServicesList = [];
    extraServicesList = [];
    selectedExtraServices = [];
    slotsIds = [];
    totalAmount = 0;
    totalDuration = 0;
    totalAmountAfterDiscount = 0;
    discountAmount = 0;
    totalTaxes = 0;
    resetCoupon();
    selectedBasicIndex = null;
    selectedSlotIndex = null;
    notifyListeners();
  }
}
