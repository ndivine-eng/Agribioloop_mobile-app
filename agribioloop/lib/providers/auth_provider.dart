import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(FirebaseAuth.instance.currentUser) {
    _auth.authStateChanges().listen((user) {
      state = user;
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '827326079916-01smpba6v2uj50dg1ssmrvohdeomctug.apps.googleusercontent.com',
    scopes: ['email', 'profile'], 
  );

  // === Google Sign-In ===
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'aborted',
          message: 'Sign in aborted by user',
        );
      }

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      if (googleAuth.idToken == null) {
        throw FirebaseAuthException(
          code: 'missing-id-token',
          message: 'Google Sign-In failed: Missing ID Token',
        );
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      print("Google Sign-In Error: $e");
      rethrow;
    }
  }

  // === Email/Password Sign-In ===
  Future<void> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("Email Sign-In Error: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      print("Unexpected Error: $e");
      rethrow;
    }
  }

  // === Email/Password Registration ===
  Future<void> signUpWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      print("Registration Error: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      print("Unexpected Error: $e");
      rethrow;
    }
  }

  // === Reset Password ===
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("Password Reset Error: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      print("Unexpected Error: $e");
      rethrow;
    }
  }

  // === Sign Out ===
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      state = null;
    } catch (e) {
      print("Sign-Out Error: $e");
      rethrow;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
