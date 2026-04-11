import 'package:brew_crew/models/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  // firebase auth instance
  FirebaseAuth get _auth => FirebaseAuth.instance;
  String? _lastAuthError;

  String? get lastAuthError => _lastAuthError;

  // create user from uid
  UserModel? _userWithFirebaseUserUid(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // create a stream of user auth changes
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userWithFirebaseUserUid);
  }

  // Sign in anonymous
  Future signinanonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign out
  Future signout() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Register using email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  //Sign In using email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Sign in with Google
  Future<UserModel?> signInWithGoogle() async {
    _lastAuthError = null;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(
        serverClientId:
            '707934860412-avrjpdfl5bup9j6cujd7082i9tjab4ef.apps.googleusercontent.com',
      );

      // Trigger Google sign-in flow (v7 API)
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      // Get tokens from Google account
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      if (googleAuth.idToken == null) {
        return null;
      }

      // Firebase accepts idToken for Google auth on mobile
      final OAuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      return _userWithFirebaseUserUid(user);
    } on GoogleSignInException catch (error) {
      _lastAuthError = error.description ?? 'Google sign-in was cancelled.';
      debugPrint('Google sign-in failed (${error.code}): ${error.description}');
      return null;
    } on FirebaseAuthException catch (error) {
      _lastAuthError = error.message ?? 'Firebase authentication failed.';
      debugPrint('Firebase auth failed (${error.code}): ${error.message}');
      return null;
    } catch (error) {
      _lastAuthError = 'Unexpected error during Google sign-in.';
      debugPrint('Unexpected Google sign-in error: $error');
      return null;
    }
  }
}
