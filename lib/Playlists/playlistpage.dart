import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Model/plmodel.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../Play Music/Mini Player/mini_player.dart';

class PlaylistPage extends StatefulWidget {
  List<Songs> allSongs = [];

  String playlistName;
  int index;
  PlaylistPage(
      {Key? key,
      required this.playlistName,
      required this.allSongs,
      required this.index})
      : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
  List<Audio> plstSongs = [];

  // List<PlSongs> plSongs = [];
  late Box<PlSongs> plBox;
  late Box<Songs> box;
  bool isAdded = false;
  @override
  void initState() {
    // plBox = Hive.box<PlSongs>(plboxname);

    box = Hive.box<Songs>(boxname);

    for (var song in widget.allSongs) {
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

    super.initState();
  }

  // @override
  // void initState() {
  //   super.initState();
  //  setState(() {
  //     PlaylistSongsAdd;
  //   });
  // }
  // final box = SongBox.getInstance();

  @override
  Widget build(BuildContext context) {
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
        bottomSheet: const MiniPlayer(),
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          elevation: 0,
          title: Text(
            widget.playlistName,
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
                            child: Builder(builder: (context) {
                              List<Songs> allSongsss = box.values.toList();
                              return ListView.builder(
                                itemCount: allSongsss.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                      leading: QueryArtworkWidget(
                                          artworkBorder:
                                              BorderRadius.circular(20),
                                          artworkFit: BoxFit.cover,
                                          nullArtworkWidget: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
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
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          allSongsss[index].artist!,
                                        ),
                                      ),
                                      trailing: ValueListenableBuilder<
                                              Box<PlSongs>>(
                                          valueListenable:
                                              Hive.box<PlSongs>(plboxname)
                                                  .listenable(),
                                          builder: (ctx, playlistBox, _) {
                                            List<PlSongs> playlists =
                                                playlistBox.values.toList();
                                            return IconButton(
                                                onPressed: () {
                                                  PlSongs? plsongs =
                                                      playlistBox.getAt(
                                                    widget.index,
                                                  );

                                                  List<Songs>? plnewSongs =
                                                      plsongs!.playlistSongs;

                                                  // Box<Songs> box =
                                                  //     Hive.box<Songs>(
                                                  //         boxname);

                                                  // List<Songs> dbAllSongs =
                                                  //     box.values.toList();

                                                  bool isAlreadyAdded =
                                                      plnewSongs!.any(
                                                          (element) =>
                                                              element.id ==
                                                              allSongsss[index]
                                                                  .id);

                                                  if (!isAlreadyAdded) {
                                                    plnewSongs.add(
                                                      Songs(
                                                        songname:
                                                            allSongsss[index]
                                                                .songname,
                                                        artist:
                                                            allSongsss[index]
                                                                .artist,
                                                        duration:
                                                            allSongsss[index]
                                                                .duration,
                                                        songurl:
                                                            allSongsss[index]
                                                                .songurl,
                                                        id: allSongsss[index]
                                                            .id,
                                                      ),
                                                    );

                                                    playlistBox.putAt(
                                                      widget.index,
                                                      PlSongs(
                                                          playlistName:
                                                              playlists[widget
                                                                      .index]
                                                                  .playlistName,
                                                          playlistSongs:
                                                              plnewSongs),
                                                    );

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    151,
                                                                    21,
                                                                    67),
                                                            content: Text(allSongsss[
                                                                        index]
                                                                    .songname! +
                                                                'Added to ' +
                                                                playlists[widget
                                                                        .index]
                                                                    .playlistName!)));
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            backgroundColor:
                                                                const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    151,
                                                                    21,
                                                                    67),
                                                            content: Text(allSongsss[
                                                                        index]
                                                                    .songname! +
                                                                ' is already added')));
                                                  }

                                                  Navigator.pop(ctx);
                                                  setState(() {});
                                                },
                                                icon: const Icon(Icons.add));
                                          }));
                                },
                              );
                            }),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.playlist_add,
                    color: Colors.white,
                    size: 25,
                  )),
            )
          ],
        ),
        body: ValueListenableBuilder<Box<Songs>>(
          valueListenable: Hive.box<Songs>(boxname).listenable(),
          builder: (ctx, box, _) {
            return Container(
              child: plstSongs.isEmpty
                  ? Center(
                      child: Column(
                        children: [
                          SizedBox(height: height * .35),
                          // Lottie.network(
                          //   'https://assets2.lottiefiles.com/packages/lf20_mmwivxcd.json',
                          //   width: 30,
                          //   height: 30,
                          // ),
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
                                  SlidableAction(
                                    onPressed: (context) {
                                      setState(
                                        () {
                                          final box =
                                              Hive.box<PlSongs>(plboxname);
                                          widget.allSongs.removeAt(index);
                                          plstSongs.removeAt(index);

                                       
                                          box.putAt(
                                            widget.index,
                                            PlSongs(
                                              playlistName: widget.playlistName,
                                              playlistSongs: widget.allSongs,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    backgroundColor:
                                        const Color.fromARGB(255, 131, 33, 33),
                                    foregroundColor:
                                        const Color.fromARGB(255, 14, 12, 12),
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  )
                                ]),
                            child: ListTile(
                              onTap: () async {
                                plstSongs = [];
                                for (var song in widget.allSongs) {
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
                                widget.allSongs[index].songname!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 202, 197, 197),
                                ),
                              ),
                              subtitle: Text(
                                widget.allSongs[index].artist!,
                                style: const TextStyle(color: Colors.white70),
                              ),
                              leading: QueryArtworkWidget(
                                id: widget.allSongs[index].id!,
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
                        itemCount: widget.allSongs.length,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}



