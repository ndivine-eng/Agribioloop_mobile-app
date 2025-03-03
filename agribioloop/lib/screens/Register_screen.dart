import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _acceptTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              'assets/images/logo.png', 
              height: 50,
            ),

            SizedBox(height: 10),

            // App Name
            Text(
              "AgriBioLoop",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),

            SizedBox(height: 20),

            // Tab Bar (Sign Up | Register)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(text: "Sign up"),
                  Tab(text: "Register"),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Input Fields
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Sign Up Tab (for now, just placeholder)
                  Center(child: Text("Sign Up Form Placeholder")),

                  // Register Tab
                  buildRegisterForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRegisterForm() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextField("Email address", Icons.email, false),
          SizedBox(height: 10),
          buildTextField("Password", Icons.lock, true, isPassword: true),
          SizedBox(height: 10),
          buildTextField("Confirm Password", Icons.lock, true, isPassword: true),

          SizedBox(height: 15),

          // Terms & Policies Checkbox
          Row(
            children: [
              Checkbox(
                value: _acceptTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptTerms = value!;
                  });
                },
                activeColor: Colors.green,
              ),
              Text("I accept the terms and policies"),
            ],
          ),

          SizedBox(height: 15),

          // Register Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _acceptTerms ? () {} : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                disabledBackgroundColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Register",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, IconData icon, bool obscureText,
      {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword ? obscureText : false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (label == "Password") {
                      _obscurePassword = !_obscurePassword;
                    } else {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    }
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
