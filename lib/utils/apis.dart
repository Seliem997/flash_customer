class Api {

  static const String baseUrl = "https://dashboard.flashwashapp.com/api";


  static const String registerOrLogin = "$baseUrl/customer/register";
  static const String checkCode = "$baseUrl/customer/verify-otp";
  static const String updateMyProfile = "$baseUrl/customer/update-my-profile";

  static const String getAbout = "$baseUrl/about";
  static const String getAboutImages = "$baseUrl/get-images?related_to=about_us_slider_images";

  static const String getOtherServices = "$baseUrl/customer/getOtherServices";

  static const String getAddresses = "$baseUrl/customer/my-addresses";

  static const String getManufacturers = "$baseUrl/customer/manufacturers";
  static const String getVehiclesModels = "$baseUrl/customer/vehicle_models/get/by/manufacturers/id/";

  static const String getPackages = "$baseUrl/customer/all-packages?";

  static const String getTransactionHistory = "$baseUrl/customer/history-transactions";

  static const String getMyVehicles = "$baseUrl/customer/vehicle/my-vehicles";

}