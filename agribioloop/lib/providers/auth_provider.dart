import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthNotifier extends StateNotifier<User?> {
  AuthNotifier() : super(FirebaseAuth.instance.currentUser) {
    _auth.authStateChanges().listen((user) {
      state = user;
      if (user != null) {
        _fetchUserData(user.uid); // Fetch user data on login
      }
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '827326079916-01smpba6v2uj50dg1ssmrvohdeomctug.apps.googleusercontent.com',
    scopes: ['email', 'profile'], 
  );

  Map<String, dynamic>? _userData; // Store user data from Firestore

  // Getter to access user data
  Map<String, dynamic>? get userData => _userData;

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

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        await _saveUserToFirestore(user.uid, user.displayName ?? "Unknown", user.email!, user.photoURL ?? '');
      }
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _fetchUserData(userCredential.user!.uid); // Fetch user data
    } on FirebaseAuthException catch (e) {
      print("Email Sign-In Error: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      print("Unexpected Error: $e");
      rethrow;
    }
  }

  // === Email/Password Registration ===
  Future<void> signUpWithEmail(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;
      await _saveUserToFirestore(uid, name, email, '');
    } on FirebaseAuthException catch (e) {
      print("Registration Error: ${e.code} - ${e.message}");
      rethrow;
    } catch (e) {
      print("Unexpected Error: $e");
      rethrow;
    }
  }

  // === Save User Data in Firestore ===
  Future<void> _saveUserToFirestore(String uid, String name, String email, String profilePicture) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
    });

    _userData = {
      'name': name,
      'email': email,
      'profilePicture': profilePicture,
    };

    state = _auth.currentUser;
  }

  // === Fetch User Data from Firestore ===
  Future<void> _fetchUserData(String uid) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    
    if (userDoc.exists) {
      _userData = {
        'name': userDoc['name'],
        'email': userDoc['email'],
        'profilePicture': userDoc['profilePicture'],
      };
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
      _userData = null;
    } catch (e) {
      print("Sign-Out Error: $e");
      rethrow;
    }
  }
}

// Provider for authentication state
final authProvider = StateNotifierProvider<AuthNotifier, User?>((ref) {
  return AuthNotifier();
});
