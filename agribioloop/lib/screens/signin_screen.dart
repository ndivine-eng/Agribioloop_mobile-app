import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'main_screen.dart';

class SignInScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              ),
              onPressed: () async {
                await ref.read(authProvider.notifier).signInWithGoogle();

                // ✅ Use ref.listen to update the UI after signing in
                ref.listen(authProvider, (previous, next) {
                  if (next != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  }
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ✅ Ensure this image exists in your assets or replace it with an Icon
                  Image.asset('assets/images/google_logo.png', height: 24, errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.account_circle, size: 24, color: Colors.white);
                  }),
                  SizedBox(width: 10),
                  Text("Sign in with Google", style: TextStyle(color: Colors.white, fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
