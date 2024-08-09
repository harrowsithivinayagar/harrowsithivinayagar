import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:harrowsithivinayagar/loggingService.dart';
import 'package:harrowsithivinayagar/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        if (userCredential.user != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('loggedIn', true);

          String? fcmToken = await _firebaseMessaging.getToken();

          DocumentReference userDocRef = FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user!.uid);
          DocumentSnapshot userDoc = await userDocRef.get();

          if (!userDoc.exists) {
            await userDocRef.set({
              'email': userCredential.user!.email,
              'role': "user",
              'token': fcmToken,
            });
          } else {
            await userDocRef.update({'token': fcmToken});
          }

          String role = userDoc.exists
              ? userDoc.get('role')
              : (await userDocRef.get()).get('role');

          await prefs.setString('role', role);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        } else {
          LoggingService.instance.logError("Firebase Authentication failed.");
        }
      } else {
        LoggingService.instance.logError("Google Sign-In cancelled by user.");
      }
    } catch (e) {
      LoggingService.instance.logError("Error during Google Sign-In: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/ganesha.png',
                height: 200.0,
                width: 200.0,
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: _signInWithGoogle,
                child: const Text('Sign in with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
