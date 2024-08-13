import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/initial/initial_screen_bloc.dart';
import 'package:harrowsithivinayagar/bloc/login/login_bloc.dart';
import 'package:harrowsithivinayagar/bloc/main/main_screen_bloc.dart';
import 'package:harrowsithivinayagar/repository/login/login_repository.dart';
import 'package:harrowsithivinayagar/routes/routes.dart';
import 'package:harrowsithivinayagar/utils/logging/logging_service.dart';
import 'package:harrowsithivinayagar/utils/notifications/local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _requestPermissions();
  await requestExactAlarmPermission();

  try {
    await Firebase.initializeApp();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
    if (kDebugMode) {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    }
    tz.initializeTimeZones();
    LocalNotifications.instance.init();
  } catch (e) {
    LoggingService.instance.logError("Error initializing Firebase: $e");
  }

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
    final authRepository = LoginRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainScreenBloc(),
        ),
        BlocProvider(
          create: (context) => InitialScreenBloc(),
        ),
        BlocProvider(
          create: (context) => LoginBloc(authRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Harrowsithi Vinayagar Temple',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        initialRoute: '/',
        routes: Routes.routes,
      ),
    );
  }
}
