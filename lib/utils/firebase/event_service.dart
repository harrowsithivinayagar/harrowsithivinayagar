import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:harrowsithivinayagar/utils/notifications/local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import '../../models/event_model.dart';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var event in _events) {
      final scheduledDate = DateTime(
        event.date.year,
        event.date.month,
        event.date.day,
        8,
        0,
      );
      if (scheduledDate.isAfter(DateTime.now())) {
        String notificationKey = 'notification_${event.uniqueId}';
        bool isScheduled = prefs.getBool(notificationKey) ?? false;

        if (!isScheduled) {
          await LocalNotifications.instance
              .scheduleNotification(event, scheduledDate);
          await prefs.setBool(notificationKey, true);
        }
      }
    }
  }
}
