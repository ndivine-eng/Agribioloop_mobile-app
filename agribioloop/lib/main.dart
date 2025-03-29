import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/splash_screen.dart';
import 'screens/theme_selection_screen.dart'; 

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

void main() {
  runApp(ProviderScope(child: MyApp())); // Wrap app with ProviderScope
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgriBioLoop',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode, // Apply selected theme
      home: SplashScreen(), // Start from Splash Screen
    );
  }
}