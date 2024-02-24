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
  dynamic totalTaxes = 0;
  int selectedBasicServiceAmount = 0;
  int selectedBasicServiceDuration = 0;
  int selectedBasicServiceId = 0;
  dynamic  selectedBasicIndex;
  dynamic  selectedSlotIndex;
  bool isLoading = true;
  List<ExtraServicesItem> selectedExtraServices = [];
  bool selectedCashPayment = false;
  bool selectedCreditCardPayment = false;
  bool selectedWalletPayment = false;
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
      totalDuration += (double.parse(basicServicesList[selectedBasicIndex!].duration!));
      totalTaxes = (basicServicesList[selectedBasicIndex!].tax!);
    }

    for (int i = 0; i < extraServicesList.length; i++) {
      if (extraServicesList[i].quantity > 0 ||
          extraServicesList[i].isSelected) {
        if (extraServicesList[i].countable!) {
          totalAmount += (extraServicesList[i].quantity *
              double.parse(extraServicesList[i].selectedPrice!).toInt());
          totalDuration +=
              (extraServicesList[i].quantity * double.parse(extraServicesList[i].duration!));
          totalTaxes +=
              (extraServicesList[i].quantity * extraServicesList[i].tax!);
        } else if (extraServicesList[i].isSelected) {
          totalAmount +=
              double.parse(extraServicesList[i].selectedPrice!).toInt();
          totalTaxes += extraServicesList[i].tax!;
          totalDuration += double.parse(extraServicesList[i].duration!);
        }
      }
    }
    notifyListeners();
  }

  void selectCashPayment(bool value) {
    selectedCreditCardPayment = false;
    selectedCashPayment = value;
    notifyListeners();
  }

  void selectCreditCardPayment(bool value) {
    selectedCashPayment = false;
    selectedCreditCardPayment = value;
    notifyListeners();
  }

  void selectWalletPayment(bool value) {
    selectedCashPayment = false;
    selectedCreditCardPayment = false;
    selectedWalletPayment = value;
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
    required cityId,
    required vehicleId,
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
  Future getExtraServices({required cityId, required vehicleId}) async {
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

  CouponData? couponData;
  Future checkOfferCoupon(BuildContext context, {required requestId,
    String? offerCode,
    dynamic employeeId,}) async {
    if (discountCodeController.text.isNotEmpty) {
      AppLoader.showLoader(context);
      await servicesService
          .checkCoupon(discountCode: discountCodeController.text)
          .then((value) async{
        if (value.status == Status.success) {
          couponData = value.data;
          if (couponData!.isActive == 1) {
            CustomSnackBars.successSnackBar(
                context, S.of(context).offerAppliedSuccessfully);
            await updateRequestSlots(requestId: requestId, payBy: 'cash', employeeId: employeeId, offerCode: offerCode);
            AppLoader.stopLoader();
            totalAmountAfterDiscount = updatedRequestDetailsData!.totalAmount;
            /*discountAmount = couponData!.discountAmount!;
            totalAmountAfterDiscount =
                updatedRequestDetailsData!.totalAmount! - discountAmount;*/
            if(totalAmountAfterDiscount! <= 0){
              totalAmountAfterDiscount =0;
            }

          } else {
            AppLoader.stopLoader();
            CustomSnackBars.successSnackBar(
                context, S.of(context).codeNotAccepted);
          }
        } else {
          AppLoader.stopLoader();
          // CustomSnackBars.failureSnackBar(context, S.of(context).codeIsInvalid);
          CustomSnackBars.failureSnackBar(context, value.message);
        }
      });
    } else {
      CustomSnackBars.failureSnackBar(context, S.of(context).enterCodeFirst);
    }

    notifyListeners();
  }

  CityIdData? cityIdData;
  Future<ResponseResult> getCityId({required double lat, required double long}) async {
    Status state = Status.error;
    dynamic message;

    await servicesService.getCityId(lat: lat, lng: long).then((value) {
      if (value.status == Status.success) {
        state = Status.success;
        cityIdData = value.data;
      }else {
        message = value.message;
      }
    });
    notifyListeners();
    return ResponseResult(state, bookServicesData, message: message);
  }

  BookServicesData? bookServicesData;
  Future<ResponseResult> bookServices(
    BuildContext context, {
    required cityId,
    required addressId,
    required vehicleId,
    required basicServiceId,
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
  Future getRequestDetails({required requestId}) async {
    setLoading(true);
    await servicesService.getRequestDetails(requestId: requestId).then((value) {
      if (value.status == Status.success) {
        detailsRequestData = value.data;
      }
    });
    notifyListeners();
  }

  List<List<SlotData>> slotsList = [];
  Future getTimeSlots({
    required cityId,
    required basicId,
    required duration,
    required String date,
    required addressId,
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
      addressId: addressId,
    )
        .then((value) {
      isLoading = false;
      if (value.status == Status.success) {
        slotsList = value.data;
        print('Success ${value.data}');
        print('Time Slot in provider Success');
        print(slotsList);
      }
    });
    notifyListeners();
  }

  RequestDetailsData? updatedRequestDetailsData;
  Future updateRequestSlots({
    required requestId,
    required String payBy,
    String? offerCode,
    dynamic employeeId,
  }) async {
    Status state = Status.error;
    dynamic message;
    await servicesService
        .updateRequestSlots(
      requestId: requestId,
      payBy: payBy,
      offerCode: offerCode,
      employeeId: employeeId
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
    required requestId,
    required String payBy,
    num? walletAmount,
  }) async {
    Status state = Status.error;
    dynamic message;
    await servicesService
        .submitFinialRequest(
            requestId: requestId, payBy: payBy, walletAmount: walletAmount)
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

  Future<ResponseResult> creditRequestPayment({
    required String chargeId,
  }) async {
    Status state = Status.error;
    dynamic message;
    await servicesService
        .creditRequestPayment(
      chargeId: chargeId,
    )
        .then((value) {
      isLoading = true;
      notifyListeners();
      if (value.status == Status.success) {
        state = Status.success;
      }
      isLoading = false;
    });
    notifyListeners();
    return ResponseResult(state, '', message: message);
  }

  RatingData? ratingData;
  Future<ResponseResult> rateRequest({
    required requestId,
    required rate,
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
    required id,
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

  Future<void> uploadPaymentFile(BuildContext context, String imagePath,
      {required bankAccountId, required requestId}) async {
    AppLoader.showLoader(context);
    await servicesService
        .uploadPaymentFile(imagePath,
            bankAccountId: bankAccountId, requestId: requestId)
        .then((value) {
      AppLoader.stopLoader();
      CustomSnackBars.successSnackBar(context, S.of(context).submitRequestSuccess);
    });
  }

  void resetCoupon() {
    couponData = null;
    discountCodeController = TextEditingController(text: '');
    updatedRequestDetailsData != null ? totalAmountAfterDiscount = double.parse(updatedRequestDetailsData!.amount!) + double.parse(updatedRequestDetailsData!.tax!.toString()) : null;
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
    totalTaxes = 0;
    resetCoupon();
    selectedBasicIndex = null;
    selectedSlotIndex = null;
    selectedCashPayment = false;
    selectedCreditCardPayment = false;
    selectedWalletPayment = false;
    notifyListeners();
  }
}
