import 'dart:developer';


import '../base/service/base_service.dart';
import '../models/notificationModel.dart';
import '../models/requestResult.dart';
import '../utils/apis.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class NotificationsService extends BaseService {
  Future<ResponseResult> getNotifications() async {
    Status status = Status.error;
    List<NotificationData>? notifications;
    try {
      await requestFutureData(
          api: Api.notifications,
          requestType: Request.get,
          withToken: true,
          onSuccess: (response) {
            if (response["status_code"] == 200) {
              status = Status.success;
              notifications = NotificationModel.fromJson(response).data;
            } else {
              status = Status.error;
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in getting notification $e");
    }
    return ResponseResult(status, notifications);
  }

  // Future<ResponseResult> seeNotification({required int notificationId}) async {
  //   Status result = Status.error;
  //   Map<String, String> headers = const {'Content-Type': 'application/json'};
  //   Map<String, dynamic> body = {
  //     "id": notificationId,
  //   };
  //
  //   try {
  //     await requestFutureData(
  //         api: Api.seeNotification,
  //         requestType: Request.post,
  //         body: body,
  //         jsonBody: true,
  //         withToken: true,
  //         headers: headers,
  //         onSuccess: (response) async {
  //           try {
  //             result = Status.success;
  //           } catch (e) {
  //             logger.e("Error seeing notification \n$e");
  //           }
  //         });
  //   } catch (e) {
  //     result = Status.error;
  //     log("Error in seeing notification$e");
  //   }
  //   return ResponseResult(result, "");
  // }
}
