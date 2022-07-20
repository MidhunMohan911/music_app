import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:hive/hive.dart';
import 'package:music_app/Controller/controller.dart';
import 'package:music_app/Model/favmodel.dart';
import 'package:music_app/Model/model.dart';

class FavoriteIcon extends StatelessWidget {
  List<Songs> allSongs;
  final int index;
  FavoriteIcon({
    Key? key,
    required this.allSongs,
    required this.index,
  }) : super(key: key);

  List<FavSongs> favoriteSongs = [];
  late Box<FavSongs> favBox;

  @override
  Widget build(BuildContext context) {
    favBox = Hive.box<FavSongs>(favboxname);

    return GetBuilder<Controller>(builder: (controller) {
      favoriteSongs = favBox.values.toList();

      bool isNotAdded = favoriteSongs
          .where((element) =>
              element.id.toString() == allSongs[index].id.toString())
          .isEmpty;

      return isNotAdded
          ? IconButton(
              onPressed: () {
                FavSongs favSong = FavSongs(
                  songname: allSongs[index].songname,
                  artist: allSongs[index].artist,
                  duration: allSongs[index].duration,
                  songurl: allSongs[index].songurl,
                  id: allSongs[index].id,
                );

                controller.addFavSongs(favSong);

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: const Color.fromARGB(255, 151, 21, 67),
                    content: Text(
                        allSongs[index].songname! + 'Added to favourites')));
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white70,
              ))
          : IconButton(
              onPressed: () async {
                int currentIndex = favoriteSongs
                    .indexWhere((element) => element.id == allSongs[index].id);

                controller.deleteFavSongs(currentIndex);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Color.fromARGB(255, 151, 21, 67),
                    content: Text('Removed from favourites'),
                  ),
                );
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            );
    });

    // favoriteSongs
    //         .where((element) =>
    //             element.id.toString() == allSongs[index].id.toString())
    //         .isEmpty
    //     ? IconButton(
    //         onPressed: () {
    //           favBox.add(
    //             FavSongs(
    //               songname: allSongs[index].songname,
    //               artist: allSongs[index].artist,
    //               duration: allSongs[index].duration,
    //               songurl: allSongs[index].songurl,
    //               id: allSongs[index].id,
    //             ),
    //           );

    //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //               backgroundColor: const Color.fromARGB(255, 151, 21, 67),
    //               content:
    //                   Text(allSongs[index].songname! + 'Added to favourites')));
    //         },
    //         icon: const Icon(
    //           Icons.favorite,
    //           color: Colors.white70,
    //         ))
    //     : IconButton(
    //         onPressed: () async {
    //           int currentIndex = favoriteSongs
    //               .indexWhere((element) => element.id == allSongs[index].id);

    //           await favBox.deleteAt(currentIndex);

    //           ScaffoldMessenger.of(context).showSnackBar(
    //             const SnackBar(
    //               backgroundColor: Color.fromARGB(255, 151, 21, 67),
    //               content: Text('Removed from favourites'),
    //             ),
    //           );
    //         },
    //         icon: const Icon(
    //           Icons.favorite,
    //           color: Colors.red,
    //         ),
    //       );
  }
}
