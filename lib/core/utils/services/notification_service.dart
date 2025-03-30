import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flnp =
      FlutterLocalNotificationsPlugin();

  // サービスの初期化
  Future<void> initialize() async {
    // バックグラウンドでのメッセージ受信イベントを設定
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // FCMトークンの取得と表示
    await _setupFCMToken();

    // フォアグラウンドでのメッセージ受信イベントを設定
    _setupForegroundMessageListener();

    // 通知の許可をリクエスト
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // FCMトークンの取得
  Future<void> _setupFCMToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    String? token = await firebaseMessaging.getToken();
    if (kDebugMode) {
      print('FCM Token: $token');
    }
  }

  // フォアグラウンドでのメッセージリスナー設定
  void _setupForegroundMessageListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _handleMessage(message);
    });
  }

  // メッセージ処理（フォアグラウンドとバックグラウンド共通のロジック）
  Future<void> _handleMessage(RemoteMessage message) async {
    // 通知の初期化
    RemoteNotification? notification = message.notification;
    await flnp.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    if (notification == null) return;

    // 通知の表示
    await flnp.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'your_channel_id',
          'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
        ),
        iOS: const DarwinNotificationDetails(),
      ),
    );
  }
}

// バックグラウンドでメッセージを受け取った時のイベント
// これはトップレベル関数である必要があります
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService()._handleMessage(message);
}
