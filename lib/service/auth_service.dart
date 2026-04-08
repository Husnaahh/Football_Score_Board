import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../ view/splash/auth_wrapper.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> registerEmail(
      String name,
      String email,
      String password,
      ) async {
    try {
      UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();

      Fluttertoast.showToast(msg: "Registration Successful ✅");

      return auth.currentUser;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "Registration Failed ❌");
      return null;
    }
  }

  // 🔐 Login with Email
  Future<User?> loginEmail(String email, String password) async {
    try {
      UserCredential userCredential =
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(msg: "Login Successful ✅");

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message ?? "Login Failed ❌");
      return null;
    }
  }

  // 🔐 Google Sign-In
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser =
      await _googleSignIn.signIn();

      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await auth.signInWithCredential(credential);

      Fluttertoast.showToast(msg: "Google Sign-In Successful ✅");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const AuthWrapper(),
        ),
      );

      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      Fluttertoast.showToast(msg: "Google Sign-In Failed ❌");
      return null;
    }
  }

  Future<void> logout() async {
    await _googleSignIn.signOut();
    await auth.signOut();
    Fluttertoast.showToast(msg: "Logged Out 👋");
  }
}