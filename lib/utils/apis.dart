class Api {

  static const String baseUrl = "https://dashboard.flashwashapp.com/api";


  static const String registerOrLogin = "$baseUrl/customer/register";
  static const String checkCode = "$baseUrl/customer/verify-otp";
  static const String updateMyProfile = "$baseUrl/customer/update-my-profile";

  static const String getOtherServices = "$baseUrl/getOtherServices";


  static const String getAbout = "$baseUrl/about";
  static const String getAboutImages = "$baseUrl/get-images?related_to=about_us_slider_images";

 }
