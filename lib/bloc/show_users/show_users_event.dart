import 'package:equatable/equatable.dart';

abstract class ShowUsersEvent extends Equatable {
  const ShowUsersEvent();

  @override
  List<Object> get props => [];
}

class FetchUsersByRole extends ShowUsersEvent {
  final String role;

  const FetchUsersByRole(this.role);

  @override
  List<Object> get props => [role];
}

class UpdateUserRole extends ShowUsersEvent {
  final String userId;
  final String newRole;

  const UpdateUserRole(this.userId, this.newRole);

  @override
  List<Object> get props => [userId, newRole];
}
