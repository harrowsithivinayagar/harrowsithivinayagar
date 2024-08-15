import 'package:equatable/equatable.dart';
import 'package:harrowsithivinayagar/models/user_model.dart';

abstract class ShowUsersState extends Equatable {
  const ShowUsersState();

  @override
  List<Object> get props => [];
}

class ShowUsersInitial extends ShowUsersState {}

class ShowUsersLoading extends ShowUsersState {}

class ShowUsersLoaded extends ShowUsersState {
  final List<UserModel> users;

  const ShowUsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

class ShowUserRoleUpdated extends ShowUsersState {
  final String newRole;

  const ShowUserRoleUpdated(this.newRole);

  @override
  List<Object> get props => [newRole];
}

class ShowUsersError extends ShowUsersState {
  final String error;

  const ShowUsersError(this.error);

  @override
  List<Object> get props => [error];
}
