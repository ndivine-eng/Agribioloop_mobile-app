import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomeScreen

class RecycleScreen extends StatefulWidget {
  @override
  _RecycleScreenState createState() => _RecycleScreenState();
}

class _RecycleScreenState extends State<RecycleScreen> {
  Map<String, int> recycleItems = {
    "Crop Residues": 0,
    "Animal Manure": 0,
    "Food By-product": 0,
    "Cardboard": 0,
  };

  bool isPickupEnabled = false; // Initially disabled

  void updatePickupButtonState() {
    setState(() {
      isPickupEnabled = recycleItems.values.any((quantity) => quantity > 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigates back to HomeScreen
          },
        ),
        title: Text("Recycle", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: recycleItems.keys.map((item) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.recycling, color: Colors.black),
                    title: Text(item),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: Colors.grey),
                          onPressed: () {
                            if (recycleItems[item]! > 0) {
                              setState(() {
                                recycleItems[item] = recycleItems[item]! - 1;
                                updatePickupButtonState();
                              });
                            }
                          },
                        ),
                        Text("${recycleItems[item]}", style: TextStyle(fontSize: 16)),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline, color: Colors.black),
                          onPressed: () {
                            setState(() {
                              recycleItems[item] = recycleItems[item]! + 1;
                              updatePickupButtonState();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Calculation done!")),
                );
              },
              child: Text("Calculate", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isPickupEnabled ? Colors.green : Colors.grey.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: isPickupEnabled
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Pickup requested!")),
                      );
                    }
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Request a Pickup", style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(width: 8),
                  Icon(Icons.local_shipping, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
