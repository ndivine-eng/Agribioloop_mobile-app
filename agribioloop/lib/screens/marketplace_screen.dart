import 'package:flutter/material.dart';

class MarketplaceScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
  {"name": "Organic Fertilizer", "price": "RWF 5,000", "image": "assets/images/fertilizer.png"},
  {"name": "Recycled Pots", "price": "RWF 3,500", "image": "assets/images/pots.png"},
  {"name": "Compost Bag", "price": "RWF 4,000", "image": "assets/images/compost.png"},
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marketplace"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _buildProductCard(products[index]);
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, String> product) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(product["image"]!, fit: BoxFit.cover, width: double.infinity),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                Text(product["name"]!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(product["price"]!, style: TextStyle(fontSize: 14, color: Colors.green)),
                SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Buy Now"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
