import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_app/Model/favmodel.dart';
import 'package:music_app/Model/model.dart';

class FavoriteIcon extends StatefulWidget {
  List<Songs> allSongs;
  final int index;
  // final String songId;
  FavoriteIcon({
    Key? key,
    // required this.songId,
    required this.allSongs,
    required this.index,
  }) : super(key: key);

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  // final box = SongBox.getInstance();

  // List<Audio> fullSongs = [];
  List<FavSongs> favoriteSongs = [];
  late Box<FavSongs> favBox;

  @override
  void initState() {
    favBox = Hive.box<FavSongs>(favboxname);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final fav = databaseSongs(dbSongs, widget.songId);

    favoriteSongs = favBox.values.toList();


    return favoriteSongs
            .where((element) =>
                element.id.toString() ==
                widget.allSongs[widget.index].id.toString())
            .isEmpty
        ? IconButton(
            onPressed: ()  {
              favBox.add(
                FavSongs(
                  songname: widget.allSongs[widget.index].songname,
                  artist: widget.allSongs[widget.index].artist,
                  duration: widget.allSongs[widget.index].duration,
                  songurl: widget.allSongs[widget.index].songurl,
                  id: widget.allSongs[widget.index].id,
                ),
              );
              setState(() {});

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(widget.allSongs[widget.index].songname! +
                      'Added to favourites')));
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ))
        : IconButton(
            onPressed: () {
              int currentIndex = favoriteSongs.indexWhere(
                  (element) => element.id == widget.allSongs[widget.index].id);

              favBox.deleteAt(currentIndex);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Removed from favourites'),
                ),
              );

              setState(() {});
            },
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
          );
  }
}


