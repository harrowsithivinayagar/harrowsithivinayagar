import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:harrowsithivinayagar/models/event_model.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final LocalNotifications _instance = LocalNotifications._internal();
  static LocalNotifications get instance => _instance;
  NotificationDetails? notificationDetails;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  factory LocalNotifications() {
    return _instance;
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  LocalNotifications._internal()
      : flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> scheduleNotification(Event event, DateTime time) async {
    tz.TZDateTime tzTestDate = tz.TZDateTime.from(time, tz.local);

    try {
      await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Upcoming Event',
        '${event.event} is today!',
        tzTestDate,
        notificationDetails!,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    } catch (e) {}
  }

  Future<void> init() async {
    print("scheduleNotificationInOneMinute - init");
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    requestIOSPermissions();

    final DarwinInitializationSettings iosNotificationSettings =
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
            iOS: iosNotificationSettings);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        print('Notification tapped: ${response.toString()}');
      },
    );

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "channelId",
      "thecodexhub",
      channelDescription:
          "This channel is responsible for all the local notifications",
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );

    const DarwinNotificationDetails iOSNotificationDetails =
        DarwinNotificationDetails();

    notificationDetails = const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iOSNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.show(
        0, 'plain title 1', 'plain body 1', notificationDetails,
        payload: 'item x');
  }

  Future<void> showNotification() async {
    await flutterLocalNotificationsPlugin.show(0, '1', '1', notificationDetails,
        payload: 'item x');
  }

  Future<void> scheduleNotificationInOneMinute() async {
    final DateTime now = DateTime.now();
    final DateTime oneMinuteFromNow = now.add(const Duration(minutes: 1));
    final Event event = Event(
      date: oneMinuteFromNow,
      event: 'Test Event',
      day: 'Today',
    );

    await scheduleNotification(event, oneMinuteFromNow);
  }

  static get onDidReceiveLocalNotification => null;
}
