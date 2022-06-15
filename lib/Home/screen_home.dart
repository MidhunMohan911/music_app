import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/Home/Drawer/settings.dart';
import 'package:music_app/Home/Search/search_location.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Play%20Music/Mini%20Player/mini_player.dart';

import 'package:music_app/Splash%20Screen/splash_screen.dart';
import 'package:music_app/bottomnav.dart';
import 'package:music_app/player/open_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  final box = SongBox.getInstance();

  List<Audio> convertAudios = [];

  @override
  void initState() {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // List<Songs> songs = box.values.toList();

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
          bottomSheet: const MiniPlayer(),
          drawer: const SettingsDrawer(),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: 120,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                image: DecorationImage(
                    image: AssetImage('assets/backgroundImg.jpeg'),
                    fit: BoxFit.fill),
              ),
            ),
            title: const Text(
              'Noisy Dose',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => Search(fullSongs: fullSongs),
                  //   ),
                  // );
                   showSearch(context: context, delegate: SearchLocation());
                },
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          body: ValueListenableBuilder<Box<Songs>>(
              valueListenable: box.listenable(),
              builder: (context, Box<Songs> allsongbox, child) {
                List<Songs> allDbSongs = allsongbox.values.toList();

                if (allDbSongs.isEmpty) {
                  return const Center(
                    child: Text('NO songs found!!'),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    Songs songs = allDbSongs[index];

                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            // visualDensity:
                            //     const VisualDensity(vertical: -3),
                            onTap: () async {
                              final songid =
                                  convertAudios[index].metas.id.toString();

                              await OpenPlayer(
                                fullSongs: convertAudios,
                                index: index,
                                songId: songid,
                              ).openAssetPlayer(
                                index: index,
                                songs: convertAudios,
                              );

                              // print('HEEEEEEEEEEEEEEEEEEEE');
                              // print(convertAudios);
                            },
                            //==============
                            leading: QueryArtworkWidget(
                              artworkFit: BoxFit.cover,
                              id: songs.id!,
                              // artworkBorder: BorderRadius.circular(5),
                              type: ArtworkType.AUDIO,

                              artworkQuality: FilterQuality.high,
                              size: 2000,
                              quality: 100,
                              artworkBorder: BorderRadius.circular(20),

                              //============No_Thumbnail=============//
                              nullArtworkWidget: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                child: Image.asset(
                                  'assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              songs.songname!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70),
                            ),

                            subtitle: Text(
                              songs.artist!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white60),
                            ),
                            //                                    )
                            trailing: Wrap(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    CupertinoIcons.heart_fill,
                                    color: Colors.white54,
                                  ),
                                ),
                                // const Spacer(),
                                InkWell(
                                  child: const Icon(
                                    Icons.more_vert,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                              height: 200,
                                              decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                      Color.fromARGB(
                                                          255, 19, 51, 83),
                                                      Color.fromARGB(
                                                          255, 112, 70, 161),
                                                      Color.fromARGB(
                                                          255, 53, 38, 94),
                                                    ]),
                                              ),
                                              child: Column(
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  const ListTile(
                                                    leading: Icon(
                                                      Icons.playlist_add,
                                                      color: Colors.white,
                                                    ),
                                                    title: Text(
                                                      "Add to PlayList",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  const ListTile(
                                                    // ignore: unnecessary_const
                                                    leading: const Icon(
                                                      CupertinoIcons.tag_solid,
                                                      color: Colors.white,
                                                    ),
                                                    title: Text(
                                                      "Edit name",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  const ListTile(
                                                    // ignore: unnecessary_const
                                                    leading: const Icon(
                                                      CupertinoIcons
                                                          .delete_solid,
                                                      color: Colors.white,
                                                    ),
                                                    title: Text(
                                                      "Remove",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ));
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: allDbSongs.length,
                );
              })),

      // FutureBuilder<List<SongModel>>(
      //     future: audioQuery.querySongs(
      //       sortType: null,
      //       orderType: OrderType.ASC_OR_SMALLER,
      //       uriType: UriType.EXTERNAL,
      //       ignoreCase: true,
      //     ),
      //     builder: (context, item) {
      //       if (item.data == null) {
      //         return const Center(
      //           child: CircularProgressIndicator(),
      //         );
      //       }
      //       if (item.data!.isEmpty) {
      //         return const Center(
      //           child: Text(
      //             'No songs found',
      //           ),
      //         );
      //       }

      //       return ValueListenableBuilder(
      //           valueListenable: box.listenable(),
      //           builder: ((context, value, child) => ListView.builder(
      //                 itemBuilder: (context, index) => Padding(
      //                   padding: const EdgeInsets.only(
      //                       left: 10, right: 10, bottom: 5),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       ListTile(
      //                         // visualDensity:
      //                         //     const VisualDensity(vertical: -3),
      //                         onTap: (() async {
      //                           final songid =
      //                               fullSongs[index].metas.id.toString();
      //                           await OpenPlayer(
      //                                   fullSongs: [],
      //                                   index: index,
      //                                   songId: songid)
      //                               .openAssetPlayer(
      //                                   index: index, songs: fullSongs);
      //                         }),
      //                         //==============
      //                         leading: QueryArtworkWidget(
      //                           artworkFit: BoxFit.cover,
      //                           id: int.parse(
      //                               fullSongs[index].metas.id.toString()),
      //                           // artworkBorder: BorderRadius.circular(5),
      //                           type: ArtworkType.AUDIO,

      //                           artworkQuality: FilterQuality.high,
      //                           size: 2000,
      //                           quality: 100,
      //                           artworkBorder: BorderRadius.circular(20),

      //                           //============No_Thumbnail=============//
      //                           nullArtworkWidget: ClipRRect(
      //                             borderRadius: const BorderRadius.all(
      //                                 Radius.circular(20)),
      //                             child: Image.asset(
      //                               'assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg',
      //                               fit: BoxFit.cover,
      //                             ),
      //                           ),
      //                         ),
      //                         title: Text(
      //                           fullSongs[index].metas.title!,
      //                           maxLines: 1,
      //                           overflow: TextOverflow.ellipsis,
      //                           style: const TextStyle(color: Colors.white70),
      //                         ),

      //                         subtitle: Text(
      //                           fullSongs[index].metas.artist!,
      //                           maxLines: 1,
      //                           overflow: TextOverflow.ellipsis,
      //                           style: const TextStyle(color: Colors.white60),
      //                         ),
      //                         //                                    )
      //                         trailing: Wrap(
      //                           children: [
      //                             InkWell(
      //                               onTap: () {},
      //                               child: const Icon(
      //                                 CupertinoIcons.heart_fill,
      //                                 color: Colors.white54,
      //                               ),
      //                             ),
      //                             const Spacer(),
      //                             InkWell(
      //                               child: const Icon(
      //                                 Icons.more_vert,
      //                                 color: Colors.white,
      //                               ),
      //                               onTap: () {
      //                                 showModalBottomSheet(
      //                                     context: context,
      //                                     builder: (context) => Container(
      //                                           height: 200,
      //                                           decoration:
      //                                               const BoxDecoration(
      //                                             gradient: LinearGradient(
      //                                                 begin:
      //                                                     Alignment.topCenter,
      //                                                 end: Alignment
      //                                                     .bottomCenter,
      //                                                 colors: [
      //                                                   Color.fromARGB(
      //                                                       255, 19, 51, 83),
      //                                                   Color.fromARGB(255,
      //                                                       112, 70, 161),
      //                                                   Color.fromARGB(
      //                                                       255, 53, 38, 94),
      //                                                 ]),
      //                                           ),
      //                                           child: Column(
      //                                             // ignore: prefer_const_literals_to_create_immutables
      //                                             children: [
      //                                               const ListTile(
      //                                                 leading: Icon(
      //                                                   Icons.playlist_add,
      //                                                   color: Colors.white,
      //                                                 ),
      //                                                 title: Text(
      //                                                   "Add to PlayList",
      //                                                   style: TextStyle(
      //                                                       color:
      //                                                           Colors.white),
      //                                                 ),
      //                                               ),
      //                                               const ListTile(
      //                                                 // ignore: unnecessary_const
      //                                                 leading: const Icon(
      //                                                   CupertinoIcons
      //                                                       .tag_solid,
      //                                                   color: Colors.white,
      //                                                 ),
      //                                                 title: Text(
      //                                                   "Edit name",
      //                                                   style: TextStyle(
      //                                                       color:
      //                                                           Colors.white),
      //                                                 ),
      //                                               ),
      //                                               const ListTile(
      //                                                 // ignore: unnecessary_const
      //                                                 leading: const Icon(
      //                                                   CupertinoIcons
      //                                                       .delete_solid,
      //                                                   color: Colors.white,
      //                                                 ),
      //                                                 title: Text(
      //                                                   "Remove",
      //                                                   style: TextStyle(
      //                                                       color:
      //                                                           Colors.white),
      //                                                 ),
      //                                               ),
      //                                             ],
      //                                           ),
      //                                         ));
      //                               },
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 itemCount: fullSongs.length,
      //               )),);
      //     }),
    );
  }

  // Future<void> requestStoragePermission() async {
  //   bool permissionStatus = await audioQuery.permissionsStatus();
  //   if (!permissionStatus) {
  //     await audioQuery.permissionsRequest();
  //   }
  //   setState(() {});
  //   fetchSongs = await audioQuery.querySongs();

  //   for (var element in fetchSongs) {
  //     if (element.fileExtension == 'mp3') {
  //       allSongs.add(element);
  //     }
  //   }
  //   mappedSongs = allSongs
  //       .map((audio) => Songs(
  //           songname: audio.title,
  //           artist: audio.artist,
  //           duration: audio.duration,
  //           songurl: audio.uri,
  //           id: audio.id))
  //       .toList();

  //   await box.put('musics', mappedSongs);
  //   dbSongs = box.get('musics') as List<Songs>;

  //   for (var element in dbSongs) {
  //     fullSongs.add(
  //       Audio.file(
  //         element.songurl.toString(),
  //         metas: Metas(
  //             title: element.songname,
  //             id: element.id.toString(),
  //             artist: element.artist),
  //       ),
  //     );
  //     Navigator.of(context).pushAndRemoveUntil(
  //         MaterialPageRoute(
  //           builder: ((context) => const BottomNav()),
  //         ),
  //         (route) => false);
  //   }
  //   setState(() {});
  // }

  // Songs findWatchlaterSongs(List<Songs> recently, String id) {
  //   return recently
  //       .firstWhere((element) => element.songurl.toString().contains(id));
  // }
}
