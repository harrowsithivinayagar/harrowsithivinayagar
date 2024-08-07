import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;
import 'event_model.dart';
import 'main.dart';

class EventService {
  static final EventService _instance = EventService._internal();

  factory EventService() {
    return _instance;
  }

  EventService._internal();

  List<Event> _events = [];

  Future<void> loadEvents() async {
    if (_events.isEmpty) {
      final String response =
          await rootBundle.loadString('assets/special_days.json');
      final List<dynamic> data = json.decode(response);
      _events = data.map((json) => Event.fromJson(json)).toList();
    }
  }

  List<Event> get events => _events;

  Future<void> scheduleNotifications() async {
    for (var event in _events) {
      final scheduledDate = DateTime(
        event.date.year,
        event.date.month,
        event.date.day,
        8,
        0,
      );
      if (scheduledDate.isAfter(DateTime.now())) {
        await _scheduleNotification(event, scheduledDate);
      }
    }
  }

  Future<void> _scheduleNotification(
      Event event, DateTime scheduledDate) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'event_channel_id',
      'Event Notifications',
      channelDescription: 'Notifications for upcoming events',
      importance: Importance.max,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(
      scheduledDate,
      tz.local,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      event.hashCode,
      'Upcoming Event',
      '${event.event} is today!',
      tzScheduledDate,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
