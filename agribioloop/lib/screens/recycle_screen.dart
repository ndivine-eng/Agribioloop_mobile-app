import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class RecycleScreen extends StatefulWidget {
  @override
  _RecycleScreenState createState() => _RecycleScreenState();
}

class _RecycleScreenState extends State<RecycleScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  Map<String, int> recycleItems = {
    "Crop Residues": 0,
    "Animal Manure": 0,
    "Food By-product": 0,
    "Cardboard": 0,
  };

  final Map<String, double> biogasConversionRates = {
    "Crop Residues": 4.5,
    "Animal Manure": 3.2,
    "Food By-product": 5.0,
    "Cardboard": 1.8,
  };

  bool isPickupEnabled = false;
  bool isSubmitting = false;
  TextEditingController locationController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void updatePickupButtonState() {
    setState(() {
      isPickupEnabled = recycleItems.values.any((quantity) => quantity > 0);
    });
  }

  double calculateBiogas() {
    double total = 0;
    recycleItems.forEach((item, quantity) {
      total += quantity * biogasConversionRates[item]!;
    });
    return total;
  }

  Future<void> _submitPickupRequest() async {
    setState(() => isSubmitting = true);
    
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User not authenticated');
      
      final biogas = calculateBiogas();
      final pickupData = {
        'userId': user.uid,
        'items': recycleItems,
        'location': locationController.text.trim(),
        'notes': notesController.text.trim(),
        'biogasEstimate': biogas,
        'timestamp': FieldValue.serverTimestamp(),
        'status': 'pending',
      };

      await _firestore.collection('pickupRequests').add(pickupData);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pickup request submitted successfully!')),
      );
      
      // Clear form after submission
      setState(() => recycleItems.updateAll((key, value) => 0));
      locationController.clear();
      notesController.clear();
      updatePickupButtonState();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error submitting request: ${e.toString()}')),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  void _showConfirmationDialog(BuildContext context) {
    if (locationController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a pickup location")),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Pickup Request"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Items:", style: TextStyle(fontWeight: FontWeight.bold)),
              ...recycleItems.entries.map((e) => e.value > 0 
                  ? Text("- ${e.key}: ${e.value}") 
                  : SizedBox.shrink()
              ).toList(),
              SizedBox(height: 16),
              Text("Location:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(locationController.text.trim()),
              SizedBox(height: 16),
              if (notesController.text.isNotEmpty) 
                Text("Notes:", style: TextStyle(fontWeight: FontWeight.bold)),
              if (notesController.text.isNotEmpty) Text(notesController.text.trim()),
              SizedBox(height: 16),
              Text("Estimated Biogas Production:", 
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${calculateBiogas().toStringAsFixed(2)} kg"),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: isSubmitting ? null : () async {
              Navigator.pop(context);
              await _submitPickupRequest();
            },
            child: isSubmitting 
                ? CircularProgressIndicator()
                : Text("Confirm", style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    locationController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextFormField(
              controller: locationController,
              decoration: InputDecoration(
                labelText: 'Pickup Location',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextFormField(
              controller: notesController,
              decoration: InputDecoration(
                labelText: 'Notes (optional)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 3,
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
                double biogas = calculateBiogas();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Estimated Biogas Production: ${biogas.toStringAsFixed(2)} kg"),
                  ),
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
                  ? () => _showConfirmationDialog(context)
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isSubmitting)
                    Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  Text(
                    isSubmitting ? "Submitting..." : "Request a Pickup",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                  if (!isSubmitting) SizedBox(width: 8),
                  if (!isSubmitting) Icon(Icons.local_shipping, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}