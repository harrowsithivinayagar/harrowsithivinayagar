part of 'special_days_screen_bloc.dart';

sealed class SpecialDaysScreenEvent extends Equatable {
  const SpecialDaysScreenEvent();

  @override
  List<Object> get props => [];
}

class InitializeSpecialDaysScreen extends SpecialDaysScreenEvent {}

class ChangeFocusDayEvent extends SpecialDaysScreenEvent {
  final DateTime focusDay;

  const ChangeFocusDayEvent(this.focusDay);

  @override
  List<Object> get props => [focusDay];
}
