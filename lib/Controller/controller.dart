import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:music_app/Model/favmodel.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Model/plmodel.dart';

class Controller extends GetxController {
  final songBox = Hive.box<Songs>(boxname);
  final favBox = Hive.box<FavSongs>(favboxname);
  final plBox = Hive.box<PlSongs>(plboxname);
 

  void addPlaylist(Songs addsongs) {
    songBox.add(addsongs);
    update();
  }

  void createPlaylist(PlSongs createPlst) {
    plBox.add(createPlst);
    update();
  }

  void editPlaylist(int index, PlSongs plname) {
    plBox.putAt(index, plname);
    update();
  }

  void deletePlaylist(int index) {
    plBox.deleteAt(index);
    update();
  }

  void addFavSongs(FavSongs favSong) {
    favBox.add(favSong);
    update();
  }

  void deleteFavSongs(int index) {
    favBox.deleteAt(index);
    update();
  }


}
