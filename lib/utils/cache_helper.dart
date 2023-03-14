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
    if (sharedPreferences.getString(CacheKey.language.key) == null) {
      sharedPreferences.setString(CacheKey.language.key, LanguageKey.en.key);
    }
    // if (sharedPreferences.getBool(CacheKey.notification.key) == null) {
    //   sharedPreferences.setBool(CacheKey.notification.key, true);
    // }
  }

  static Future<bool> saveData({
    required CacheKey key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await sharedPreferences.setString(key.key, value);
    }
    if (value is int) {
      return await sharedPreferences.setInt(key.key, value);
    }
    if (value is bool) {
      return await sharedPreferences.setBool(key.key, value);
    }
    return await sharedPreferences.setDouble(key.key, value);
  }

  static dynamic returnData({required CacheKey key}) {
    return sharedPreferences.get(key.key);
  }

  static Future<bool> removeData({
    required CacheKey key,
  }) async {
    return await sharedPreferences.remove(key.key);
  }
}
