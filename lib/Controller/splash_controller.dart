import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/Home/screen_home.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/bottomnav.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Splash Screen/splash_screen.dart';

final audioQuery = OnAudioQuery();
final box = SongBox.getInstance();

List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];
List<Audio> fullSongs = [];

class SplashController extends GetxController {
  requestStoragePermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();

      fetchSongs = await audioQuery.querySongs();

      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      allSongs.forEach((element) {
        box.add(
          Songs(
            songname: element.title,
            artist: element.artist,
            duration: element.duration,
            songurl: element.uri,
            id: element.id,
          ),
        );
      });
    } else {}
  }

  Future _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 5), () {});

    await Get.offAll(
      const BottomNav(),
    );
    update();
  }

  @override
  void onInit() {
    requestStoragePermission();
    _navigatetohome();
    super.onInit();
  }
}
