import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/notificationModel.dart';
import '../services/notifications_service.dart';
import '../utils/enum/statuses.dart';

class NotificationsProvider extends ChangeNotifier {
  final NotificationsService notificationsService = NotificationsService();
  List<NotificationData>? notifications;
  bool loadingNotifications = true;

  Future getNotifications() async {
    loadingNotifications = true;
    notifyListeners();
    await notificationsService.getNotifications().then((value) {
      loadingNotifications = false;
      if (value.status == Status.success) {
        notifications = value.data as List<NotificationData>?;
      }
    });
    notifyListeners();
  }
}
