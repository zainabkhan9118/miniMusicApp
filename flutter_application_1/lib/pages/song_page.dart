import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/neu_box.dart';
import 'package:flutter_application_1/models/playlist_Provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/themes/theme_provider.dart';

class SongPage extends StatefulWidget {
  const SongPage({super.key});

  @override
  _SongPageState createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        // Get player list
        final playlist = value.playlist;

        // Get current song index
        final currentSong = playlist[value.currentSongIndex ?? 0];

        // UI
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Custom appbar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Back button
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        // Song title
                        Text(
                          "P L A Y L I S T",
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        // Menu button
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    // Album artwork
                    NeuBox(
                      child: Column(
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(currentSong.albumArtImagePath),
                          ),
                          // Song and artist name
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: isDarkMode ? Colors.white : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    currentSong.artistName,
                                    style: TextStyle(
                                      color: isDarkMode ? Colors.white70 : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              // Favorite button
                              IconButton(
                                icon: Icon(
                                  value.isFavorite(currentSong) ? Icons.favorite : Icons.favorite_border,
                                  color: value.isFavorite(currentSong) ? Colors.red : (isDarkMode ? Colors.white : Colors.black),
                                ),
                                onPressed: () {
                                  setState(() {
                                    value.toggleFavorite(currentSong);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Song duration progress
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        children: [
                          // Slider for progress
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
                              overlayShape: RoundSliderOverlayShape(overlayRadius: 16),
                            ),
                            child: Slider(
                              min: 0,
                              max: value.totalDuration.inSeconds.toDouble(),
                              value: value.currentDuration.inSeconds.toDouble(),
                              activeColor: Theme.of(context).colorScheme.inversePrimary,
                              onChanged: (double newValue) {
                                // When slider is moved
                              },
                              onChangeEnd: (double newValue) {
                                value.seek(Duration(seconds: newValue.toInt()));
                              },
                            ),
                          ),
                          // Start and end time
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '0:00',
                                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                                ),
                                Text(
                                  '3:00',
                                  style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Playback controls
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Skip previous
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              value.previousSong();
                            },
                            child: NeuBox(
                              child: Icon(
                                Icons.skip_previous,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // Play pause
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              value.pauseOrResume();
                            },
                            child: NeuBox(
                              child: Icon(
                                value.isPlaying ? Icons.pause : Icons.play_arrow,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        // Skip forward
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              value.playNextSong();
                            },
                            child: NeuBox(
                              child: Icon(
                                Icons.skip_next,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}