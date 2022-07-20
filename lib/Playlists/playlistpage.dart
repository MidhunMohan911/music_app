import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Controller/controller.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Model/plmodel.dart';
import 'package:music_app/Play%20Music/play_music.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../Play Music/Mini Player/mini_player.dart';

class PlaylistPage extends StatelessWidget {
  List<Songs> allSongs = [];

  String playlistName;
  int indexx;
  PlaylistPage(
      {Key? key,
      required this.playlistName,
      required this.allSongs,
      required this.indexx})
      : super(key: key);

  List<Audio> plstSongs = [];
  AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  late Box<PlSongs> plBox;
  late Box<Songs> box;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    Box<Songs> songbox = Hive.box<Songs>(boxname);
    List<Songs> allSongsss = songbox.values.toList();
    final height = MediaQuery.of(context).size.height;

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
        bottomSheet: MiniPlayer(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          elevation: 0,
          title: Text(
            playlistName,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                shadows: [
                  Shadow(
                    blurRadius: 14,
                    color: Colors.red,
                  )
                ]),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(255, 19, 51, 83),
                                  Color.fromARGB(255, 112, 70, 161),
                                  Color.fromARGB(255, 53, 38, 94),
                                ]),
                          ),
                          child: ListView.builder(
                            itemCount: allSongsss.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: QueryArtworkWidget(
                                    artworkBorder: BorderRadius.circular(20),
                                    artworkFit: BoxFit.cover,
                                    nullArtworkWidget: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      child: Image.asset(
                                        'assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    id: allSongsss[index].id!,
                                    type: ArtworkType.AUDIO),
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 3, left: 5, bottom: 3),
                                  child: Text(
                                    allSongsss[index].songname!,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    allSongsss[index].artist!,
                                  ),
                                ),
                                trailing: GetBuilder<Controller>(
                                  init: Controller(),
                                  builder: (controller) {
                                    return IconButton(
                                      onPressed: () {
                                        Box<PlSongs> playlistBox =
                                            Hive.box<PlSongs>(plboxname);
                                        List<PlSongs> playlists =
                                            playlistBox.values.toList();
                                        PlSongs? plsongs = playlistBox.getAt(
                                          indexx,
                                        );

                                        List<Songs>? plnewSongs =
                                            plsongs!.playlistSongs;

                                        bool isAlreadyAdded = plnewSongs!.any(
                                            (element) =>
                                                element.id ==
                                                allSongsss[index].id);

                                        if (!isAlreadyAdded) {
                                          plnewSongs.add(
                                            Songs(
                                              songname:
                                                  allSongsss[index].songname,
                                              artist: allSongsss[index].artist,
                                              duration:
                                                  allSongsss[index].duration,
                                              songurl:
                                                  allSongsss[index].songurl,
                                              id: allSongsss[index].id,
                                            ),
                                          );

                                          playlistBox.putAt(
                                            indexx,
                                            PlSongs(
                                                playlistName: playlists[indexx]
                                                    .playlistName,
                                                playlistSongs: plnewSongs),
                                          );
                                          controller.update();

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 151, 21, 67),
                                                  content: Text(
                                                      allSongsss[index]
                                                              .songname! +
                                                          'Added to ' +
                                                          playlists[index]
                                                              .playlistName!)));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 151, 21, 67),
                                                  content: Text(allSongsss[
                                                              index]
                                                          .songname! +
                                                      ' is already added')));
                                        }

                                        // Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.add),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        );
                      });
                },
                icon: const Icon(
                  Icons.playlist_add,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
        body: GetBuilder<Controller>(
          init: Controller(),
          builder: (controller) {
            for (var song in allSongs) {
              plstSongs.add(
                Audio.file(
                  song.songurl!,
                  metas: Metas(
                    title: song.songname,
                    artist: song.artist,
                    id: song.id.toString(),
                  ),
                ),
              );
            }
            return Container(
              child: plstSongs.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(height: height * .35),
                          const Text('Nothing found')
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(5),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Slidable(
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  GetBuilder<Controller>(
                                      init: Controller(),
                                      builder: (contrlrr) {
                                        return SlidableAction(
                                          onPressed: (context) async {
                                            final box =
                                                Hive.box<PlSongs>(plboxname);
                                            allSongs.removeAt(index);

                                            plstSongs.removeAt(index);

                                            contrlrr.update();

                                            await player.open(
                                              Playlist(
                                                audios: plstSongs,
                                                startIndex: index,
                                              ),
                                              showNotification: true,
                                              notificationSettings:
                                                  const NotificationSettings(
                                                stopEnabled: false,
                                              ),
                                            );

                                    

                                            box.putAt(
                                              index,
                                              PlSongs(
                                                playlistName: playlistName,
                                                playlistSongs: allSongs,
                                              ),
                                            );
                                          },
                                          backgroundColor: const Color.fromARGB(
                                              255, 131, 33, 33),
                                          foregroundColor: const Color.fromARGB(
                                              255, 14, 12, 12),
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        );
                                      })
                                ]),
                            child: ListTile(
                              onTap: () async {
                                plstSongs = [];
                                for (var song in allSongs) {
                                  plstSongs.add(
                                    Audio.file(
                                      song.songurl!,
                                      metas: Metas(
                                          title: song.songname,
                                          artist: song.artist,
                                          id: song.id.toString()),
                                    ),
                                  );
                                }

                                await player.open(
                                  Playlist(
                                    audios: plstSongs,
                                    startIndex: index,
                                  ),
                                  showNotification: true,
                                  notificationSettings:
                                      const NotificationSettings(
                                    stopEnabled: false,
                                  ),
                                );
                              },
                              title: Text(
                                allSongs[index].songname!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 202, 197, 197),
                                ),
                              ),
                              subtitle: Text(
                                allSongs[index].artist!,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              leading: QueryArtworkWidget(
                                id: allSongs[index].id!,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  child: Image.asset(
                                    "assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg",
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: allSongs.length,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
