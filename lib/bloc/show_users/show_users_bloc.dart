import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/show_users/show_users_event.dart';
import 'package:harrowsithivinayagar/bloc/show_users/show_users_state.dart';
import 'package:harrowsithivinayagar/models/user_model.dart';
import 'package:harrowsithivinayagar/repository/show_users/show_users_repository.dart';

class ShowUsersBloc extends Bloc<ShowUsersEvent, ShowUsersState> {
  final UserRepository userRepository;

  ShowUsersBloc(this.userRepository) : super(ShowUsersInitial()) {
    on<FetchUsersByRole>(_onFetchUsersByRole);
    on<UpdateUserRole>(_onUpdateUserRole);
  }

  Future<void> _onFetchUsersByRole(
      FetchUsersByRole event, Emitter<ShowUsersState> emit) async {
    emit(ShowUsersLoading());

    try {
      final usersStream = userRepository.getUsersByRole(event.role);

      await emit.forEach<List<UserModel>>(
        usersStream,
        onData: (users) => ShowUsersLoaded(users),
        onError: (error, _) => ShowUsersError('Failed to load users: $error'),
      );
    } catch (e) {
      emit(ShowUsersError(e.toString()));
    }
  }

  Future<void> _onUpdateUserRole(
      UpdateUserRole event, Emitter<ShowUsersState> emit) async {
    try {
      await userRepository.updateUserRole(event.userId, event.newRole);
      emit(ShowUserRoleUpdated(event.newRole));
    } catch (e) {
      emit(ShowUsersError('Failed to update role: $e'));
    }
  }
}
