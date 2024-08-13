import 'package:equatable/equatable.dart';

abstract class InitialScreenEvent extends Equatable {
  const InitialScreenEvent();

  @override
  List<Object> get props => [];
}

class CheckInitialScreen extends InitialScreenEvent {}
