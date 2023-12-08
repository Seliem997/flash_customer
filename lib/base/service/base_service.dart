import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

import '../../utils/app_loader.dart';
import '../../utils/cache_helper.dart';
import '../../utils/enum/request_types.dart';
import '../../utils/enum/shared_preference_keys.dart';
import '../../utils/global_event_bus.dart';
import '../network_fail_event.dart';

class BaseService {
  // final _instance = FirebaseAuth.instance;
  Logger logger = Logger();
  Future<void> requestFutureData(
      {required String api,
      bool jsonBody = false,
      bool withToken = false,
      required Request requestType,
      Map<String, dynamic> body = const {},
      Map<String, String> headers = const {},
      required Function(Map<String, dynamic> response) onSuccess}) async {
    Map<String, String> headerWithToken = {};

    headerWithToken.addEntries(headers.entries);
    // if(jsonBody){
    //   headerWithToken.addEntries({'Content-Type': 'application/json'}.entries);
    // }

    try {
      if (withToken) {
        print('With token error ${CacheHelper.returnData(key: CacheKey.token)}');
        headerWithToken.addEntries({
          "Authorization": CacheHelper.returnData(key: CacheKey.token) as String
        }.entries);
        logger.i(
            "Request Called: $api ${headerWithToken.isNotEmpty ? "\nHeaders: $headerWithToken" : ''} ${body.isNotEmpty ? "\nBody: $body" : ''}");
        if (requestType == Request.post) {
          await http
              .post(Uri.parse(api),
                  body: jsonBody ? jsonEncode(body) : body,
                  headers: headerWithToken)
              .timeout(const Duration(seconds: 15), onTimeout: () {
            AppLoader.stopLoader();
            logger.e("Request Timeout");
            mainEventBus.fire(NetworkFailEvent());
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        } else if (requestType == Request.get) {
          await http
              .get(Uri.parse(api), headers: headerWithToken)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            AppLoader.stopLoader();
            // CustomSnackBars.somethingWentWrongSnackBar(context);
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              await onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              await onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        } else if (requestType == Request.delete) {
          await http
              .delete(Uri.parse(api), headers: headerWithToken)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            AppLoader.stopLoader();
            // CustomSnackBars.somethingWentWrongSnackBar(context);
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              await onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              await onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        } else if (requestType == Request.patch) {
          await http
              .patch(Uri.parse(api),
              body: jsonBody ? jsonEncode(body) : body,
              headers: headerWithToken)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            AppLoader.stopLoader();
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        } else if (requestType == Request.put) {
          await http
              .put(Uri.parse(api),
              body: jsonBody ? jsonEncode(body) : body,
              headers: headerWithToken)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            AppLoader.stopLoader();
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        }
      } else {
        logger.i(
            "Request Called: $api ${headers.isNotEmpty ? "\nHeaders: $headers" : ''} ${body.isNotEmpty ? "\nBody: $body" : ''}");
        if (requestType == Request.post) {
          await http
              .post(Uri.parse(api),
                  body: jsonBody ? jsonEncode(body) : body, headers: headers)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            AppLoader.stopLoader();
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        } else if (requestType == Request.get) {
          await http
              .get(Uri.parse(api), headers: headers)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            AppLoader.stopLoader();
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        } else if (requestType == Request.delete) {
          await http
              .delete(Uri.parse(api), headers: headerWithToken)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            AppLoader.stopLoader();
            // CustomSnackBars.somethingWentWrongSnackBar(context);
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              await onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              await onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        } else if (requestType == Request.patch) {
          await http
              .patch(Uri.parse(api),
              body: jsonBody ? jsonEncode(body) : body, headers: headers)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            AppLoader.stopLoader();
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        } else if (requestType == Request.put) {
          await http
              .put(Uri.parse(api),
              body: jsonBody ? jsonEncode(body) : body,
              headers: headerWithToken)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            AppLoader.stopLoader();
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['status_code'] == 200 ||
                jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['status_code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Error in $api \nError: ${value.body}");
            }
          });
        }
      }
    } catch (e) {
      logger.e("Error in $api \nError: $e");
    }
  }
}
