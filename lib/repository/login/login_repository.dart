import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      if (userCredential.user != null) {
        String? fcmToken = await _firebaseMessaging.getToken();

        DocumentReference userDocRef =
            _firestore.collection('users').doc(userCredential.user!.uid);
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

        return userCredential.user;
      }
    }
    return null;
  }

  Future<void> saveUserRole(String uid, String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
  }

  Future<void> setLoggedIn(bool loggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', loggedIn);
  }

  Future<String> getUserRole(String uid) async {
    DocumentReference userDocRef = _firestore.collection('users').doc(uid);
    DocumentSnapshot userDoc = await userDocRef.get();
    return userDoc.get('role');
  }

  Future<void> signoutUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await FirebaseAuth.instance.signOut();
    await prefs.remove('role');
  }
}
