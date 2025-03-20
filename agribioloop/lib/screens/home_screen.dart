import 'package:flutter/material.dart';
import 'schedule.dart'; // Import Schedule Screen
import 'recycle_screen.dart'; // Import Recycle Screen

class HomeScreen extends StatelessWidget {
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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text("Welcome, User", style: TextStyle(color: Colors.white, fontSize: 16)),
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
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello, John Doe", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("My Services", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _buildImageSection(),
            SizedBox(height: 20),
            _buildServiceIcons(context),
          ],
        ),
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

  Widget _buildImageSection() {
    return Row(
      children: [
        Expanded(
          child: Image.asset('assets/images/property.png', height: 200, fit: BoxFit.cover),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Image.asset('assets/images/property.png', height: 100, fit: BoxFit.cover),
        ),
      ],
    );
  }

  Widget _buildServiceIcons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildServiceItem(Icons.recycling, "Convert Waste", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => RecycleScreen()));
        }),
        _buildServiceItem(Icons.schedule, "Schedule Pickup", () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleScreen()));
        }),
      ],
    );
  }

  Widget _buildServiceItem(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: Colors.green, size: 40),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
