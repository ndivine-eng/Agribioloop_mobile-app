import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import this
import 'providers/auth_provider.dart';
import 'screens/main_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider); // User? type

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriBioLoop',
      theme: ThemeData(primarySwatch: Colors.green),
      home: user == null
          ? SignInScreen()  // If user is null, show Sign-In screen
          : MainScreen(),   // If user is logged in, show Main Screen
    );
  }
}
