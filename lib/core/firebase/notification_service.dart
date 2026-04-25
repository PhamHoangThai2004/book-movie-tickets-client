import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../navigation/navigation_service.dart';
import '../utils/app_utils.dart';

@pragma('vm:entry-point')
class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    await messaging.requestPermission();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.onBackgroundMessage(_handleMessageBackground);

    /// Handle when the app is opened from a notification
    FirebaseMessaging.onMessage.listen((message) async {
      if (Platform.isAndroid) {
        _showNotification(message);
      }
    });
    const androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: DarwinInitializationSettings(),
    );

    await _localNotificationsPlugin.initialize(
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          try {
            final data = jsonDecode(response.payload!);
            _setUpOpenFirebaseMessaging(RemoteMessage(data: Map<String, dynamic>.from(data)));
          } catch (e) {
            debugPrint('onDidReceiveNotificationResponse error: ${e.toString()}');
          }
        }
      },
      settings: initializationSettings,
    );
    await _initializeFireBase();
  }

  static Future _initializeFireBase() async {
    final messaging = FirebaseMessaging.instance;

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    /// Request permission for iOS
    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('FirebaseMessaging: User granted permission');
    }
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _localNotificationsPlugin.show(
      id: message.notification.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: notificationDetails,
      payload: jsonEncode(message.data),
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _handleMessageBackground(RemoteMessage message) async {
    debugPrint('FirebaseMessaging message: ${message.toString()}');
  }

  static Future<void> listenerFirebaseMessaging() async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      debugPrint('FirebaseMessaging: App opened by notification! ${message.data}');
      _setUpOpenFirebaseMessaging(message);
    });

    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('FirebaseMessaging: App launched from notification');
      _setUpOpenFirebaseMessaging(initialMessage);
    }
  }

  static Future<void> _setUpOpenFirebaseMessaging(RemoteMessage message) async {
    try {
      if (!AppUtils.isLoggedIn()) {
        await Future.delayed(Duration(seconds: 1));
        final context = NavigationService.rootNavigatorKey.currentState!.context;
        if (!context.mounted) return;
        context.push(NavigationService.signIn);
        return;
      }

      openDetail();
    } catch (e) {
      debugPrint('FirebaseMessaging error: ${e.toString()}');
    }
  }

  static Future<void> deleteToken() async {
    try {
      await messaging.deleteToken();
    } catch (e) {
      debugPrint('FirebaseMessaging deleteToken error: ${e.toString()}');
    }
  }

  static Future<void> getFCMToken(Function(String) receiveFcmToken) async {
    messaging.onTokenRefresh.listen((token) async {
      receiveFcmToken(token);
    });

    if (Platform.isIOS) {
      final apnsToken = await messaging.getAPNSToken();
      if (apnsToken == null) {
        debugPrint('⚠️ FirebaseMessaging: ⚠️ APNs token not found');
        return;
      }
    }

    try {
      String? token = await messaging.getToken();
      receiveFcmToken(token ?? '');
    } catch (e) {
      debugPrint('FirebaseMessaging error: ${e.toString()}');
    }
  }

  static Future<void> openDetail() async {}
}
