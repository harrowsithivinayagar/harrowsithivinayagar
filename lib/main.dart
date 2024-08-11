import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:harrowsithivinayagar/OnboardingScreen.dart';
import 'package:harrowsithivinayagar/initialScreen.dart';
import 'package:harrowsithivinayagar/loggingService.dart';
import 'package:harrowsithivinayagar/loginScreen.dart';
import 'package:harrowsithivinayagar/mainScreen.dart';
import 'package:newrelic_mobile/config.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:newrelic_mobile/newrelic_mobile.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  try {
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        // Handle your logic here when a notification is received while the app is in the foreground
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        // Handle notification tapped logic here
      },
    );
  } catch (e) {
    LoggingService.instance.logError("Error initializing Firebase: $e");
  }
  var appToken = "";
  if (Platform.isIOS) {
    appToken = 'eu01xxcf835f59c648a12ed79f1289fe58f1b499af-NRMA';
  } else if (Platform.isAndroid) {
    appToken = 'eu01xx688f84454c5ba2f4aaf05b0035222c73f3ca-NRMA';
  }
  Config config = Config(
      accessToken: appToken,
      analyticsEventEnabled: true,
      webViewInstrumentation: true,
      networkErrorRequestEnabled: true,
      networkRequestEnabled: true,
      crashReportingEnabled: true,
      interactionTracingEnabled: true,
      httpResponseBodyCaptureEnabled: true,
      loggingEnabled: true,
      printStatementAsEventsEnabled: true,
      httpInstrumentationEnabled: true);

  NewrelicMobile.instance.start(config, () {
    runApp(const MyApp());
  });
}

Future<void> _requestPermissions() async {
  var status = await Permission.notification.status;
  if (status.isDenied) {
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harrowsithi Vinayagar Temple',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white, // Change this to your desired color
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>
            const InitialScreen(), // Change this to your initial screen
        '/login': (context) => const LoginScreen(),
        '/main': (context) => const MainScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        // Add other routes here
      },
    );
  }
}
