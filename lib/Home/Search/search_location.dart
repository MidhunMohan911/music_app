// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:music_app/Model/model.dart';
// import 'package:music_app/player/open_player.dart';
// import 'package:on_audio_query/on_audio_query.dart';

// class Search extends StatefulWidget {
//   List<Audio> fullSongs = [];

//   Search({Key? key, required this.fullSongs}) : super(key: key);

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   final box = SongBox.getInstance();
//   String search = "";
//   List<Songs> dbSongs = [];
//   List<Audio> allSongs = [];

//   searchSongs() {
//     // for (var element in dbSongs) {
//     //     allSongs.add(
//     //       Audio.file(
//     //         element.songurl.toString(),
//     //         metas: Metas(
//     //             title: element.songname,
//     //             id: element.id.toString(),
//     //             artist: element.artist),
//     //       ),
//     //     );
//     //   }
//   }

//   @override
//   void initState() {
//     super.initState();
//     searchSongs();
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     List<Audio> searchTitle = allSongs.where((element) {
//       return element.metas.title!.toLowerCase().startsWith(
//             search.toLowerCase(),
//           );
//     }).toList();

//     List<Audio> searchArtist = allSongs.where((element) {
//       return element.metas.artist!.toLowerCase().startsWith(
//             search.toLowerCase(),
//           );
//     }).toList();

//     List<Audio> searchResult = [];
//     if (searchTitle.isNotEmpty) {
//       searchResult = searchTitle;
//     } else {
//       searchResult = searchArtist;
//     }
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topRight,
//           end: Alignment.bottomLeft,
//           stops: [0.1, 0.5, 0.7, 0.9],
//           colors: [
//             Color.fromARGB(255, 3, 46, 80),
//             Color.fromARGB(255, 39, 12, 89),
//             Color.fromARGB(255, 34, 4, 74),
//             Color.fromARGB(255, 51, 37, 77),
//           ],
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           centerTitle: true,
//           elevation: 0,
//           title: const Text('Search'),
//         ),
//         body: SizedBox(
//           height: height,
//           width: width,
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.centerLeft,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 height: MediaQuery.of(context).size.height * .07,
//                 width: MediaQuery.of(context).size.width * .9,
//                 child: TextField(
//                   cursorHeight: 18,
//                   decoration: const InputDecoration(
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.only(
//                       top: 14,
//                       right: 10,
//                       left: 10,
//                     ),
//                     suffixIcon: Icon(Icons.search),
//                     hintText: 'Search Songs',
//                     filled: true,
//                     fillColor: Color.fromARGB(255, 58, 42, 106),
//                   ),
//                   onChanged: (value) {
//                     setState(() {
//                       search = value.trim();
//                     });
//                   },
//                 ),
//               ),
//               search.isEmpty
//                   ? searchResult.isNotEmpty
//                       ? Expanded(
//                           child: ListView.builder(
//                             itemCount: searchResult.length,
//                             itemBuilder: (context, index) {
//                               return FutureBuilder(
//                                 future: Future.delayed(
//                                     const Duration(microseconds: 0)),
//                                 builder: (context, snapshot) {
//                                   if (snapshot.connectionState ==
//                                       ConnectionState.done) {
//                                     return GestureDetector(
//                                       onTap: () {
//                                         OpenPlayer(
//                                           fullSongs: searchResult,
//                                           index: index,
//                                           songId: widget
//                                               .fullSongs[index].metas.id
//                                               .toString(),
//                                         ).openAssetPlayer(
//                                             index: index, songs: searchResult);
//                                       },
//                                       child: ListTile(
//                                         leading: SizedBox(
//                                           height: 50,
//                                           width: 50,
//                                           child: QueryArtworkWidget(
//                                             id: int.parse(
//                                                 searchResult[index].metas.id!),
//                                             type: ArtworkType.AUDIO,
//                                             artworkBorder:
//                                                 BorderRadius.circular(15),
//                                             artworkFit: BoxFit.cover,
//                                             nullArtworkWidget: Container(
//                                               height: 50,
//                                               width: 50,
//                                               decoration: const BoxDecoration(
//                                                 borderRadius: BorderRadius.all(
//                                                     Radius.circular(15)),
//                                                 image: DecorationImage(
//                                                   image: AssetImage(
//                                                     'assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg',
//                                                   ),
//                                                   fit: BoxFit.cover,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         title: Text(
//                                           searchResult[index].metas.title!,
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                         subtitle: Text(
//                                           searchResult[index].metas.artist!,
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: const TextStyle(
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                   return Container();
//                                 },
//                               );
//                             },
//                           ),
//                         )
//                       : const Padding(
//                           padding: EdgeInsets.all(30),
//                           child: Center(
//                             child: Text(
//                               'No Result Found',
//                               style: TextStyle(color: Colors.white, fontSize: 15),
//                             ),
//                           ),
//                         )
//                   : const SizedBox(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
















import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_app/Home/screen_home.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Play%20Music/list%20Audios/audiolist.dart';
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
            ? const Center(
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
