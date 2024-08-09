import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:harrowsithivinayagar/loginScreen.dart';
import 'package:harrowsithivinayagar/mainScreen.dart';
import 'package:harrowsithivinayagar/onboardingScreen.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  Future<bool> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
    return onboardingComplete;
  }

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = prefs.getBool('loggedIn') ?? false;
    return loggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkOnboardingStatus(),
      builder: (context, onboardingSnapshot) {
        if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (onboardingSnapshot.data == true) {
          return FutureBuilder<bool>(
            future: _checkLoginStatus(),
            builder: (context, loginSnapshot) {
              if (loginSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (loginSnapshot.data == true) {
                return const MainScreen();
              } else {
                return const LoginScreen();
              }
            },
          );
        } else {
          return const OnboardingScreen();
        }
      },
    );
  }
}
