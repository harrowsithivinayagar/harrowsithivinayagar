// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../utils/firebase/event_service.dart';
import '../../models/event_model.dart';

class SpecialDaysTab extends StatefulWidget {
  const SpecialDaysTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpecialDaysTabState createState() => _SpecialDaysTabState();
}

class _SpecialDaysTabState extends State<SpecialDaysTab> {
  late Map<DateTime, List<Event>> _events;
  late List<Event> _selectedMonthEvents;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _events = {};
    _selectedMonthEvents = [];
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    await EventService().loadEvents();
    setState(() {
      for (var event in EventService().events) {
        final date = event.date;
        if (_events[date] == null) {
          _events[date] = [];
        }
        _events[date]!.add(event);
      }
      _selectedMonthEvents = _getEventsForMonth(_focusedDay);
    });
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  List<Event> _getEventsForMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    List<Event> monthEvents = [];
    for (var date = firstDayOfMonth;
        date.isBefore(lastDayOfMonth);
        date = date.add(const Duration(days: 1))) {
      if (_events[date] != null) {
        monthEvents.addAll(_events[date]!);
      }
    }
    return monthEvents;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          availableCalendarFormats: const {CalendarFormat.month: 'Month'},
          startingDayOfWeek: StartingDayOfWeek.monday,
          onPageChanged: (focusedDay) {
            setState(() {
              _focusedDay = focusedDay;
              _selectedMonthEvents = _getEventsForMonth(focusedDay);
            });
          },
          headerStyle: const HeaderStyle(
            titleCentered: true,
            formatButtonVisible: false,
            leftChevronIcon: Icon(Icons.arrow_back, color: Colors.orange),
            rightChevronIcon: Icon(Icons.arrow_forward, color: Colors.orange),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, date, events) {
              if (events.isNotEmpty) {
                return Positioned(
                  right: 1,
                  bottom: 1,
                  child: _buildEventsMarker(date, events),
                );
              }
              return null;
            },
            defaultBuilder: (context, date, _) {
              final cleanDate = DateTime(date.year, date.month, date.day);
              if (_events.containsKey(cleanDate)) {
                return Container(
                  margin: const EdgeInsets.all(6.0),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${date.day}',
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }
              return null;
            },
          ),
          eventLoader: _getEventsForDay,
        ),
        const SizedBox(height: 8.0),
        Expanded(
          child: ListView.builder(
            itemCount: _selectedMonthEvents.length,
            itemBuilder: (context, index) {
              final event = _selectedMonthEvents[index];
              return ListTile(
                title: Text(event.event),
                subtitle: Text(
                    '${event.date.day}-${event.date.month}-${event.date.year} - ${event.day}'),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEventsMarker(DateTime date, List<dynamic> events) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: const TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
