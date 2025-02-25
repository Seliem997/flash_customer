import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../base/service/base_service.dart';
import '../firebase_options.dart';
import '../models/requestResult.dart';
import '../utils/enum/request_types.dart';
import '../utils/enum/statuses.dart';

class FirebaseService extends BaseService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  Future<ResponseResult> updateFCMToken() async {
    Status status = Status.error;

    try {
      await requestFutureData(
          api: "Api.updateFCMToken",
          requestType: Request.post,
          body: {"fcm_token": await FirebaseMessaging.instance.getToken()},
          jsonBody: true,
          withToken: true,
          headers: {'Content-Type': 'application/json'},
          onSuccess: (response) async {
            try {
              status = Status.success;
            } catch (e) {
              logger.e("Error updating token\n$e");
            }
          });
    } catch (e) {
      status = Status.error;
      logger.e("Error in updating token $e");
    }
    return ResponseResult(status, "");
  }

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
    FirebaseService._firebaseMessaging = FirebaseMessaging.instance;
    await FirebaseService.initializeLocalNotifications();
    await onMessage();
    await FirebaseService.onBackgroundMsg();
  }

  static Future<String?> getDeviceToken() async =>
      await FirebaseMessaging.instance.getToken();

  static FlutterLocalNotificationsPlugin localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static Future<void> initializeLocalNotifications() async {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await localNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
        if (notificationResponse.payload != null && notificationResponse.payload!.isNotEmpty) {
          debugPrint('notification payload: ${notificationResponse.payload}');
          // Handle the notification action here
        }
      },
    );


    await FirebaseService.firebaseMessaging
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    if (kDebugMode) {
      print("Firebase Token: ${await FirebaseService.getDeviceToken()}");
    }
  }

  static NotificationDetails platformChannelSpecifics =
  const NotificationDetails(
    android: AndroidNotificationDetails(
      "high_importance_channel",
      "High Importance Notifications",
      priority: Priority.max,
      importance: Importance.max,
    ),
  );

  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('listening messages on foreground');
      log("${message.data}");
      if (message.notification != null) {
        await showNotification(message.notification!.title ?? "no title",
            message.notification!.body ?? "no body");
      }
    });
  }

  static Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        showProgress: true,
        ticker: 'test ticker',
        fullScreenIntent: true,
        channelShowBadge: true,
        setAsGroupSummary: true,
        visibility: NotificationVisibility.public,
        styleInformation: DefaultStyleInformation(true, true));

    var iOSChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSChannelSpecifics,
    );

    await localNotificationsPlugin.show(
        0, title, body, platformChannelSpecifics, payload: 'test');
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    if (Platform.isAndroid) {
      await showNotification(message.notification?.title ?? "no title",
          message.notification?.body ?? "no body");
    } else {
      await showNotification(
          message.notification!.title!, message.notification!.body!);
    }
    print("onMessage: $message");
  }
}
