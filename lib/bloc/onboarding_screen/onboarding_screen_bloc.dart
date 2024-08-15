import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_screen_event.dart';
import 'onboarding_screen_state.dart';

class OnboardingScreenBloc
    extends Bloc<OnboardingScreenEvent, OnboardingScreenState> {
  OnboardingScreenBloc() : super(const OnboardingScreenInitial()) {
    on<PageChangedEvent>(_onPageChanged);
    on<CompleteOnboardingEvent>(_onCompleteOnboarding);
  }

  void _onPageChanged(
      PageChangedEvent event, Emitter<OnboardingScreenState> emit) {
    emit(OnboardingScreenPageChanged(isLastPage: event.isLastPage));
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboardingEvent event,
    Emitter<OnboardingScreenState> emit,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingComplete', true);
    emit(const OnboardingScreenComplete());
  }
}
