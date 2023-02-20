import 'package:shared_preferences/shared_preferences.dart';

import 'enum/languages.dart';
import 'enum/shared_preference_keys.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(CacheKey.showOnBoarding.key) == null) {
      sharedPreferences.setBool(CacheKey.showOnBoarding.key, false);
    }
    if (sharedPreferences.getBool(CacheKey.loggedIn.key) == null) {
      sharedPreferences.setBool(CacheKey.loggedIn.key, false);
    }
    if (sharedPreferences.getBool(CacheKey.hasVehicle.key) == null) {
      sharedPreferences.setBool(CacheKey.hasVehicle.key, false);
    }
    if (sharedPreferences.getBool(CacheKey.hasAddress.key) == null) {
      sharedPreferences.setBool(CacheKey.hasAddress.key, false);
    }
    if (sharedPreferences.getString(CacheKey.language.key) == null) {
      sharedPreferences.setString(CacheKey.language.key, LanguageKey.en.key);
    }
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key, value);
    }
    return await sharedPreferences.setDouble(key, value);
  }

  static Future<void> signOut() async {
    sharedPreferences.setString(CacheKey.language.key, LanguageKey.en.key);
    sharedPreferences.setBool(CacheKey.loggedIn.key, false);
    sharedPreferences.setString(CacheKey.address.key, "");
    sharedPreferences.setBool(CacheKey.hasAddress.key, false);
    sharedPreferences.setString(CacheKey.userImage.key, "");
    sharedPreferences.setString(CacheKey.userName.key, "");
    sharedPreferences.setString(CacheKey.userId.key, "");
    sharedPreferences.setBool(CacheKey.showOnBoarding.key, true);
  }

  static dynamic returnData({required String key}) {
    return sharedPreferences.get(key) ?? {};
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
