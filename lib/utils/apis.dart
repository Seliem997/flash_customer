class Api {
  static const String baseUrl = "https://dashboard.flashwashapp.com/api";

  static const String registerOrLogin = "$baseUrl/customer/register";
  static const String checkCode = "$baseUrl/customer/verify-otp";
  static const String updateMyProfile = "$baseUrl/customer/update-my-profile";

  static const String getAbout = "$baseUrl/about";
  static const String getAboutImages =
      "$baseUrl/get-images?related_to=about_us_slider_images";

  static const String getOtherServices = "$baseUrl/customer/getOtherServices";

  static const String getCityId = "$baseUrl/customer/cities/check/If/FoundIn";

  static const String storeAddress = "$baseUrl/customer/addresses";

  static const String getBasicServices =
      "$baseUrl/customer/services?type=basic";

  static const String getExtraServices =
      "$baseUrl/customer/services?type=extra";

  static const String getRequestDetails = "$baseUrl/customer/request-details/";

  static String getTimeSlots(
          {int cityId = 1, int duration = 50, String date = "05/2/2023"}) =>
      "$baseUrl/customer/slots?city_id=$cityId&services[0]=2&date=$date&services_duration=$duration";

  static const String updateInitialRequest =
      "$baseUrl/customer/update-initial-request?pay_by";

  static const String bookServices = "$baseUrl/customer/initial-request";

  static const String getAddresses = "$baseUrl/customer/my-addresses";

  static const String getVehicles =
      "$baseUrl/customer/vehicle_types/get/active";

  static const String getManufacturers = "$baseUrl/customer/manufacturers";

  static const String getManufacturersOfType =
      "$baseUrl/customer/vehicle_types/get/by/type/id/";

  static const String getVehiclesModels =
      "$baseUrl/customer/vehicle_models/get/by/manufacturers/id/";

  static const String getPackages = "$baseUrl/customer/all-packages?";

  static const String getTransactionHistory =
      "$baseUrl/customer/history-transactions";

  static const String getMyVehicles = "$baseUrl/customer/vehicle/my-vehicles";

  static const String addNewVehicle = "$baseUrl/customer/vehicles";

  static const String checkOfferCoupon = "$baseUrl/customer/check-offer";

  static const String getActiveTax = "$baseUrl/customer/get-active-tax";
}
