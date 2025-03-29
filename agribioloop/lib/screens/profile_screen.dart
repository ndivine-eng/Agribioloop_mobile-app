import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme_selection_screen.dart';

class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 140,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).cardColor,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/profile2.jpeg'),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
          Text(
            "John Doe",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color, // Fix for null safety
            ),
          ),
          Text(
            "Samakhusi, Kathmandu",
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          SizedBox(height: 20),
          _buildProfileOption(context, "Account"),
          _buildProfileOption(context, "Address"),
          _buildProfileOption(context, "Theme", onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThemeSelectionScreen()),
            );
          }),
          _buildProfileOption(context, "Type of Waste"),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Handle Logout
            },
            child: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
          Spacer(),
          _buildBottomNavigation(context),
        ],
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, String title, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2), // Fix: Named argument
              blurRadius: 5,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // Fix: Correct property
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor, // Fix: Named argument
            blurRadius: 10,
          ),
        ],
      ),
    );
  }
}
