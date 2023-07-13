import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../base/service/base_service.dart';
import '../providers/firebase_provider.dart';

class FirebaseService extends BaseService {
  static FirebaseMessaging? _firebaseMessaging;
  static FirebaseMessaging get firebaseMessaging =>
      FirebaseService._firebaseMessaging ?? FirebaseMessaging.instance;

  static Future<void> initializeFirebase() async {
    // await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform);
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
    const InitializationSettings _initSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: IOSInitializationSettings());

    /// on did receive notification response = for when app is opened via notification while in foreground on android
    await localNotificationsPlugin.initialize(_initSettings,
        onSelectNotification: FCMProvider.onTapNotification);

    /// need this for ios foregournd notification
    await FirebaseService.firebaseMessaging
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    if (kDebugMode) {
      print("Firebase Token:" + "${await FirebaseService.getDeviceToken()}");
    }
  }

  static NotificationDetails platformChannelSpecifics =
      const NotificationDetails(
    android: AndroidNotificationDetails(
      "high_importance_channel",
      "High Importance Notifications",
      "",
      priority: Priority.max,
      importance: Importance.max,
    ),
  );

  // for receiving message when app is in background or foreground
  static Future<void> onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('listening messages on foreground');
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true, // Required to display a heads up notification
        badge: true,
        sound: true,
      );

      if (Platform.isAndroid) {
        log("${message.data}");
        await showNotification(message.notification?.title ?? "no title",
            message.notification?.body ?? "no body");
      }
      print("whenAppIsOpenedMSG: ${message.notification}");
    });
  }

  static Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_ID', 'channel name', "",
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');
    var iOSChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    await localNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
  }

  static Future<void> onBackgroundMsg() async {
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      if (Platform.isAndroid) {
        showNotification(message.notification?.title ?? "no title",
            message.notification?.body ?? "no title");
      } else {
        showNotification(
            message.notification!.title!, message.notification!.body!);
      }
      print("onMessage: $message");
    });
  }
}
