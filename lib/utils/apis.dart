class Api {
  static const String testUrl = "http://localhost:5001/saasartev/us-central1";
  static const String url = "https://us-central1-saasartev.cloudfunctions.net";
  static const String baseUrl = url;

  static const String getUserWithPhone = "$baseUrl/getUserDataWithPhone";
  static const String createUser = "$baseUrl/createUser";
  static const String getAvailableBrands =
      "$baseUrl/getAvilableExtendedProfileBrands";
  static const String getBrandModels = "$baseUrl/getAvilableBrandModels";
  static const String addNewExtendedProfile = "$baseUrl/addNewExtendedProfile";
  static const String updateExtendedProfile = "$baseUrl/updateExtendedProfile";
  static const String removeExtendedProfile =
      "$baseUrl/api/removeExtendedProfile";
  static const String getUserExtendedProfiles =
      "$baseUrl/getUserExtendedProfiles";
  static const String getUserExtendedProfileWithId =
      "$baseUrl/getUserExtendedProfileWithId";

  static const String updateUserData = "$baseUrl/updateUserData";

  static const String checkPhoneNumberIfUsed =
      "$baseUrl/checkPhoneNumberIfUsed";

  static const String getUserData = "$baseUrl/getUserData";

  static const String getCities = "$baseUrl/api/getCities";

  static const String getRegions = "$baseUrl/api/getRegions";

  static const String getRentalPlans = "$baseUrl/getRentalPlans";

  static const String checkout = "$baseUrl/checkout";

  static const String pickAdapter = "$baseUrl/pickAdapter";

  static const String requestInstallationSurvey =
      "$baseUrl/requestInstallationSurvey";

  static const String cancelAdapterRentalRequest =
      "$baseUrl/cancelAdapterRequest";

  static const String getRequestDetails = "$baseUrl/api/getRequestDetails";

  static const String getUserRequests = "$baseUrl/api/getUserRequests";

  static const String getCancelReasons = "$baseUrl/api/getCancelReasons";

  static const String getAllShopItems = "$baseUrl/api/getAllShopItems";
  static const String getAllShopCatalogs = "$baseUrl/api/getShopCatalogs";
  static const String getEquipmentFilters = "$baseUrl/api/getShopFilters";
  static const String getShopItemDetails = "$baseUrl/api/getShopItemDetails";

  static const String addToFavorite = "$baseUrl/api/addToFavorite";
  static const String removeFromFavorite = "$baseUrl/api/removeFromFavorite";
  static const String getFavorites = "$baseUrl/api/getFavorites";

  static const String getVehiclesFilters = "$baseUrl/api/getShopFilters";
  static const String getFilterOptions = "$baseUrl/api/getFilterDetails";

  static const String getNews = "$baseUrl/api/getNews";

  static const String getUserOrders = "$baseUrl/api/getUserOrders";
}
