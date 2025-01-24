// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_application_1/themes/theme_provider.dart';
// import 'package:flutter_application_1/pages/profile_page.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_application_1/pages/login_page.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   void _logout(BuildContext context) async {
//     await FirebaseAuth.instance.signOut();
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => LoginPage()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.background,
//         iconTheme: IconThemeData(
//           color: Theme.of(context).colorScheme.inversePrimary,
//         ),
//         title: Text(
//           'S E T T I N G S',
//           style: TextStyle(
//             color: Theme.of(context).colorScheme.inversePrimary,
//           ),
//         ),
//       ),
//       body: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Dark Mode",
//                   style: TextStyle(
//                     color: Theme.of(context).colorScheme.inversePrimary,
//                     fontSize: 16,
//                   ),
//                 ),
//                 CupertinoSwitch(
//                   value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode,
//                   onChanged: (value) {
//                     Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             ListTile(
//               title: Text(
//                 'Profile',
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.inversePrimary,
//                 ),
//               ),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ProfilePage()),
//                 );
//               },
//             ),
//             ListTile(
//               title: Text(
//                 'Logout',
//                 style: TextStyle(
//                   color: Theme.of(context).colorScheme.inversePrimary,
//                 ),
//               ),
//               onTap: () => _logout(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }