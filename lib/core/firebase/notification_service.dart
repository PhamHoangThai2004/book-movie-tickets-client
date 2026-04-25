import 'dart:convert';
import 'dart:io';

import 'package:client/data/enums/notification_type_enum.dart';
import 'package:client/data/model/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

import '../navigation/navigation_service.dart';
import '../utils/app_utils.dart';
import '../utils/handle_notification_utils.dart';

@pragma('vm:entry-point')
class NotificationService {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future<void> initialize() async {
    debugPrint('🔔 Initializing Notification Service...');
    await messaging.requestPermission();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.onBackgroundMessage(_handleMessageBackground);

    /// Handle when the app is opened from a notification
    FirebaseMessaging.onMessage.listen((message) async {
      debugPrint('🔔 FCM onMessage received - Title: ${message.notification?.title}');
      debugPrint('🔔 FCM onMessage Body: ${message.notification?.body}');
      debugPrint('🔔 FCM onMessage Data: ${message.data}');
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
        debugPrint('========================================');
        debugPrint('🔔 **CALLBACK** onDidReceiveNotificationResponse');
        debugPrint('🔔 Response ID: ${response.id}');
        debugPrint('🔔 Response Payload: ${response.payload}');
        debugPrint('🔔 Response ActionId: ${response.actionId}');
        debugPrint('🔔 Full NotificationResponse: $response');
        debugPrint('========================================');
        if (response.payload != null) {
          try {
            final data = jsonDecode(response.payload!);
            debugPrint('🔔 Decoded Data: $data');
            debugPrint('🔔 Calling _setUpOpenFirebaseMessaging from onDidReceiveNotificationResponse');
            _setUpOpenFirebaseMessaging(RemoteMessage(data: Map<String, dynamic>.from(data)));
          } catch (e) {
            debugPrint('❌ onDidReceiveNotificationResponse error: ${e.toString()}');
          }
        }
      },
      settings: initializationSettings,
    );
    await _initializeFireBase();
    await _setupFirebaseMessagingListeners();
    debugPrint('✅ Notification Service initialized successfully');
  }

  static Future _initializeFireBase() async {
    debugPrint('🔔 Initializing Firebase Messaging settings...');
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
      debugPrint('✅ FirebaseMessaging: User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('⚠️ FirebaseMessaging: User granted provisional permission');
    } else {
      debugPrint('❌ FirebaseMessaging: User denied permission');
    }
  }

  static Future<void> _showNotification(RemoteMessage message) async {
    debugPrint('🔔 _showNotification - Message ID: ${message.messageId}');
    debugPrint('🔔 Notification Title: ${message.notification?.title}');
    debugPrint('🔔 Notification Body: ${message.notification?.body}');
    debugPrint('🔔 Notification Image: ${message.notification?.android?.imageUrl}');
    debugPrint('🔔 Message Data: ${message.data}');
    debugPrint('🔔 Payload being set: ${jsonEncode(message.data)}');

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
    debugPrint('✅ Notification shown with ID: ${message.notification.hashCode}');
  }

  @pragma('vm:entry-point')
  static Future<void> _handleMessageBackground(RemoteMessage message) async {
    debugPrint('🔔 Background FCM Message received');
    debugPrint('🔔 Background Message Title: ${message.notification?.title}');
    debugPrint('🔔 Background Message Body: ${message.notification?.body}');
    debugPrint('🔔 Background Message Data: ${message.data}');
    debugPrint('🔔 Full Background Message: ${message.toString()}');
  }

  static Future<void> listenerFirebaseMessaging() async {
    debugPrint('========================================');
    debugPrint('🔔 listenerFirebaseMessaging() called (legacy - already set up in initialize())');
    debugPrint('========================================');
    await _setupFirebaseMessagingListeners();
  }

