import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  backgroundColor: Colors.white,
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
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "Samakhusi, Kathmandu",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
          _buildProfileOption("District"),
          _buildProfileOption("Sector"),
          _buildProfileOption("Cell"),
          _buildProfileOption("Type of Waste"),
          SizedBox(height: 10),
          TextButton(
            onPressed: () {
              // Handle Logout
            },
            child: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
          Spacer(),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildProfileOption(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
        ),
        child: ListTile(
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
    
    );
  }
}
