import 'dart:convert';
import 'package:flutter/services.dart';
import 'event_model.dart';

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
}
