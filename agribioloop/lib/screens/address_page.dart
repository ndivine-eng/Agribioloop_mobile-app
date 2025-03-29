import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Address model
class Address {
  final String country;
  final String district;
  final String sector;
  final String cell;

  Address({required this.country, required this.district, required this.sector, required this.cell});
}

// StateNotifier for managing addresses
class AddressNotifier extends StateNotifier<List<Address>> {
  AddressNotifier() : super([]);

  void addAddress(Address address) {
    state = [...state, address];
  }

  void removeAddress(int index) {
    state = List.from(state)..removeAt(index);
  }
}

final addressProvider = StateNotifierProvider<AddressNotifier, List<Address>>((ref) => AddressNotifier());

class AddressPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addresses = ref.watch(addressProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Addresses'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showAddAddressDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text("Add New Address"),
              onPressed: () => _showAddAddressDialog(context, ref),
            ),
          ),
          Expanded(
            child: addresses.isEmpty
                ? Center(child: Text("No addresses added yet."))
                : ListView.builder(
                    itemCount: addresses.length,
                    itemBuilder: (context, index) {
                      final address = addresses[index];
                      return Card(
                        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          title: Text("${address.country}, ${address.district}"),
                          subtitle: Text("${address.sector}, ${address.cell}"),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              ref.read(addressProvider.notifier).removeAddress(index);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context, WidgetRef ref) {
    final _countryController = TextEditingController();
    final _districtController = TextEditingController();
    final _sectorController = TextEditingController();
    final _cellController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Address"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField(_countryController, "Country"),
                _buildTextField(_districtController, "District"),
                _buildTextField(_sectorController, "Sector"),
                _buildTextField(_cellController, "Cell"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_countryController.text.isNotEmpty &&
                    _districtController.text.isNotEmpty &&
                    _sectorController.text.isNotEmpty &&
                    _cellController.text.isNotEmpty) {
                  ref.read(addressProvider.notifier).addAddress(
                        Address(
                          country: _countryController.text,
                          district: _districtController.text,
                          sector: _sectorController.text,
                          cell: _cellController.text,
                        ),
                      );
                  Navigator.pop(context);
                }
              },
              child: Text("Save Address"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
