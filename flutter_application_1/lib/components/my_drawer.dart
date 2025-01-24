import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import '../pages/favorites_page.dart';
import '../pages/search_page.dart';
import '../pages/playlists_page.dart';
import '../pages/profile_page.dart';
import '../pages/login_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Logo and User Info
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.music_note,
                    size: 40,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  SizedBox(height: 10),
                  Text(
                    user?.email ?? 'Guest',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            // Home title
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: ListTile(
                title: Text(
                  'H O M E',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            // Favorites title
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: ListTile(
                title: Text(
                  'F A V O R I T E S',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesPage()),
                  );
                },
              ),
            ),
            // Playlists title
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: ListTile(
                title: Text(
                  'P L A Y L I S T S',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlaylistsPage()),
                  );
                },
              ),
            ),
            // Search title
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: ListTile(
                title: Text(
                  'S E A R C H',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
              ),
            ),
            // Settings title with sub-options
            Padding(
              padding: EdgeInsets.only(left: 25, top: 25),
              child: ExpansionTile(
                title: Text(
                  'S E T T I N G S',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 20,
                  ),
                ),
                childrenPadding: EdgeInsets.only(left: 25), 
                children: [
                  ListTile(
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _logout(context);
                    },
                  ),
                  ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Dark Mode",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        CupertinoSwitch(
                          value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
                          onChanged: (value) {
                            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}