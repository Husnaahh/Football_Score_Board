import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:football_scoreboared/service/simple_fcm.dart';
import 'package:provider/provider.dart';

import ' view/home/widget/main_screen.dart';
import 'controller/league_controller.dart';
import 'controller/main_screen_controller.dart';
import 'controller/notification_controller.dart';
import 'controller/today_controller.dart';
import 'controller/upcoming_controller.dart';
import 'controller/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await SimpleFCM.init();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => MainScreenController()),
        ChangeNotifierProvider(create: (_) => TodayController()),
        ChangeNotifierProvider(create: (_) => UpcomingController()),
        ChangeNotifierProvider(create: (_) => LeagueController()),
        ChangeNotifierProvider(create: (_) => NotificationController()),
      ],
      child: MyApp(),
    ),
  );
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (message.notification != null) {
    await SimpleFCM.showMatchNotification(
      teamA: message.notification!.title ?? '',
      teamB: message.notification!.body ?? '',
      time: '',
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MainScreen());
  }
}