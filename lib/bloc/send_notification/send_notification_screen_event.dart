part of 'send_notification_screen_bloc.dart';

sealed class SendNotificationScreenEvent extends Equatable {
  const SendNotificationScreenEvent();

  @override
  List<Object> get props => [];
}

class SendNotificationAction extends SendNotificationScreenEvent {
  final String title;
  final String message;

  const SendNotificationAction(this.title, this.message);

  @override
  List<Object> get props => [title, message];
}
