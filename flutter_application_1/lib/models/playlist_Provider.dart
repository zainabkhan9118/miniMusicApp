import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/models/songs.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
      songName: 'People You Know ',
      artistName: 'Selena Gomez',
      albumArtImagePath: 'assets/images/Song1.png',
      audioPath: 'audio/Selena_Gomez_-_People_You_Know__Lyrics_(48k).mp3',
    ),
    Song(
      songName: 'Lily',
      artistName: 'Alan Walker',
      albumArtImagePath: 'assets/images/Song2.png',
      audioPath: 'audio/Alan_Walker,_K-391_&_Emelie_Hollow_-_Lily_(Lyrics)(360p)(1).mp3',
    ),
    Song(
      songName: 'My Oh MY',
      artistName: 'Camila Cabello',
      albumArtImagePath: 'assets/images/Song3.png',
      audioPath: 'audio/Camila_Cabello_-_My_Oh_My__Official_Music_Video__ft._DaBaby(128k).mp3',
    ),

    Song(
      songName: 'Thumbs',
      artistName: 'Sabrina Carpenter',
      albumArtImagePath: 'assets/images/Song4.png',
      audioPath: 'audio/Sabrina_Carpenter_-_Thumbs_(Official_Video)(360p)(1).mp3',
    ),

    Song(
      songName: 'Mad At Disney',
      artistName: 'Salem Ilese',
      albumArtImagePath: 'assets/images/Song5.png',
      audioPath: 'audio/salem_ilese_–_mad_at_disney__official_music_video_(128k).mp3',
    ),

    Song(
      songName: 'Why',
      artistName: 'Derivakat',
      albumArtImagePath: 'assets/images/Song6.png',
      audioPath: 'audio/Why_-_Derivakat_[Dream_SMP_original_song](480p)(1).mp3',
    ),
  ];

  List<Song> favorites = []; 

  void toggleFavorite(Song song) {
    if (favorites.contains(song)) {
      favorites.remove(song);
    } else {
      favorites.add(song);
    }
    notifyListeners();
  }

  bool isFavorite(Song song) {
    return favorites.contains(song);
  }

  List<Playlist> playlists = [];

  void createPlaylist(String name) {
    playlists.add(Playlist(name: name, songs: []));
    notifyListeners();
  }

  void deletePlaylist(Playlist playlist) {
    playlists.remove(playlist);
    notifyListeners();
  }

  void addSongToPlaylist(Playlist playlist, Song song) {
    playlist.songs.add(song);
    notifyListeners();
  }

  void removeSongFromPlaylist(Playlist playlist, Song song) {
    playlist.songs.remove(song);
    notifyListeners();
  }

  int? _currentSongIndex;

  //Audioplayer code to play the song
  final AudioPlayer _audioPlayer = AudioPlayer();

  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //Constructor
  PlaylistProvider() {
    listenToDuration();
  }

  //initially nothing is playing so
  bool _isPlaying = false;

  //method for playing a song from the playlist
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop(); //stop current song
    await _audioPlayer.play(AssetSource(path)); //play new song

    _isPlaying = true;
    notifyListeners();
  }

  //pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //resume or pause playing
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
  }

  //seek to a specific position in a song
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        //goto the next song if that is not the last song
        _currentSongIndex = _currentSongIndex! + 1;
      } else {
        //Go back to 1st song
        _currentSongIndex = 0;
      }
      play(); // Play the new song
    }
  }

  //Play previous song
  void previousSong() async {
    //more than 2 seconds pass play the same song again
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      //go to the previous song
      if (_currentSongIndex! > 0) {
        _currentSongIndex = _currentSongIndex! - 1;
      } else {
        //if it's 1st song then go to last
        _currentSongIndex = _playlist.length - 1;
      }
      play(); // Play the new song
    }
  }

  //Listen to the duration of the song
  void listenToDuration() {
    //Listen to the total duration of the song
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });

    //Listen to the current duration of the song
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //Listen for song completion
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  // Getter
  List<Song> get playlist => _playlist;
  List<Song> get favoritesSongs => favorites;
  List<Playlist> get playlistList => playlists;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  // Setter
  set currentSongIndex(int? index) {
    //update current song index
    _currentSongIndex = index;
    if (index != null) {
      play(); //play the song at the new index 
    }
    notifyListeners();
  }
}

class Playlist {
  String name;
  List<Song> songs;

  Playlist({required this.name, required this.songs});
}