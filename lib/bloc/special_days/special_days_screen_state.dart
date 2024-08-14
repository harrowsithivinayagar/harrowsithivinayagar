part of 'special_days_screen_bloc.dart';

sealed class SpecialDaysScreenState extends Equatable {
  const SpecialDaysScreenState();

  @override
  List<Object> get props => [];
}

final class SpecialDaysScreenInitial extends SpecialDaysScreenState {
  final DateTime focusedDay;

  SpecialDaysScreenInitial() : focusedDay = DateTime.now();

  @override
  List<Object> get props => [focusedDay];
}

final class SpecialDaysScreenLoading extends SpecialDaysScreenState {}

final class SpecialDaysScreenLoaded extends SpecialDaysScreenState {
  final Map<DateTime, List<Event>> events;
  final List<Event> selectedMonthEvents;
  final DateTime focusedDay;

  const SpecialDaysScreenLoaded(
      this.events, this.selectedMonthEvents, this.focusedDay);

  SpecialDaysScreenLoaded copyWith({
    Map<DateTime, List<Event>>? events,
    List<Event>? selectedMonthEvents,
    DateTime? focusedDay,
  }) {
    return SpecialDaysScreenLoaded(
      events ?? this.events,
      selectedMonthEvents ?? this.selectedMonthEvents,
      focusedDay ?? this.focusedDay,
    );
  }

  @override
  List<Object> get props => [events, selectedMonthEvents, focusedDay];
}

final class SpecialDaysScreenError extends SpecialDaysScreenState {
  final String message;

  const SpecialDaysScreenError(this.message);

  @override
  List<Object> get props => [message];
}
