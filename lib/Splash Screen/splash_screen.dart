import 'dart:math';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/bottomnav.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final audioQuery = OnAudioQuery();
final box = SongBox.getInstance();

List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];
List<Audio> fullSongs = [];
// List<Songs> dbSongs = [];
List<Songs> mappedSongs = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    requestStoragePermission();

    _navigatetohome();
  }

  requestStoragePermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();

      setState(() {});
      fetchSongs = await audioQuery.querySongs();

      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      allSongs.forEach((element) {
        box.add(
          Songs(
            songname: element.title,
            artist: element.artist,
            duration: element.duration,
            songurl: element.uri,
            id: element.id,
          ),
        );
      });
    } else {}

    // mappedSongs = allSongs
    //     .map(
    //       (audio) {
    //         return Songs(
    //           songname: audio.title,
    //           artist: audio.artist,
    //           duration: audio.duration,
    //           songurl: audio.uri,
    //           id: audio.id);
    //       },
    //     )
    //     .toList();

    // await box.put('musics', mappedSongs);
    // print(box.values);
    // dbSongs = box.get('musics') as List<Songs>;

    // for (var element in dbSongs) {
    //   fullSongs.add(
    //     Audio.file(
    //       element.songurl.toString(),
    //       metas: Metas(
    //           title: element.songname,
    //           id: element.id.toString(),
    //           artist: element.artist),
    //     ),
    //   );
    // }
    setState(() {});
  }

  Future _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 5), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => const BottomNav()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: ClipRRect(
                  child: Image.asset(
                    'assets/MusicSplash.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.80,
                  ),
                  Center(
                    child: DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.normal,
                        shadows: [
                          Shadow(
                            blurRadius: 15.0,
                            color: Color.fromARGB(255, 206, 58, 58),
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          FlickerAnimatedText('find your'),
                          FlickerAnimatedText('favourite tunes..🎶'),
                        ],
                        onTap: () {},
                      ),
                    ),

                    // child: DefaultTextStyle(
                    //   style: const TextStyle(
                    //     fontSize: 25.0,
                    //   ),
                    //   child: AnimatedTextKit(
                    //     animatedTexts: [
                    //       WavyAnimatedText('We Drift deeper in to the Sound'),
                    //     ],
                    //     isRepeatingAnimation: true,
                    //     onTap: () {},
                    //   ),
                    // ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
