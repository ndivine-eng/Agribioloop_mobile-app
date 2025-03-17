import 'package:flutter/material.dart';

void main() {
  runApp(ScheduleApp());
}

class ScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScheduleScreen(),
    );
  }
}

class ScheduleScreen extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int? _selectedSchedule; // To track selected radio button

  // Sample schedule data
  final List<Map<String, String>> schedules = [
    {"name": "JOHN", "day": "Monday", "date": "21/2/2022"},
    {"name": "Shah Alam", "day": "Tuesday", "date": "21/2/2022"},
    {"name": "Shah Alam", "day": "Wednesday", "date": "21/2/2022"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: Text("List of Schedule", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: schedules.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.green, width: 1),
                  ),
                  child: ListTile(
                    leading: Radio(
                      value: index,
                      groupValue: _selectedSchedule,
                      activeColor: Colors.orange,
                      onChanged: (int? value) {
                        setState(() {
                          _selectedSchedule = value;
                        });
                      },
                    ),
                    title: Text(
                      "Schedule Work",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${schedules[index]['name']} (${schedules[index]['day']})"),
                        Text(
                          "Start on ${schedules[index]['date']}",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () {
                if (_selectedSchedule != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Picked: ${schedules[_selectedSchedule!]['name']}"),
                    ),
                  );
                }
              },
              child: Text("PICK UP", style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
