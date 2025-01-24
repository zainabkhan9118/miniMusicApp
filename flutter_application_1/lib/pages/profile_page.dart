import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
    if (user != null) {
      _emailController.text = user.email ?? '';
      _phoneController.text = user.phoneNumber ?? '';
      _usernameController.text = user.displayName ?? '';
    }
  }

  void _updateProfile() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(_emailController.text);
        await user.updateProfile(displayName: _usernameController.text);
        // Phone number update logic can be added here if needed
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile update failed: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                filled: true,
                fillColor: isDarkMode ? Colors.black54 : Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                filled: true,
                fillColor: isDarkMode ? Colors.black54 : Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
                filled: true,
                fillColor: isDarkMode ? Colors.black54 : Colors.white.withOpacity(0.8),
                border: OutlineInputBorder(),
              ),
              style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateProfile,
              child: Text('Update Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}