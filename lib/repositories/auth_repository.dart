
import 'package:cross/repositories/database.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

@immutable
class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future<UserCredential?> signInWithGoogle() async {
    // Trigger the Google sign in flow
    final googleUser = await _googleSignIn.signIn();
    // Check if user cancelled sign in
    if (googleUser == null) return null;

    // Get Google authentication credentials
    final googleAuth = await googleUser.authentication;

    // Convert Google credentials to Firebase credentials
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with Google credentials
    return await _auth.signInWithCredential(credential);
  }
  Future<void> singout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future sendNewActor(String name, String description, String url) async {
  DatabaseService databaseService = DatabaseService();
  databaseService.addActor(name, description, url);
}

Future sendNewStuff(String name, String description, String url) async {
  DatabaseService databaseService = DatabaseService();
  databaseService.addStuff(name, description, url);
}

Future sendNewNews(String name, String description, String url) async {
  DatabaseService databaseService = DatabaseService();
  databaseService.addNews(name, description, url);
}
}
