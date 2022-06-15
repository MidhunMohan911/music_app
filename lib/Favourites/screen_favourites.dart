import 'package:flutter/material.dart';
import 'package:music_app/Favourites/favorite_ref.dart';
import 'package:music_app/Play%20Music/play_music.dart';
import 'package:music_app/Splash%20Screen/splash_screen.dart';

List<dynamic> fListImg = [
  'assets/let-me-zayn-malik.jpg',
  'assets/xxxtentacion.jpg',
  'assets/LSD.jpg',
  'assets/see you again.jpg'
];
List<dynamic> fListTitle = [
  'Let me',
  'Moonlight',
  'LSD',
  'See You Again',
];
List<dynamic> fListArtist = [
  'Zayn Malik',
  'xxxTentacion',
  'Sia',
  'wiz Khalifa'
];

class ScreenFavorites extends StatelessWidget {
  const ScreenFavorites({Key? key}) : super(key: key);

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
          title: const Text('Favorites'),
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: ((BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => PlayMusic(
                                fullSongs: fullSongs,
                                index: 0,
                              )),
                        ),
                      );
                    },
                    child: FavoriteRef(
                        favImage: fListImg[index],
                        favTitle: fListTitle[index],
                        favArtist: fListArtist[index]),
                  );
                }),
                itemCount: fListImg.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
