import 'package:flutter/material.dart';
import 'package:harrowsithivinayagar/screens/initials/initial_screen.dart';
import 'package:harrowsithivinayagar/screens/login/login_screen.dart';
import 'package:harrowsithivinayagar/screens/onboarding/onboarding_screen.dart';
import 'package:harrowsithivinayagar/screens/tabs/main_screen_tab.dart';

class Routes {
  static final Map<String, WidgetBuilder> routes = {
    '/': (context) => const InitialScreen(),
    '/login': (context) => const LoginScreen(),
    '/main': (context) => const MainScreen(),
    '/onboarding': (context) => const OnboardingScreen(),
    // Add other routes here
  };
}
