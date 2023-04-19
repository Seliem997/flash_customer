import 'package:flash_customer/models/taxModel.dart';
import 'package:flash_customer/utils/app_loader.dart';
import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import '../models/offerCouponModel.dart';
import '../models/servicesModel.dart';
import '../models/servicesModel2.dart';
import '../services/requestServices_service.dart';
import '../utils/enum/statuses.dart';
import '../utils/snack_bars.dart';

class RequestServicesProvider with ChangeNotifier {
  RequestServicesService servicesService = RequestServicesService();

  TextEditingController discountCodeController =
      TextEditingController(text: '');
  int totalAmount = 0;
  int totalAmountAfterDiscount = 0;
  int discountAmount = 0;
  int selectedBasicServiceAmount = 0;
  int selectedBasicServiceDuration = 0;
  int? selectedBasicIndex;

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
  Future getBasicServices() async {
    RequestServicesService servicesService = RequestServicesService();
    await servicesService.getBasicServices().then((value) {
      if (value.status == Status.success) {
        basicServicesList = value.data;
      }
    });
    notifyListeners();
  }

  List<ServiceData> extraServicesList = [];
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

  void resetCoupon() {
    couponData = null;
    discountCodeController = TextEditingController();
    calculateTotal();
    notifyListeners();
  }
}
