import 'dart:convert';
import 'dart:developer' as log;
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_utils/get_utils.dart';

class FlutterLocalNotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late AndroidNotificationChannel _channel;
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }
    AndroidInitializationSettings? initializationSettingsAndroid;
    DarwinInitializationSettings? initializationSettingsIOS;
    if (Platform.isAndroid) {
      initializationSettingsAndroid = const AndroidInitializationSettings(
        '@mipmap/ic_launcher',
      );
      _channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );
      // Android notification permission (POST_NOTIFICATIONS) should be
      // requested via the Android SDK (targeting Android 13+). The
      // AndroidFlutterLocalNotificationsPlugin in newer versions does not
      // expose a `requestPermission` method. We only create the channel here.
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(_channel);
    } else if (Platform.isIOS) {
      initializationSettingsIOS = DarwinInitializationSettings();
    }
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> _onSelectNotification(NotificationResponse response) async {
    log.log(
      "_onSelectNotification${response.toString()}",
      name: "_onSelectNotification",
    );
    final decoded =
        json.decode(response.payload ?? "{}") as Map<String, dynamic>;
    log.log('notification payload: $decoded', name: '_onSelectNotification');
  }

  void showFirebaseNotification(RemoteMessage message) {
    final RemoteNotification? notification = message.notification;
    final AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channel.id,
            _channel.name,
            channelDescription: _channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: json.encode(message.toMap()),
      );
    }
  }

  Future<void> fileDownloadNotification(
    Map<String, dynamic> downloadStatus,
  ) async {
    final NotificationDetails platform;
    if (Platform.isAndroid) {
      final AndroidNotificationDetails android = AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        icon: '@mipmap/ic_launcher',
        priority: Priority.high,
        importance: Importance.max,
        sound: const RawResourceAndroidNotificationSound('default'),
      );
      platform = NotificationDetails(android: android);
    } else {
      final iOS = DarwinNotificationDetails();
      platform = NotificationDetails(iOS: iOS);
    }
    final json = jsonEncode(downloadStatus);
    final isSuccess = downloadStatus['isSuccess'] as bool;
    await _flutterLocalNotificationsPlugin.show(
      Random().nextInt(100),
      isSuccess ? 'Success'.tr : 'Failure'.tr,
      isSuccess
          ? 'File has been downloaded successfully!'.tr
          : 'There was an error while downloading the file.'.tr,
      platform,
      payload: json,
    );
  }

  // IOS this function is executed when the app is in the foreground and you can show alert dialog with notification details
  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    debugPrint('notification _onDidReceiveLocalNotification');
    if (payload != null) {
      debugPrint('notification payload Ios: $payload');
    }
  }
}
