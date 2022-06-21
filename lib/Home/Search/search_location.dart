

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/Home/screen_home.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Play%20Music/play_music.dart';
import 'package:music_app/Splash%20Screen/splash_screen.dart';
import 'package:music_app/player/open_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchLocation extends SearchDelegate {

  


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            query = '';
          }),
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (() {
          close(context, query);
        }),
        icon: const Icon(Icons.arrow_back));
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 77, 44, 109),
        elevation: 0,
      ),
      // ignore: prefer_const_constructors
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,

        // Use this change the placeholder's text style
        hintStyle: const TextStyle(fontSize: 22.0),
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

// search element
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Audio> convertAudios = [];

     List<Songs> dbSongs = box.values.toList();

    for (var item in dbSongs) {
      convertAudios.add(
        Audio.file(item.songurl!,
            metas: Metas(
                title: item.songname,
                artist: item.artist,
                id: item.id.toString())),
      );
    }

    final searchSongItems = query.isEmpty
        ? convertAudios
        : convertAudios
            .where(
              (element) => element.metas.title!.toLowerCase().contains(
                    query.toLowerCase().toString(),
                  ),
            )
            .toList();
   

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
        body: searchSongItems.isEmpty
            ?  Center(
              // child: Lottie.network('https://assets1.lottiefiles.com/packages/lf20_ksrabxwb.json',
              // animate: true),
                child: Text(
                  "No Songs Found!",
                  style: TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                    child: Container(
                        alignment: Alignment.center,
                        child: Center(
                          child: ListTile(
                            onTap: (() async {
                              final songid =
                                  convertAudios[index].metas.id.toString();
                              await OpenPlayer(
                                fullSongs: convertAudios,
                                songId: songid,
                                    
                                index: index,
                              ).openAssetPlayer(
                                index: index,
                                songs: searchSongItems,
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: ((context) => PlayMusic(fullSongs: fullSongs, index: index,)),
                                ),
                              );
                            }),
                            leading: QueryArtworkWidget(
                              nullArtworkWidget: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                child: Image.asset(
                                  'assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              id: int.parse(
                                  searchSongItems[index].metas.id!),
                              type: ArtworkType.AUDIO,
                            ),
                            title: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                searchSongItems[index].metas.title!,
                              ),
                            ),
                            subtitle: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                searchSongItems[index].metas.artist!,
                              ),
                            ),
                            
                          ),
                        )),
                  );
                },
                itemCount: searchSongItems.length,
              ),
      ),
    );
  }
}
