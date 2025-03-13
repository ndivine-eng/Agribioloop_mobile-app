import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'main_screen.dart';

class RegisterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Logo
            Center(child: Image.asset('assets/images/logo.png', height: 80)),
            SizedBox(height: 10),
            
            // App Name
            Center(
              child: Text(
                "AgriBioLoop",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Toggle Buttons (Sign up & Register)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Sign up", style: TextStyle(color: Colors.black54)),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text("Register", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Email Field
            TextField(
              decoration: InputDecoration(
                labelText: "Email address",
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            
            // Password Field
            TextField(
              decoration: InputDecoration(
                labelText: "Password",
                border: UnderlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            
            // Confirm Password Field
            TextField(
              decoration: InputDecoration(
                labelText: "Confirm Password",
                border: UnderlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
              obscureText: true,
            ),
            SizedBox(height: 10),
            
            // Terms and Conditions Checkbox
            Row(
              children: [
                Checkbox(value: true, onChanged: (value) {}),
                Text("I accept the terms and policies"),
              ],
            ),
            SizedBox(height: 20),
            
            // Register Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                ref.read(authProvider.notifier).login(); // Update authentication state
                
                // Navigate to MainScreen after registration
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                );
              },
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
