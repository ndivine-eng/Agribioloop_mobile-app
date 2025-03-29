import 'package:flutter/material.dart';
import 'pickup_screen.dart'; // Import the pickup screen

class ScheduleScreen extends StatelessWidget {
  final List<Map<String, String>> scheduleData = [
    {"date": "01", "day": "Sunday", "time": "5:00 AM"},
    {"date": "02", "day": "Monday", "time": "-"},
    {"date": "03", "day": "Tuesday", "time": "-"},
    {"date": "04", "day": "Wednesday", "time": "-"},
    {"date": "05", "day": "Thursday", "time": "5:00 AM"},
    {"date": "06", "day": "Friday", "time": "-"},
    {"date": "07", "day": "Saturday", "time": "6:00 AM"},
    {"date": "08", "day": "Sunday", "time": "-"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Schedule", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text("Your Location:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.black54),
                SizedBox(width: 5),
                Text("Samakhusi, Kathmandu", style: TextStyle(fontSize: 16)),
              ],
            ),
            SizedBox(height: 5),
            Text("Change Location", style: TextStyle(color: Colors.green, fontSize: 14, decoration: TextDecoration.underline)),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("JULY", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Text("01-09", style: TextStyle(fontSize: 16)),
                      Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: scheduleData.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(scheduleData[index]["date"]!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(scheduleData[index]["day"]!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(scheduleData[index]["time"]!, style: TextStyle(fontSize: 14, color: Colors.black54)),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: 5,
                        height: 40,
                        color: scheduleData[index]["time"] != "-" ? Colors.green : Colors.grey[300],
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to PickupScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PickupScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Confirm schedule", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
