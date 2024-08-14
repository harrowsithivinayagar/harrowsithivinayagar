import 'package:harrowsithivinayagar/models/event_model.dart';
import 'package:harrowsithivinayagar/utils/firebase/event_service.dart';

class SpecialDaysrepository {
  final EventService eventService = EventService();

  Future<Map<DateTime, List<Event>>> loadEvents() async {
    Map<DateTime, List<Event>> events = {};

    await eventService.loadEvents();
    for (var event in eventService.events) {
      final date = event.date;
      if (events[date] == null) {
        events[date] = [];
      }
      events[date]!.add(event);
    }
    return events;
  }
}
