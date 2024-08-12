import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/OnboardingScreen.dart';
import 'package:harrowsithivinayagar/event_service.dart';
import 'package:harrowsithivinayagar/initialScreen.dart';
import 'package:harrowsithivinayagar/local_notifications.dart';
import 'package:harrowsithivinayagar/loggingService.dart';
import 'package:harrowsithivinayagar/loginScreen.dart';
import 'package:harrowsithivinayagar/mainScreen.dart';
import 'package:harrowsithivinayagar/newRelic.dart';
import 'package:newrelic_mobile/config.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:newrelic_mobile/newrelic_mobile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  await requestExactAlarmPermission();

  try {
    //  initialize firebase
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
    //  initialize local notifications

    tz.initializeTimeZones();
    LocalNotifications.instance.init();
  } catch (e) {
    LoggingService.instance.logError("Error initializing Firebase: $e");
  }
  // initialize new relic
  //Config newRelicConfig = await Newrelic.instance.start();

  runApp(const MyApp());
}

Future<void> _requestPermissions() async {
  var status = await Permission.notification.status;
  if (status.isDenied) {
    await Permission.notification.request();
  }
}

Future<void> requestExactAlarmPermission() async {
  if (await Permission.scheduleExactAlarm.isGranted) {
    print("Exact alarm permission already granted.");
  } else {
    if (await Permission.scheduleExactAlarm.request().isGranted) {
      print("Exact alarm permission granted.");
    } else {
      print("Exact alarm permission denied.");
    }
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
