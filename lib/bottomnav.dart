import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Favourites/screen_favourites.dart';
import 'package:music_app/Home/screen_home.dart';
import 'package:music_app/Play%20Music/Mini%20Player/mini_player.dart';
import 'package:music_app/Playlists/screen_playlist.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

// Audio find(List<Audio> source, String fromPath) {
//     return source.firstWhere((element) => element.path == fromPath);
//   }

class _BottomNavState extends State<BottomNav> {
  int _currentSelectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const ScreenHome(),
    const ScreenFavorites(),
    const ScreenPlaylist(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 58, 53, 116),
            Color.fromARGB(255, 50, 13, 103)
          ],
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          stops: [0.0, 0.8],
          tileMode: TileMode.clamp,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _pages[_currentSelectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentSelectedIndex,
          onTap: (newIndex) {
            setState(() {
              _currentSelectedIndex = newIndex;
            });
          },
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.music_house), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: 'Favourites'),
            BottomNavigationBarItem(
                icon: Icon(Icons.queue_music), label: 'Playlist'),
          ],
        ),
      ),
    );
  }
}
