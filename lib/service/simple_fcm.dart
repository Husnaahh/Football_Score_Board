import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class SimpleFCM {
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    //  Timezone init
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    //  Permission
    await _fcm.requestPermission(alert: true, badge: true, sound: true);

    //  Token
    String? token = await _fcm.getToken();
    print('FCM Token: $token');

    //  Local notification init
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidInit);

    await _localNotifications.initialize(settings: initSettings);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
    //  ANDROID NOTIFICATION CHANNEL (MISSING PART)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'fcm_channel',
      'FCM Notifications',
      description: 'This channel is used for FCM',
      importance: Importance.high,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
    >()
        ?.createNotificationChannel(channel);

    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        _showInstantNotification(
          message.notification!.title ?? '',
          message.notification!.body ?? '',
        );
      }
    });

    // Topic subscribe
    await _fcm.subscribeToTopic('all_matches');
  }

  static Future<void> showMatchNotification({
    required String teamA,
    required String teamB,
    required String time,
  }) async {
    await _showInstantNotification(
      'Today Match Added',
      '$teamA vs $teamB at $time',
    );
  }

  static Future<void> scheduleMatchNotification({
    required String teamA,
    required String teamB,
    required DateTime matchTime,
  }) async {
    await _localNotifications.zonedSchedule(
      id: matchTime.millisecondsSinceEpoch ~/ 1000,
      title: ' Match Reminder',
      body: '$teamA vs $teamB is starting now!',
      scheduledDate: tz.TZDateTime.from(matchTime, tz.local),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'fcm_channel',
          'FCM Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  //  INTERNAL method
  static Future<void> _showInstantNotification(
      String title,
      String body,
      ) async {
    const androidDetails = AndroidNotificationDetails(
      'fcm_channel',
      'FCM Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }
}