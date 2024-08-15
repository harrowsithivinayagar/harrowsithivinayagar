import 'package:equatable/equatable.dart';

abstract class OnboardingScreenState extends Equatable {
  const OnboardingScreenState();

  @override
  List<Object> get props => [];
}

class OnboardingScreenInitial extends OnboardingScreenState {
  const OnboardingScreenInitial();
}

class OnboardingScreenPageChanged extends OnboardingScreenState {
  final bool isLastPage;

  const OnboardingScreenPageChanged({required this.isLastPage});

  @override
  List<Object> get props => [isLastPage];
}

class OnboardingScreenComplete extends OnboardingScreenState {
  const OnboardingScreenComplete();
}
