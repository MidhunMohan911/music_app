import 'package:flutter/material.dart';
import 'package:music_app/Playlists/playlist_ref.dart';

class ScreenPlaylist extends StatelessWidget {
  const ScreenPlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromARGB(255, 3, 46, 80),
            Color.fromARGB(255, 39, 12, 89),
            Color.fromARGB(255, 34, 4, 74),
            Color.fromARGB(255, 51, 37, 77),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Playlist'),
          centerTitle: true,
          toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: const [
            Icon(Icons.search),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: ListView(
          children: const [
            PlaylistRef(
              plImage: 'assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg',
              plText: 'Create a New Playlist',
              plIcon: Icons.playlist_add,
            ),
            SizedBox(
              height: 20,
            ),
            PlaylistRef(
              plImage: 'assets/let-me-zayn-malik.jpg',
              plText: 'Most Played',
              plIcon: Icons.more_vert,
            ),
            SizedBox(
              height: 20,
            ),
            PlaylistRef(
              plImage: 'assets/downloadnyt.png',
              plText: 'Night Mix',
              plIcon: Icons.more_vert,
            ),
            SizedBox(
              height: 20,
            ),
            PlaylistRef(
              plImage: 'assets/monthly-playlist.jpg',
              plText: 'Recently Added',
              plIcon: Icons.more_vert,
            ),
            SizedBox(
              height: 20,
            ),
            PlaylistRef(
              plImage: 'assets/maxresdefault.jpg',
              plText: 'Hollywood Mix',
              plIcon: Icons.more_vert,
            ),
          ],
        ),
      ),
    );
  }
}