  static Future<void> _setupFirebaseMessagingListeners() async {
    debugPrint('========================================');
    debugPrint('🔔 Setting up FCM listeners - _setupFirebaseMessagingListeners()');
    debugPrint('========================================');

    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      debugPrint('========================================');
      debugPrint('🔔 **CALLBACK** onMessageOpenedApp triggered');
      debugPrint('🔔 *** APP OPENED FROM NOTIFICATION ***');
      debugPrint('🔔 Message Data: ${message.data}');
      debugPrint('🔔 Message Notification: ${message.notification}');
      debugPrint('🔔 Calling _setUpOpenFirebaseMessaging from onMessageOpenedApp');
      debugPrint('========================================');
      _setUpOpenFirebaseMessaging(message);
    });

    debugPrint('🔔 Checking for initial message (app launched from notification)...');
    final initialMessage = await messaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('========================================');
      debugPrint('🔔 **CALLBACK** getInitialMessage - App launched from notification');
      debugPrint('🔔 *** APP WAS CLOSED AND OPENED FROM NOTIFICATION ***');
      debugPrint('🔔 Initial Message Data: ${initialMessage.data}');
      debugPrint('🔔 Calling _setUpOpenFirebaseMessaging from getInitialMessage');
      debugPrint('========================================');
      _setUpOpenFirebaseMessaging(initialMessage);
    } else {
      debugPrint('ℹ️ No initial message - app not launched from notification');
    }
  }

  static Future<void> _setUpOpenFirebaseMessaging(RemoteMessage message) async {
    try {
      debugPrint('========================================');
      debugPrint('🔔 _setUpOpenFirebaseMessaging called');
      debugPrint('🔔 Message Data: ${message.data}');
      debugPrint('🔔 Message Notification: ${message.notification}');
      debugPrint('========================================');

      if (!AppUtils.isLoggedIn()) {
        debugPrint('========================================');
        debugPrint('⚠️ User NOT logged in');
        debugPrint('⚠️ Redirecting to sign in screen...');
        debugPrint('========================================');
        await Future.delayed(Duration(seconds: 1));

        final navigatorState = NavigationService.rootNavigatorKey.currentState;
        debugPrint('🔔 Navigator State: ${navigatorState != null ? "Available" : "NULL - App may not be ready"}');

        if (navigatorState == null) {
          debugPrint('⚠️ WARNING: Navigator not available yet, app may still be initializing');
          return;
        }

        final context = navigatorState.context;
        debugPrint('🔔 Context mounted: ${context.mounted}');

        if (!context.mounted) {
          debugPrint('⚠️ Context not mounted, cannot navigate');
          return;
        }

        context.push(NavigationService.signIn);
        return;
      }

      debugPrint('========================================');
      debugPrint('✅ User is logged in');
      debugPrint('✅ Opening notification detail...');
      debugPrint('========================================');
      openDetail(NotificationModel.fromJson(message.data));
    } catch (e, stackTrace) {
      debugPrint('========================================');
      debugPrint('❌ FirebaseMessaging error: ${e.toString()}');
      debugPrint('❌ Stack trace: $stackTrace');
      debugPrint('========================================');
    }
  }

  static Future<void> deleteToken() async {
    try {
      debugPrint('🔔 Deleting FCM token...');
      await messaging.deleteToken();
      debugPrint('✅ FCM token deleted successfully');
    } catch (e) {
      debugPrint('❌ FirebaseMessaging deleteToken error: ${e.toString()}');
    }
  }

  static Future<void> getFCMToken(Function(String) receiveFcmToken) async {
    debugPrint('🔔 Getting FCM token...');

    messaging.onTokenRefresh.listen((token) async {
      debugPrint('🔔 FCM Token refreshed: $token');
      receiveFcmToken(token);
    });

    if (Platform.isIOS) {
      final apnsToken = await messaging.getAPNSToken();
      if (apnsToken == null) {
        debugPrint('⚠️ FirebaseMessaging: APNs token not found');
        return;
      }
      debugPrint('🔔 APNs Token obtained: $apnsToken');
    }

    try {
      String? token = await messaging.getToken();
      debugPrint('✅ FCM Token obtained: $token');
      receiveFcmToken(token ?? '');
    } catch (e) {
      debugPrint('❌ FirebaseMessaging getFCMToken error: ${e.toString()}');
    }
  }

  static Future<void> openDetail(NotificationModel notification) async {
    debugPrint('========================================');
    debugPrint('🔔 openDetail() called');
    debugPrint('🔔 Notification Type: ${notification.notificationType}');
    debugPrint('🔔 Notification ID: ${notification.id}');
    debugPrint('🔔 Notification Title: ${notification.title}');
    debugPrint('🔔 Notification Content: ${notification.content}');
    debugPrint('🔔 Full Notification JSON: ${notification.toJson()}');
    debugPrint('========================================');

    if (notification.notificationType.isNotiPayment) {
      HandleNotificationUtils.openPayment(notification.keyId);
    }
  }
}
