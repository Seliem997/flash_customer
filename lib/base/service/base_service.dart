import 'dart:convert';
import 'dart:io';
import 'package:flash_customer/utils/enum/http_request_types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

class BaseService {
  final _instance = FirebaseAuth.instance;
  Logger logger = Logger();
  Future<void> requestFutureData(
      {required String api,
      bool jsonBody = false,
      bool withToken = false,
      required HttpRequest requestType,
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
        await _instance.currentUser!.getIdToken().then((token) async {
          headerWithToken.addEntries({"token": token}.entries);
          logger.i(
              "Request Called: ${requestType.key} $api ${headerWithToken.isNotEmpty ? "\nHeaders: $headerWithToken" : ''} ${body.isNotEmpty ? "\nBody: $body" : ''}");
          if (requestType == HttpRequest.post) {
            await http
                .post(Uri.parse(api),
                    body: jsonBody ? jsonEncode(body) : body,
                    headers: headerWithToken)
                .timeout(const Duration(seconds: 10), onTimeout: () {
              logger.e("Request Timeout");
              return http.Response('Request Timeout', 408);
            }).then((value) async {
              if (jsonDecode(value.body)['code'] == 200) {
                logger.i("Data Came from $api \nData: ${value.body}");
                onSuccess(jsonDecode(value.body));
              } else if (jsonDecode(value.body)['code'] == 401) {
                onSuccess(jsonDecode(value.body));
                logger.w("Something went wrong $api \nData: ${value.body}");
              } else {
                onSuccess(jsonDecode(value.body));
                logger.w("Something went wrong $api \nData: ${value.body}");
              }
            });
          } else if (requestType == HttpRequest.get) {
            await http
                .get(Uri.parse(api), headers: headerWithToken)
                .timeout(const Duration(seconds: 10), onTimeout: () {
              logger.e("Request Timeout");
              return http.Response('Request Timeout', 408);
            }).then((value) async {
              if (jsonDecode(value.body)['code'] == 200) {
                logger.i("Data Came from $api \nData: ${value.body}");
                await onSuccess(jsonDecode(value.body));
              } else if (jsonDecode(value.body)['code'] == 401) {
                await onSuccess(jsonDecode(value.body));
                logger.w("Something went wrong $api \nData: ${value.body}");
              } else {
                onSuccess(jsonDecode(value.body));
                logger.w("Something went wrong $api \nData: ${value.body}");
              }
            });
          } else if (requestType == HttpRequest.delete) {
            await http
                .delete(Uri.parse(api),
                    body: jsonBody ? jsonEncode(body) : body,
                    headers: headerWithToken)
                .timeout(const Duration(seconds: 10), onTimeout: () {
              logger.e("Request Timeout");
              return http.Response('Request Timeout', 408);
            }).then((value) async {
              if (jsonDecode(value.body)['code'] == 200) {
                logger.i("Data Came from $api \nData: ${value.body}");
                onSuccess(jsonDecode(value.body));
              } else if (jsonDecode(value.body)['code'] == 401) {
                onSuccess(jsonDecode(value.body));
                logger.w("Something went wrong $api \nData: ${value.body}");
              } else {
                onSuccess(jsonDecode(value.body));
                logger.w("Something went wrong $api \nData: ${value.body}");
              }
            });
          }
        });
      } else {
        logger.i(
            "Request Called: ${requestType.key} $api ${headers.isNotEmpty ? "\nHeaders: $headers" : ''} ${body.isNotEmpty ? "\nBody: $body" : ''}");
        if (requestType == HttpRequest.post) {
          await http
              .post(Uri.parse(api),
                  body: jsonBody ? jsonEncode(body) : body, headers: headers)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Something went wrong $api \nData: ${value.body}");
            }
          });
        } else if (requestType == HttpRequest.get) {
          await http
              .get(Uri.parse(api), headers: headers)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Something went wrong $api \nData: ${value.body}");
            }
          });
        } else if (requestType == HttpRequest.delete) {
          await http
              .delete(Uri.parse(api),
                  body: jsonBody ? jsonEncode(body) : body, headers: headers)
              .timeout(const Duration(seconds: 10), onTimeout: () {
            logger.e("Request Timeout");
            return http.Response('Request Timeout', 408);
          }).then((value) async {
            if (jsonDecode(value.body)['code'] == 200) {
              logger.i("Data Came from $api \nData: ${value.body}");
              onSuccess(jsonDecode(value.body));
            } else if (jsonDecode(value.body)['code'] == 401) {
              onSuccess(jsonDecode(value.body));
              logger.w("Something went wrong $api \nData: ${value.body}");
            } else {
              onSuccess(jsonDecode(value.body));
              logger.e("Something went wrong $api \nData: ${value.body}");
            }
          });
        }
      }
    } catch (e) {
      logger.e("Error in $api \nError: $e");
    }
  }
}
