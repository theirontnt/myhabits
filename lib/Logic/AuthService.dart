import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myhabits/main.dart';

/// All methods return error message, or `null` on success
class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  User? get currentUser => auth.currentUser;

  bool get isLoggedIn => auth.currentUser != null;

  Future<String?> signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<String?> createAccount(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      auth.currentUser?.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<String?> updateName(String name) async {
    if (auth.currentUser == null) return "nouser";
    await auth.currentUser!.updateDisplayName(name);
  }

  Future<String?> updatePhotoURL(String photoURL) async {
    if (auth.currentUser == null) return "nouser";
    await auth.currentUser!.updatePhotoURL(photoURL);
  }

  static AuthService of(BuildContext context) => MyHabits.of(context).authService;
}
