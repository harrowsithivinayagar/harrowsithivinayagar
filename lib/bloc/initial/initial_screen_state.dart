import 'package:equatable/equatable.dart';

abstract class InitialScreenState extends Equatable {
  const InitialScreenState();

  @override
  List<Object> get props => [];
}

class InitialScreenInitial extends InitialScreenState {}

class InitialScreenLoading extends InitialScreenState {}

class InitialScreenLoaded extends InitialScreenState {
  final bool onboardingComplete;
  final bool isLoggedIn;

  const InitialScreenLoaded({
    required this.onboardingComplete,
    required this.isLoggedIn,
  });

  @override
  List<Object> get props => [onboardingComplete, isLoggedIn];
}

class InitialScreenError extends InitialScreenState {
  final String message;

  const InitialScreenError(this.message);

  @override
  List<Object> get props => [message];
}
