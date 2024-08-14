import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/models/event_model.dart';
import 'package:harrowsithivinayagar/repository/special_days/special_days_repository.dart';

part 'special_days_screen_event.dart';
part 'special_days_screen_state.dart';

class SpecialDaysScreenBloc
    extends Bloc<SpecialDaysScreenEvent, SpecialDaysScreenState> {
  final SpecialDaysrepository eventRepository = SpecialDaysrepository();
  SpecialDaysScreenBloc(specialDaysrepository)
      : super(SpecialDaysScreenInitial()) {
    on<InitializeSpecialDaysScreen>(onInitializeEvent);
    on<ChangeFocusDayEvent>(onchangeFoucsDate);
  }

  Future<void> onInitializeEvent(InitializeSpecialDaysScreen event,
      Emitter<SpecialDaysScreenState> emit) async {
    emit(SpecialDaysScreenLoading());
    try {
      final events = await eventRepository.loadEvents();
      final selectedMonthEvents = getEventsForMonth(DateTime.now(), events);
      emit(
          SpecialDaysScreenLoaded(events, selectedMonthEvents, DateTime.now()));
    } catch (e) {
      emit(SpecialDaysScreenError(e.toString()));
    }
  }

  Future<void> onchangeFoucsDate(
      ChangeFocusDayEvent event, Emitter<SpecialDaysScreenState> emit) async {
    try {
      final currentState = state as SpecialDaysScreenLoaded;
      final selectedMonthEvents =
          getEventsForMonth(event.focusDay, currentState.events);
      emit(currentState.copyWith(
          selectedMonthEvents: selectedMonthEvents,
          focusedDay: event.focusDay));
    } catch (e) {
      emit(SpecialDaysScreenError(e.toString()));
    }
  }

  List<Event> getEventsForMonth(
      DateTime month, Map<DateTime, List<Event>> events) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    List<Event> monthEvents = [];
    for (var date = firstDayOfMonth;
        date.isBefore(lastDayOfMonth);
        date = date.add(const Duration(days: 1))) {
      if (events[date] != null) {
        monthEvents.addAll(events[date]!);
      }
    }
    return monthEvents;
  }
}
