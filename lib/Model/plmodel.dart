import 'package:hive/hive.dart';
import 'package:music_app/Model/model.dart';

part 'plmodel.g.dart';

@HiveType(typeId: 2)
class PlSongs {
  @HiveField(0)
  String? playlistName;

  @HiveField(1)
  List<Songs>? playlistSongs;

  PlSongs(
      {required this.playlistName,
      required this.playlistSongs,
      });


}
String plboxname = 'playlists';

// class PlSongBox {
//   static Box<PlSongs>? _plbox;

//   static Box<PlSongs> getInstance() {
//     return _plbox ??= Hive.box(plboxname);
//   }
// }