import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/Favourites/favorite_icon.dart';
import 'package:music_app/Home/Drawer/settings.dart';
import 'package:music_app/Home/Search/search_location.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Play%20Music/Mini%20Player/mini_player.dart';
import 'package:music_app/Playlists/createplaylist.dart';

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
                            trailing: Column(
                              children: [
                                Wrap(
                                  children: [
                                    FavoriteIcon(
                                      allSongs: allDbSongs,
                                      index: index,
                                    ),
                                    // const Spacer(),
                                  ],
                                ),
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
    );
  }
}

class PlButtonHome extends StatefulWidget {
  const PlButtonHome({Key? key}) : super(key: key);

  @override
  State<PlButtonHome> createState() => _PlButtonHomeState();
}

class _PlButtonHomeState extends State<PlButtonHome> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                      Color.fromARGB(255, 25, 39, 104),
                      Color.fromARGB(255, 59, 42, 100),
                      Color.fromARGB(255, 52, 8, 79)
                    ])),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.playlist_add),
                      title: const Text(
                        'Create new playlist',
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => CreatePlaylist());
                      },
                    )
                  ],
                ),
              );
            });
      },
      icon: Icon(Icons.more_vert),
    );
  }
}
