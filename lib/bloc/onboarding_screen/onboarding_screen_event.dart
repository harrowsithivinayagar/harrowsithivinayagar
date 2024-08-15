import 'package:equatable/equatable.dart';

abstract class OnboardingScreenEvent extends Equatable {
  const OnboardingScreenEvent();

  @override
  List<Object> get props => [];
}

class PageChangedEvent extends OnboardingScreenEvent {
  final bool isLastPage;

  const PageChangedEvent({required this.isLastPage});

  @override
  List<Object> get props => [isLastPage];
}

class CompleteOnboardingEvent extends OnboardingScreenEvent {}
