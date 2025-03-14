import 'package:flutter/material.dart';

class SellProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Sell Products"),
      ),
      body: Center(
        child: Text(
          "Sell your recycled products here!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
