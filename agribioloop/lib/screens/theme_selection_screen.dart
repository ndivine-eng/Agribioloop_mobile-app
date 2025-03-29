import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart'; // Import main.dart to access themeProvider

class ThemeSelectionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Theme')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            title: Text('Light Mode'),
            leading: Icon(Icons.light_mode),
            onTap: () {
              ref.read(themeProvider.notifier).state = ThemeMode.light;
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          ListTile(
            title: Text('Dark Mode'),
            leading: Icon(Icons.dark_mode),
            onTap: () {
              ref.read(themeProvider.notifier).state = ThemeMode.dark;
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
