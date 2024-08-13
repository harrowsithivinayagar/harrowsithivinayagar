import 'package:equatable/equatable.dart';

abstract class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object> get props => [];
}

class MainScreenInitial extends MainScreenState {}

class MainScreenLoading extends MainScreenState {}

class MainScreenLoaded extends MainScreenState {
  final String role;

  const MainScreenLoaded(this.role);

  @override
  List<Object> get props => [role];
}

class MainScreenUpdateRequired extends MainScreenState {}

class MainScreenError extends MainScreenState {
  final String message;

  const MainScreenError(this.message);

  @override
  List<Object> get props => [message];
}
