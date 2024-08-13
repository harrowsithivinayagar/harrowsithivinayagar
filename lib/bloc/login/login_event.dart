part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class GoogleSignInRequested extends LoginEvent {}
