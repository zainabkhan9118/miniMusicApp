import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/playlist_Provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';
import 'playlist_details_page.dart';

class PlaylistsPage extends StatelessWidget {
  const PlaylistsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Playlists',
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
          final playlists = value.playlists;

          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return ListTile(
                title: Text(
                  playlist.name,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PlaylistDetailsPage(playlist: playlist)),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: isDarkMode ? Colors.white : Colors.black),
                  onPressed: () {
                    value.deletePlaylist(playlist);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePlaylistDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showCreatePlaylistDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create Playlist'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Playlist Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<PlaylistProvider>(context, listen: false).createPlaylist(controller.text);
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}