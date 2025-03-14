import 'package:flutter/material.dart';
import 'sell_products_screen.dart'; // Import the new screen

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
            Text("AgriBioLoop"),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text("Menu", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () {},
            ),
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
            Row(
              children: [
                Expanded(
                  child: Image.asset('assets/images/property.png', height: 200),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Image.asset('assets/images/property.png', height: 100),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.recycling, color: Colors.green, size: 40),
                    Text("Convert Waste"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.feedback, color: Colors.green, size: 40),
                    Text("Feedback"),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.schedule, color: Colors.green, size: 40),
                    Text("Schedule Pickup"),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SellProductsScreen()),
                    );
                  },
                  child: Column(
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.green, size: 40),
                      Text("Sell Recycled"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
