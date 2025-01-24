import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/playlist_Provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search for songs...',
            hintStyle: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54),
          ),
          style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
          onChanged: (value) {
            setState(() {
              query = value;
            });
          },
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final results = value.playlist.where((song) {
            return song.songName.toLowerCase().contains(query.toLowerCase()) ||
                   song.artistName.toLowerCase().contains(query.toLowerCase());
          }).toList();

          if (results.isEmpty) {
            return Center(
              child: Text(
                'No songs found.',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final song = results[index];
              return ListTile(
                leading: Image.asset(song.albumArtImagePath),
                title: Text(
                  song.songName,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                subtitle: Text(
                  song.artistName,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                ),
                onTap: () {
                  // Navigate to song details or play song
                },
              );
            },
          );
        },
      ),
    );
  }
}