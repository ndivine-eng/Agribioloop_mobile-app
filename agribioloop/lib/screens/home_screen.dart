import 'package:flutter/material.dart';
import 'sell_products_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'schedule.dart';
import 'recycle_screen.dart';
import 'marketplace_screen.dart';
import 'learning_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = "User";
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (currentUser != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();

      if (userDoc.exists && userDoc.data() is Map<String, dynamic>) {
        setState(() {
          userName = userDoc['name'] ?? "User";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', height: 30),
            SizedBox(width: 10),
            Text("AgriBioLoop", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("No new notifications")),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, $userName",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildImageBanner(),
            SizedBox(height: 20),
            Text("My Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildServiceGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Welcome, $userName", style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, "Home", () {
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.schedule, "Schedule Pickup", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleScreen()));
          }),
          _buildDrawerItem(Icons.recycling, "Recycle", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => RecycleScreen()));
          }),
          _buildDrawerItem(Icons.store, "Marketplace", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MarketplaceScreen()));
          }),
          _buildDrawerItem(Icons.video_library, "Learning", () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LearningPage()));
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }

  Widget _buildImageBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.asset('assets/images/property.png', height: 180, width: double.infinity, fit: BoxFit.cover),
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildServiceCard(Icons.recycling, "Convert Waste", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RecycleScreen()));
        }),
        _buildServiceCard(Icons.schedule, "Schedule Pickup", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleScreen()));
        }),
        _buildServiceCard(Icons.store, "Marketplace", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MarketplaceScreen()));
        }),
        _buildServiceCard(Icons.video_library, "Learning", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LearningPage()));
        }),
      ],
    );
  }

  Widget _buildServiceCard(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.green),
              SizedBox(height: 8),
              Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}