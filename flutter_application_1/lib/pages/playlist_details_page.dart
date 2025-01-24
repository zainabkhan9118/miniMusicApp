import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/playlist_Provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';

class PlaylistDetailsPage extends StatelessWidget {
  final Playlist playlist;

  const PlaylistDetailsPage({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          playlist.name,
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
          return ListView.builder(
            itemCount: playlist.songs.length,
            itemBuilder: (context, index) {
              final song = playlist.songs[index];
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
                  icon: Icon(Icons.remove, color: isDarkMode ? Colors.white : Colors.black),
                  onPressed: () {
                    value.removeSongFromPlaylist(playlist, song);
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