import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/playlist_Provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites',
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final favorites = value.favorites;

          if (favorites.isEmpty) {
            return Center(
              child: Text(
                'No favorite songs yet.',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final song = favorites[index];
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
                trailing: IconButton(
                  icon: Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    value.toggleFavorite(song);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}