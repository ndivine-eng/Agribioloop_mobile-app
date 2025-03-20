import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 🔹 Riverpod State for Profile Data
final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileModel>(
  (ref) => ProfileNotifier(),
);

class ProfileNotifier extends StateNotifier<ProfileModel> {
  ProfileNotifier()
      : super(ProfileModel(
          name: "John Doe",
          location: "Samakhusi, Kathmandu",
          district: "Gasabo",
          sector: "Kimironko",
          cell: "Nyagatovu",
          wasteType: "Organic",
        ));

  void updateField(String key, String value) {
    state = state.copyWithField(key, value);
  }

  void updateProfileImage(File image) {
    state = state.copyWith(profileImage: image);
  }
}

/// 🔹 Profile Data Model
class ProfileModel {
  final String name;
  final String location;
  final String district;
  final String sector;
  final String cell;
  final String wasteType;
  final File? profileImage;

  ProfileModel({
    required this.name,
    required this.location,
    required this.district,
    required this.sector,
    required this.cell,
    required this.wasteType,
    this.profileImage,
  });

  ProfileModel copyWithField(String key, String value) {
    return ProfileModel(
      name: key == "Full Name" ? value : name,
      location: location,
      district: key == "District" ? value : district,
      sector: key == "Sector" ? value : sector,
      cell: key == "Cell" ? value : cell,
      wasteType: key == "Type of Waste" ? value : wasteType,
      profileImage: profileImage,
    );
  }

  ProfileModel copyWith({File? profileImage}) {
    return ProfileModel(
      name: name,
      location: location,
      district: district,
      sector: sector,
      cell: cell,
      wasteType: wasteType,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

/// 🔹 Profile Screen UI
class ProfileScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              /// 🌿 Header Image
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/header.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  /// 🔄 Profile Picture
                  Positioned(
                    bottom: -40,
                    child: GestureDetector(
                      onTap: () async {
                        final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (pickedFile != null) {
                          notifier.updateProfileImage(File(pickedFile.path));
                        }
                      },
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: profile.profileImage != null
                                ? FileImage(profile.profileImage!)
                                : AssetImage("assets/images/profile2.jpeg") as ImageProvider,
                          ),
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green,
                            child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60), /// Adjusted for image overlap

              /// 🏷 Name & Location
              Text(
                profile.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                profile.location,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 20),

              /// 📌 Editable Fields
              _buildProfileField(context, "District", profile.district, notifier.updateField),
              _buildProfileField(context, "Sector", profile.sector, notifier.updateField),
              _buildProfileField(context, "Cell", profile.cell, notifier.updateField),
              _buildDropdownField(context, "Type of Waste", profile.wasteType, notifier),

              /// 🔴 Logout Button
              SizedBox(height: 20),
              TextButton(
                onPressed: () => print("User logged out!"), /// Replace with logout function
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  side: BorderSide(color: Colors.red),
                ),
                child: Text("Logout", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 📝 Generic Profile Field
  Widget _buildProfileField(BuildContext context, String title, String value, Function(String, String) onSave) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value, style: TextStyle(fontSize: 16, color: Colors.black)),
      trailing: Icon(Icons.edit, color: Colors.green),
      onTap: () => _showEditDialog(context, title, value, onSave),
    );
  }

  /// 🔽 Dropdown for Waste Type
  Widget _buildDropdownField(BuildContext context, String title, String selectedValue, ProfileNotifier notifier) {
    List<String> wasteOptions = ["Organic", "Plastic", "Metal", "Glass", "E-Waste", "Other"];

    return ListTile(
      title: Text(title),
      subtitle: Text(selectedValue, style: TextStyle(fontSize: 16, color: Colors.black)),
      trailing: Icon(Icons.arrow_drop_down, color: Colors.green),
      onTap: () => _showDropdownDialog(context, title, selectedValue, wasteOptions, notifier.updateField),
    );
  }

  /// 🔹 Edit Dialog for Text Fields
  void _showEditDialog(BuildContext context, String title, String value, Function(String, String) onSave) {
    TextEditingController controller = TextEditingController(text: value);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $title"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Enter new $title",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              onSave(title, controller.text);
              Navigator.pop(context);
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }

  /// 🔹 Dropdown Dialog for Waste Type
  void _showDropdownDialog(
    BuildContext context,
    String title,
    String selectedValue,
    List<String> options,
    Function(String, String) onSave,
  ) {
    String? newValue = selectedValue;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select $title"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return RadioListTile(
              title: Text(option),
              value: option,
              groupValue: newValue,
              onChanged: (value) {
                newValue = value as String;
                onSave(title, newValue!);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
