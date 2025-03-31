import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../providers/auth_provider.dart';
import 'address_page.dart';
import 'signin_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  File? _image;
  bool _isThemeExpanded = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeMode currentTheme = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 140,
                left: MediaQuery.of(context).size.width / 2 - 50,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Theme.of(context).cardColor,
                    child: _image != null
                        ? ClipOval(
                            child: Image.file(
                              _image!,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          )
                        : CircleAvatar(
                            radius: 45,
                            backgroundImage: AssetImage('assets/images/profile2.jpeg'),
                          ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 60),
          Text(
            "John Doe",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          Text(
            "Samakhusi, Kathmandu",
            style: TextStyle(color: Theme.of(context).hintColor),
          ),
          SizedBox(height: 20),
          _buildProfileOption(context, "Account", Icons.person),
          _buildProfileOption(context, "Address", Icons.location_on, onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddressPage()),
            );
          }),
          _buildThemeDropdown(context, ref, currentTheme),
          _buildProfileOption(context, "Type of Waste", Icons.recycling),
          SizedBox(height: 10),
          TextButton(
            onPressed: () async {
              await ref.read(authProvider.notifier).signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
            },
            child: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildThemeDropdown(BuildContext context, WidgetRef ref, ThemeMode currentTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.color_lens, color: Theme.of(context).iconTheme.color),
              title: Text("Theme", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
              trailing: Icon(
                _isThemeExpanded ? Icons.arrow_drop_down : Icons.arrow_forward_ios,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () {
                setState(() {
                  _isThemeExpanded = !_isThemeExpanded;
                });
              },
            ),
            if (_isThemeExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Light Mode"),
                      leading: Icon(Icons.light_mode),
                      onTap: () {
                        ref.read(themeProvider.notifier).state = ThemeMode.light;
                        setState(() {
                          _isThemeExpanded = false;
                        });
                      },
                    ),
                    ListTile(
                      title: Text("Dark Mode"),
                      leading: Icon(Icons.dark_mode),
                      onTap: () {
                        ref.read(themeProvider.notifier).state = ThemeMode.dark;
                        setState(() {
                          _isThemeExpanded = false;
                        });
                      },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, String title, IconData icon, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.2),
              blurRadius: 5,
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).iconTheme.color),
          title: Text(
            title,
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Theme.of(context).iconTheme.color),
          onTap: onTap,
        ),
      ),
    );
  }
}