import 'package:flutter_riverpod/flutter_riverpod.dart';

// Authentication State (e.g., User is logged in or not)
class AuthState extends StateNotifier<bool> {
  AuthState() : super(false); // Default: User is NOT logged in

  void login() {
    state = true; // Mark user as logged in
  }

  void logout() {
    state = false; // Mark user as logged out
  }
}

// Riverpod Provider for Authentication
final authProvider = StateNotifierProvider<AuthState, bool>((ref) => AuthState());
