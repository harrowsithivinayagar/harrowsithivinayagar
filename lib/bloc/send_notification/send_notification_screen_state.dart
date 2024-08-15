part of 'send_notification_screen_bloc.dart';

sealed class SendNotificationScreenState extends Equatable {
  const SendNotificationScreenState();

  @override
  List<Object> get props => [];
}

final class SendNotificationScreenInitial extends SendNotificationScreenState {}

final class SendNotificationScreenLoading extends SendNotificationScreenState {}

final class SendNotificationScreenSuccess extends SendNotificationScreenState {
  final String message;

  const SendNotificationScreenSuccess(this.message);

  @override
  List<Object> get props => [message];
}

final class SendNotificationScreenError extends SendNotificationScreenState {
  final String message;

  const SendNotificationScreenError(this.message);

  @override
  List<Object> get props => [message];
}
