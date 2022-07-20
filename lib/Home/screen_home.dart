import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_app/Controller/controller.dart';
import 'package:music_app/Favourites/favorite_icon.dart';
import 'package:music_app/Home/Drawer/settings.dart';
import 'package:music_app/Home/Search/search_location.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Model/plmodel.dart';
import 'package:music_app/Play%20Music/Mini%20Player/mini_player.dart';
import 'package:music_app/Playlists/createplaylist.dart';
import 'package:music_app/player/open_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);

  final box = SongBox.getInstance();

  List<Audio> convertAudios = [];

  Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    List<Songs> allDbSongs = box.values.toList();

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
          // bottomSheet:  MiniPlayer(),
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
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  shadows: [Shadow(color: Colors.red, blurRadius: 15)]),
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
                  showSearch(context: context, delegate: SearchLocation());
                },
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          body: GetBuilder<Controller>(
            init: Controller(),
            builder: (controller) {
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
                            style: const TextStyle(color: Colors.white),
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
                              FavoriteIcon(
                                allSongs: allDbSongs,
                                index: index,
                              ),
                              // const Spacer(),

                              PlButtonHome(
                                songIndex: index,
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
            },
          )),
    );
  }
}

class PlButtonHome extends StatelessWidget {
  PlButtonHome({
    Key? key,
    required this.songIndex,
  }) : super(key: key);

  int songIndex;

  @override
  Widget build(BuildContext context) {
    Box<PlSongs> playlistBox = Hive.box<PlSongs>(plboxname);
    final height = MediaQuery.of(context).size.height;

    return IconButton(
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) => Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                          Color.fromARGB(255, 25, 39, 104),
                          Color.fromARGB(255, 59, 42, 100),
                          Color.fromARGB(255, 52, 8, 79)
                        ])),
                    child: GetBuilder<Controller>(
                      init: Controller(),
                      builder: (controller) {
                        List<PlSongs> playlists = playlistBox.values.toList();

                        if (playlistBox.isEmpty) {
                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.playlist_add),
                                title: const Text(
                                  'Create new playlist',
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 18),
                                ),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => CreatePlaylist());
                                },
                              ),
                              Center(
                                child: Column(
                                  children: [
                                    SizedBox(height: height * .2),
                                    Text('No playlists')
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        return Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.playlist_add),
                              title: const Text(
                                'Create new playlist',
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 18),
                              ),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => CreatePlaylist());
                              },
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: playlists.length,
                                itemBuilder: (BuildContext ctx, int index) =>
                                    Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color.fromARGB(255, 35, 26, 80),
                                                Color.fromARGB(255, 31, 5, 125),
                                                Color.fromARGB(255, 28, 2, 65)
                                              ],
                                              tileMode: TileMode.clamp,
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: ListTile(
                                            leading: const Text(
                                              '🎧',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            title: Text(
                                              playlists[index].playlistName!,
                                              style: const TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 17),
                                            ),
                                            onTap: () {
                                              PlSongs? plsongs =
                                                  playlistBox.getAt(index);

                                              List<Songs>? plnewSongs =
                                                  plsongs!.playlistSongs;

                                              Box<Songs> box =
                                                  Hive.box<Songs>(boxname);

                                              List<Songs> dbAllSongs =
                                                  box.values.toList();

                                              bool isAlreadyAdded =
                                                  plnewSongs!.any(
                                                (element) =>
                                                    element.id ==
                                                    dbAllSongs[songIndex].id,
                                              );

                                              if (!isAlreadyAdded) {
                                                plnewSongs.add(
                                                  Songs(
                                                    songname:
                                                        dbAllSongs[songIndex]
                                                            .songname,
                                                    artist:
                                                        dbAllSongs[songIndex]
                                                            .artist,
                                                    duration:
                                                        dbAllSongs[songIndex]
                                                            .duration,
                                                    songurl:
                                                        dbAllSongs[songIndex]
                                                            .songurl,
                                                    id: dbAllSongs[songIndex]
                                                        .id,
                                                  ),
                                                );

                                                playlistBox.putAt(
                                                  index,
                                                  PlSongs(
                                                      playlistName:
                                                          playlists[index]
                                                              .playlistName,
                                                      playlistSongs:
                                                          plnewSongs),
                                                );

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                151,
                                                                21,
                                                                67),
                                                        content: Text(dbAllSongs[
                                                                    songIndex]
                                                                .songname! +
                                                            'Added to ' +
                                                            playlists[index]
                                                                .playlistName!)));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                151,
                                                                21,
                                                                67),
                                                        content: Text(dbAllSongs[
                                                                    songIndex]
                                                                .songname! +
                                                            ' is already added')));
                                              }
                                              Navigator.pop(ctx);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    )),
              );
            });
      },
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white70,
      ),
    );
  }
}
