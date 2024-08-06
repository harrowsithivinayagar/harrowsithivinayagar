import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/OnboardingScreen.dart';
import 'package:harrowsithivinayagar/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  Future<bool> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingComplete') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkOnboardingStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data == true) {
          return const MainScreen();
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
