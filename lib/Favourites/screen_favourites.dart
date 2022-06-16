import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Favourites/fav_add.dart';
import 'package:music_app/Model/favmodel.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/player/open_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenFavorites extends StatefulWidget {
  const ScreenFavorites({Key? key}) : super(key: key);

  @override
  State<ScreenFavorites> createState() => _ScreenFavoritesState();
}

List<Audio> favSong = [];

class _ScreenFavoritesState extends State<ScreenFavorites> {
  final box = SongBox.getInstance();
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
            title: const Text('Favourites'),
            centerTitle: true,
            toolbarHeight: 90,
            elevation: 0,
            backgroundColor: Colors.transparent,
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
                              child: const FavoriteAdd(),
                            );
                          });
                    },
                    icon: const Icon(
                      CupertinoIcons.heart_circle,
                      color: Colors.white,
                      size: 25,
                    )),
              )
            ],
          ),
          body: ValueListenableBuilder<Box<FavSongs>>(
              valueListenable: Hive.box<FavSongs>(favboxname).listenable(),
              builder: (BuildContext context, Box<FavSongs> favbox, child) {
                List<FavSongs> favoriteSongs = favbox.values.toList();
                return favoriteSongs.isEmpty
                    ? const Center(
                        child: Text(
                          'No favourites songs',
                          style: TextStyle(color: Colors.deepOrangeAccent),
                        ),
                      )
                    : ListView.builder(
                        itemCount: favoriteSongs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                for (var item in favoriteSongs) {
                                  favSong.add(
                                    Audio.file(
                                      item.songurl!,
                                      metas: Metas(
                                        title: item.songname,
                                        artist: item.artist,
                                        id: item.id.toString(),
                                      ),
                                    ),
                                  );
                                }
                                OpenPlayer(
                                        fullSongs: favSong,
                                        index: index,
                                        songId:
                                            favSong[index].metas.id.toString())
                                    .openAssetPlayer(
                                        index: index, songs: favSong);
                              },
                              leading: QueryArtworkWidget(
                                id: favoriteSongs[index].id!,
                                type: ArtworkType.AUDIO,
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
                              ),
                              title: Padding(
                                padding: const EdgeInsets.only(
                                    top: 3, left: 5, bottom: 3),
                                child: Text(
                                  favoriteSongs[index].songname!,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  favoriteSongs[index].artist!,
                                  style: const TextStyle(color: Colors.white60),
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  favbox.deleteAt(index);
                                  setState(() {});
                                },
                                icon: Icon(Icons.favorite),
                              ),
                            ),
                          );
                        },
                      );
              })),
    );
  }
}
