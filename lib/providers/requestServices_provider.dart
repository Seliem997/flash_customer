import 'package:flash_customer/models/taxModel.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/bookServicesModel.dart';
import '../models/cityIdModel.dart';
import '../models/offerCouponModel.dart';
import '../models/requestDetailsModel.dart';
import '../models/servicesModel.dart';
import '../services/requestServices_service.dart';
import '../utils/enum/statuses.dart';
import '../utils/snack_bars.dart';

class RequestServicesProvider with ChangeNotifier {
  RequestServicesService servicesService = RequestServicesService();

  TextEditingController discountCodeController =
      TextEditingController(text: '');
  int totalAmount = 0;
  int basicAmount = 0;
  int extraAmount = 0;
  int totalAmountAfterDiscount = 0;
  int discountAmount = 0;
  int selectedBasicServiceAmount = 0;
  int selectedBasicServiceDuration = 0;
  int selectedBasicServiceId = 0;
  int? selectedBasicIndex;
  bool isLoading = true;
  List<ExtraServicesItem> selectedExtraServices= [];
  bool selectedCashPayment = false;

  void setLoading(bool value) {
    isLoading = value;
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


  void calculateTotal() {
    totalAmount = 0;
    if (selectedBasicIndex != null) {
      // totalAmount+=basicServicesList[selectedBasicIndex].
    }
    notifyListeners();
  }

  List<ServiceData> basicServicesList = [];
  Future getBasicServices({required int cityId, required int vehicleId,}) async {
    RequestServicesService servicesService = RequestServicesService();
    await servicesService.getBasicServices(cityId: cityId, vehicleId: vehicleId).then((value) {
      if (value.status == Status.success) {
        basicServicesList = value.data;
      }
    });
    notifyListeners();
  }

  List<ServiceData> extraServicesList = [];
  Future getExtraServices({required int cityId, required int vehicleId}) async {
    RequestServicesService servicesService = RequestServicesService();
    await servicesService.getExtraServices(cityId: cityId, vehicleId: vehicleId,).then((value) {
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
  Future checkOfferCoupon(BuildContext context) async {
    if (discountCodeController.text.isNotEmpty) {
      AppLoader.showLoader(context);
      await servicesService
          .checkCoupon(discountCode: discountCodeController.text)
          .then((value) {
        AppLoader.stopLoader();
        if (value.status == Status.success) {
          couponData = value.data;
          calculateTotal();
          if (couponData!.isActive == 1) {
            CustomSnackBars.successSnackBar(
                context, S.of(context).offerAppliedSuccessfully);
            discountAmount = couponData!.discountAmount!;
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
  Future getCityId(BuildContext context,{required double lat, required double long}) async {
      await servicesService
          .getCityId(lat: lat, lng: long)
          .then((value) {
        if (value.status == Status.success) {
          cityIdData = value.data;

        }

      });


    notifyListeners();
  }


  BookServicesData? bookServicesData;
  Future bookServices(BuildContext context,{
    required int cityId,
    required int vehicleId,
    required int basicServiceId,
  }) async {
    extraServicesList.forEach((element) {
      if(element.quantity > 0 || element.isSelected){
        selectedExtraServices.add(
            ExtraServicesItem(element.id!,element.quantity)
        );
      }
    });
    await servicesService
        .bookServices(cityId: cityId, vehicleId: vehicleId, basicServiceId: basicServiceId, selectedExtraServices: selectedExtraServices)
        .then((value) {
      if (value.status == Status.success) {
        bookServicesData = value.data;
      }
    });
    notifyListeners();
  }


  RequestDetailsData? requestDetailsData;
  Future getRequestDetails({required int requestId}) async {
    setLoading(true);
    RequestServicesService servicesService = RequestServicesService();
    await servicesService.getRequestDetails(requestId: requestId).then((value) {
      if (value.status == Status.success) {
        requestDetailsData = value.data;
      }
    });
    notifyListeners();
  }



  void resetCoupon() {
    couponData = null;
    discountCodeController = TextEditingController();
    calculateTotal();
    notifyListeners();
  }
}
