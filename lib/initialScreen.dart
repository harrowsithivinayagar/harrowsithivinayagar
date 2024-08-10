import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  Future<bool> _checkOnboardingStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
    return onboardingComplete;
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
          return StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (snapshot.hasData) {
                  Navigator.pushReplacementNamed(context, '/main');
                } else {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              });
              return Container(); // Return an empty container while navigating
            },
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/onboarding');
          });
          return Container(); // Return an empty container while navigating
        }
      },
    );
  }
}
