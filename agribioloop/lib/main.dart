import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './providers/auth_provider.dart';

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

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
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriBioLoop',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF4CAF50), // Green color for light mode
        scaffoldBackgroundColor: Colors.white, // Light background for light mode
        cardColor: Color(0xFF81C784), // Lighter green for cards
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Color(0xFF1B5E20), // Deep Green color for dark mode
        scaffoldBackgroundColor: Color(0xFF263238), // Softer dark background (like dark teal)
        cardColor: Color(0xFF388E3C), // Lighter green for cards
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // White text for better contrast
        ),
        iconTheme: IconThemeData(color: Colors.white), // White icons
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFF66BB6A), // Light green buttons (adds warmth)
        ),
        shadowColor: Colors.black.withOpacity(0.3), // Softer shadows for a more pleasant feel
      ),
      themeMode: themeMode, // Use the current theme mode (light or dark)
      home: SplashScreen(),
    );
  }
}
