import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/initial/initial_screen_event.dart';
import 'package:harrowsithivinayagar/bloc/initial/initial_screen_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreenBloc extends Bloc<InitialScreenEvent, InitialScreenState> {
  InitialScreenBloc() : super(InitialScreenInitial()) {
    on<CheckInitialScreen>(_onCheckInitialScreen);
  }

  Future<void> _onCheckInitialScreen(
    CheckInitialScreen event,
    Emitter<InitialScreenState> emit,
  ) async {
    emit(InitialScreenLoading());

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
      bool isLoggedIn = FirebaseAuth.instance.currentUser != null;

      emit(InitialScreenLoaded(
        onboardingComplete: onboardingComplete,
        isLoggedIn: isLoggedIn,
      ));
    } catch (e) {
      emit(InitialScreenError('Error checking initial screen: $e'));
    }
  }
}
