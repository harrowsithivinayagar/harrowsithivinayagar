import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/analytics_service.dart';
import 'package:harrowsithivinayagar/initialScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Harrowsithi Vinayagar Temple',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const InitialScreen(),
        navigatorObservers: [
          AnalyticsService().getAnalyticsObserver(),
        ]);
  }
}
