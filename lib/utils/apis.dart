class Api {
  static const String testUrl = "https://ahmos.smartsols.co/api";

  static const String imageUrl =
      "https://ahmos-dental.com/public/images/products/thumb/";
  static const String baseUrl = "https://flashwashapp.com/public/api/customer";

  static const String registerOrLogin = "$baseUrl/register";
  static const String getMyProfile = "$baseUrl/employee/my-profile";
  static const String loginSocial = "$baseUrl/login-by-social-media";
  static const String forgotPassword = "$baseUrl/employee/forget-password";
  static const String checkCode = "$baseUrl/verify-otp";
  static const String resetPassword = "$baseUrl/reset-password";
  static const String register = "$baseUrl/register";
  static const String contactUs = "$baseUrl/contact-us";
  static const String getUserWithPhone = "$baseUrl/getUserDataWithPhone";
  static const String createUser = "$baseUrl/createUser";
  static const String getAvailableBrands =
      "$baseUrl/getAvilableExtendedProfileBrands";
  static const String getBrandModels = "$baseUrl/getAvilableBrandModels";
  static const String addNewExtendedProfile = "$baseUrl/addNewExtendedProfile";
  static const String updateExtendedProfile = "$baseUrl/updateExtendedProfile";
  static const String getUserExtendedProfiles =
      "$baseUrl/getUserExtendedProfiles";
  static const String getUserExtendedProfileWithId =
      "$baseUrl/getUserExtendedProfileWithId";

  static const String updateUserData = "$baseUrl/updateUserData";

  static const String checkPhoneNumberIfUsed =
      "$baseUrl/checkPhoneNumberIfUsed";

  static const String getUserData = "$baseUrl/my-info";

  static const String getRentalPlans = "$baseUrl/getRentalPlans";

  static const String checkout = "$baseUrl/order/checkout";

  static const String pickAdapter = "$baseUrl/pickAdapter";

  static const String cancelAdapterRentalRequest =
      "$baseUrl/cancelAdapterRequest";

  static const String getAdapterRentalRequestDetails =
      "$baseUrl/api/getAdapterRequestDetails";

  static const String getUserRentalRequests =
      "$baseUrl/api/getUserRentalRequests";

  static const String getCancelReasons = "$baseUrl/api/getCancelReasons";

  static const String getTopProducts = "$baseUrl/products";
  static const String getProducts = "$baseUrl/products";
  static const String getOffers = "$baseUrl/offers";
  static String getProductsOfCategory(String categoryId) =>
      "$baseUrl/category/$categoryId/products";
  static String searchProducts(String productName) =>
      "$baseUrl/products-search?search=$productName";
  static const String updateFCMToken = "$baseUrl/fcm-token";
  static const String getAllCategories = "$baseUrl/categories";
  static const String getNotifications = "$baseUrl/notifications";
  static const String getPrivacyPolicy = "$baseUrl/pages/2";
  static const String getTermsAndConditions = "$baseUrl/pages/1";
  static const String getContactData = "$baseUrl/config";
  static String readNotification(String id) =>
      "$baseUrl/notifications/$id/update";
  static const String getOrders = "$baseUrl/order/myorders";
  static String getOrderDetails(String id) => "$baseUrl/order/order/$id";
  static const String getEquipmentFilters = "$baseUrl/api/getShopFilters";
  static const String getShopItemDetails = "$baseUrl/api/getShopItemDetails";
  static String optionsForProducts(String id) =>
      "$baseUrl/options-for-products/$id";

  static const String addToFavorite = "$baseUrl/api/addToFavorite";
  static const String removeFromFavorite = "$baseUrl/api/removeFromFavorite";
  static const String getFavorites = "$baseUrl/api/getFavorites";
  static const String addAddress = "$baseUrl/user/address";
  static const String addToCart = "$baseUrl/carts";
  static String removeFromCart(String productId) => "$baseUrl/carts/$productId";
  static const String getCartItems = "$baseUrl/carts";
  static const String updateProfile = "$baseUrl/update-profile";
  static String updateAddress(int addressId) =>
      "$baseUrl/user/address/$addressId";

  static String makeDefaultAddress(int addressId) =>
      "$baseUrl/user/address/make-default/$addressId";
  static const String getAddresses = "$baseUrl/user/address";
  static const String getCountries = "$baseUrl/countries";
  static const String getAllGovernorates = "$baseUrl/governments";
  static String getGovernoratesOfCountry(int countryId) =>
      "$baseUrl/government/$countryId";
  static String getCitiesOfGovernorate(int governorateId) =>
      "$baseUrl/city/$governorateId";
}
