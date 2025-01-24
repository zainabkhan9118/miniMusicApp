import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/models/playlist_Provider.dart';
import 'package:flutter_application_1/models/songs.dart';
import 'package:flutter_application_1/pages/song_page.dart';
import 'package:provider/provider.dart';
import '../components/my_drawer.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';
import 'login_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final dynamic playlistProvider;

  @override
  void initState() {
    super.initState();
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
    _checkAuth();
  }

  void _checkAuth() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    });
  }

  void goToSong(int songIndex) {
    //update current song index
    playlistProvider.currentSongIndex = songIndex;
    //navigate to song page
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SongPage()));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'P L A Y L I S T',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const MyDrawer(),
      body: Consumer<PlaylistProvider>(
        builder: (context, value, child) {
          final List<Song> playlist = value.playlist;

          return ListView.builder(
            itemCount: playlist.length,
            itemBuilder: (context, index) {
              final Song song = playlist[index];

              return ListTile(
                title: Text(
                  song.songName,
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.white
                        : Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                subtitle: Text(
                  song.artistName,
                  style: TextStyle(
                    color: isDarkMode
                        ? Colors.white70
                        : Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                leading: Image.asset(
                  song.albumArtImagePath,
                  width: 100,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                onTap: () => goToSong(index),
              );
            },
          );
        },
      ),
    );
  }
}