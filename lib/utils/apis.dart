class Api {
  static const String baseUrl = "https://dashboard.flashwashapp.com/api";

  static const String registerOrLogin = "$baseUrl/customer/register";
  static const String checkCode = "$baseUrl/customer/verify-otp";

  static const String notifications = "$baseUrl/customer/my-notification";
  static const String getAbout = "$baseUrl/about";
  static const String getSocialLinks = "$baseUrl/social-links";
  static const String getAboutImages =
      "$baseUrl/get-images?related_to=about_us_slider_images";

  static const String getOtherServices =
      "$baseUrl/customer/services?type=other";

  static const String getCityId = "$baseUrl/customer/cities/check/If/FoundIn";

  static const String storeAddress = "$baseUrl/customer/addresses";

  static const String deleteAddress = "$baseUrl/customer/addresses/";

  static const String getBasicServices =
      "$baseUrl/customer/services?type=basic";

  static const String getExtraServices =
      "$baseUrl/customer/services?type=extra";

  static const String getRequestDetails = "$baseUrl/customer/request-details/";

  static const String updateProfile = "$baseUrl/customer/update-my-profile";

  static const String getUserProfile = "$baseUrl/customer/my-profile";

  static String getTimeSlots(
          {int cityId = 1,
          int basicId = 27,
          double duration = 50,
          String? service,
          String date = "06/5/2023",
            required int addressId
          }) =>
      "$baseUrl/customer/slots?city_id=$cityId&services[0]=$basicId$service&date=$date&services_duration=$duration&address_id=$addressId";

  static String rateRequest({required int requestId}) =>
      "$baseUrl/customer/set-request-rate/$requestId";

  static String getPackageSlots({
    int cityId = 2,
    int packageId = 1,
    int packageDuration = 10,
    String date = "2/22/2222",
  }) =>
      "$baseUrl/customer/slots-package?city_id=$cityId&package_id=$packageId&date=$date&package_duration=$packageDuration";

  static const String updateInitialRequest =
      "$baseUrl/customer/update-initial-request?pay_by";

  static const String submitFinialRequest = "$baseUrl/customer/request";

  static String updateRequestStatus({required int requestId}) => "$baseUrl/customer/update-request-status/$requestId";

  static const String bookServices = "$baseUrl/customer/initial-request";

  static const String storeInitialPackageRequest =
      "$baseUrl/customer/initial-package-request";

  static const String saveSlotsPackageRequest =
      "$baseUrl/customer/request-package-employee-id";

  static const String reserveRequestPackageSlots = "$baseUrl/customer/reserve-request-slot";

  static const String assignEmployee = "$baseUrl/customer/request-employee-id";

  static const String getAddresses = "$baseUrl/customer/my-addresses";

  static const String getVehicles =
      "$baseUrl/customer/vehicle_types/get/active";

  static const String getManufacturers = "$baseUrl/customer/manufacturers";

  static const String getManufacturersOfType =
      "$baseUrl/customer/vehicle_types/get/by/type/id/";

  static const String getVehiclesModels =
      "$baseUrl/customer/vehicle_models/get/by/manufacturers/id/";

  static const String getPackages = "$baseUrl/customer/all-packages?";

  static const String walletCharge = "$baseUrl/request-payment/done";

  static const String getTransactionHistory =
      "$baseUrl/customer/history-transactions";

  static const String chargingWallet = "$baseUrl/customer/charge-wallet";

  static const String getMyVehicles = "$baseUrl/customer/vehicle/my-vehicles";

  static const String addNewVehicle = "$baseUrl/customer/vehicles";

  static String updateVehicle({required int requestId}) =>
      "$baseUrl/update-vehicle/$requestId";

  static const String deleteVehicle = "$baseUrl/customer/vehicles/";

  static const String deleteMyAccount = "$baseUrl/customer/delete-my-account";

  static String getMyRequests ({String? status, String? dateFrom, String? dateTo}) =>
      "$baseUrl/customer/customer-requests?${status == null ? '': "status=$status"}&${dateFrom == null ? '' : "date=$dateFrom"}&${dateTo == null ? '' : "date2=$dateTo"}";

  static const String checkOfferCoupon = "$baseUrl/customer/check-offer";

  static const String getActiveTax = "$baseUrl/customer/get-active-tax";

  static const String contactUs = "$baseUrl/contact_us";

  static const String bankAccounts = "$baseUrl/bank_accounts";
}
