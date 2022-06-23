import 'package:hive/hive.dart';

part 'favmodel.g.dart';

@HiveType(typeId: 1)
class FavSongs extends HiveObject {
  @HiveField(0)
  String? songname;

  @HiveField(1)
  String? artist;

  @HiveField(2)
  int? duration;

  @HiveField(3)
  String? songurl;

  @HiveField(4)
  int? id;

  FavSongs(
      {required this.songname,
      required this.artist,
      required this.duration,
      required this.songurl,
      required this.id});


}
String favboxname = 'favSongs';

// class FavSongBox {
//   static Box<FavSongs>? _favbox;

//   static Box<FavSongs> getInstance() {
//     return _favbox ??= Hive.box(favboxname);
//   }
// }