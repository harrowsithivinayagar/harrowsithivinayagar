// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:harrowsithivinayagar/repository/login/login_repository.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc(this.loginRepository) : super(LoginInitial()) {
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      User? user = await loginRepository.signInWithGoogle();
      if (user != null) {
        await loginRepository.setLoggedIn(true);
        String role = await loginRepository.getUserRole(user.uid);
        await loginRepository.saveUserRole(user.uid, role);

        emit(LoginSuccess());
      } else {
        emit(LoginFailure("Google Sign-In failed"));
      }
    } catch (e) {
      emit(LoginFailure("Error during Google Sign-In: $e"));
    }
  }
}
