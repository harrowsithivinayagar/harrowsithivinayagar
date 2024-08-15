import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/repository/send_notification/send_notification_repository.dart';

part 'send_notification_screen_event.dart';
part 'send_notification_screen_state.dart';

class SendNotificationScreenBloc
    extends Bloc<SendNotificationScreenEvent, SendNotificationScreenState> {
  final SendNotificationRepository repository;

  SendNotificationScreenBloc(this.repository)
      : super(SendNotificationScreenInitial()) {
    on<SendNotificationAction>(onSendNotification);
  }

  Future<void> onSendNotification(SendNotificationAction event,
      Emitter<SendNotificationScreenState> emit) async {
    emit(SendNotificationScreenLoading());

    try {
      final result =
          await repository.sendNotification(event.title, event.message);

      result.when(
        success: (message) {
          emit(SendNotificationScreenSuccess(message));
        },
        failure: (message) {
          emit(SendNotificationScreenError(message));
        },
      );
    } catch (e) {
      emit(SendNotificationScreenError(e.toString()));
    }
  }
}
