import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harrowsithivinayagar/bloc/initial/initial_screen_bloc.dart';
import 'package:harrowsithivinayagar/bloc/initial/initial_screen_event.dart';
import 'package:harrowsithivinayagar/bloc/initial/initial_screen_state.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitialScreenBloc()..add(CheckInitialScreen()),
      child: Scaffold(
        body: Center(
          child: BlocConsumer<InitialScreenBloc, InitialScreenState>(
            listener: (context, state) {
              if (state is InitialScreenLoaded) {
                if (state.onboardingComplete) {
                  if (state.isLoggedIn) {
                    Navigator.pushReplacementNamed(context, '/main');
                  } else {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                } else {
                  Navigator.pushReplacementNamed(context, '/onboarding');
                }
              } else if (state is InitialScreenError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is InitialScreenLoading) {
                return const CircularProgressIndicator();
              }
              return Container(); // Return an empty container while navigating
            },
          ),
        ),
      ),
    );
  }
}
