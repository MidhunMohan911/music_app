import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/Splash%20Screen/splash_screen.dart';
import 'package:music_app/bottomnav.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_app/Model/model.dart';

// ignore: must_be_immutable
class PlayMusic extends StatefulWidget {
  int index;
  List<Audio> fullSongs = [];
  PlayMusic({
    required this.fullSongs,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<PlayMusic> createState() => _PlayMusicState();
}

AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

// Audio find(List<Audio> source, String fromPath) {
//   return source.firstWhere((element) => element.path == fromPath);
// }

class _PlayMusicState extends State<PlayMusic> {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
  @override
  Widget build(BuildContext context) {
    // dbSongs = box.get('musics') as List<Songs>;
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
          title: const Text('Now Playing'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: player.builderCurrent(builder: (context, Playing? playing) {
          // final myAudio = find(fullSongs, playing!.audio.assetAudioPath);
          // ignore: unused_local_variable

          // dbSongs.firstWhere((element) =>
          //     element.id.toString() == myAudio.metas.id.toString());

       int songId =int.parse(playing!.audio.audio.metas.id!);

          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: QueryArtworkWidget(
                    artworkQuality: FilterQuality.high,
                    quality: 100,
                    size: 2000,
                    artworkFit: BoxFit.cover,
                    artworkBorder: BorderRadius.circular(50),
                    id: songId,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(50),
                      ),
                      child: Image.asset(
                        'assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // ========Title_&_Artist======== //
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.10,
                // ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                        width: 300,
                        child: Marquee(
                          blankSpace: 20,
                          velocity: 20,
                          text: player.getCurrentAudioTitle,
                          style: TextStyle(fontSize: 18,color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        width: 150,
                        child: Marquee(
                          blankSpace: 20,
                          velocity: 20,
                          text: player.getCurrentAudioArtist,
                          style: TextStyle(fontSize: 15,color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.02,
                // ),

                // ========= Progress_bar ========= //
                seekBarWidget(context),
                const SizedBox(
                  height: 10,
                ),

                // ========= Player_Controls ========= //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  FavoriteButton(
                      isFavorite: false,
                      iconColor: Colors.red,
                      iconSize: 40,
                      iconDisabledColor: Colors.white70,
                      valueChanged: (_isFavorite) {
                        print('Is Favorite : $_isFavorite');
                      }),
                  // const Spacer(),

                  // ====== Previous_button ====== //
                  InkWell(
                    child: IconButton(
                      onPressed: playing.index != 0
                          ? () {
                              player.previous();
                            }
                          : () {},
                      icon: playing.index == 0
                          ? const Icon(
                              CupertinoIcons.backward_end,
                              color: Colors.white,
                              size: 35,
                            )
                          : const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 35,
                            ),
                    ),
                  ),
                  // const Spacer(),

                  // ========= Play_button ========= //
                  CircleAvatar(
                    minRadius: 35,
                    backgroundColor: Color.fromARGB(255, 64, 23, 76),
                    foregroundColor: Colors.deepOrange,
                    child: PlayerBuilder.isPlaying(
                        player: player,
                        builder: (context, isPlaying) {
                          return IconButton(
                            onPressed: (() {
                              player.playOrPause();
                            }),
                            icon: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 35,
                            ),
                            color: Colors.white,
                          );
                        }),
                  ),
                  // ======= Next_button ======= //
                  IconButton(
                    onPressed: playing.index == fullSongs.length - 1
                        ? () {}
                        : () {
                            player.next();
                          },
                    icon: playing.index == fullSongs.length - 1
                        ? const Icon(
                            CupertinoIcons.forward_end,
                            color: Colors.white,
                            size: 35,
                          )
                        : const Icon(
                            Icons.skip_next,
                            color: Colors.white,
                            size: 35,
                          ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.playlist_add,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ])
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget seekBarWidget(BuildContext ctx) {
    return player.builderRealtimePlayingInfos(
      builder: ((ctx, infos) {
        Duration currentPosition = infos.currentPosition;
        Duration total = infos.duration;
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ProgressBar(
            progress: currentPosition,
            barHeight: 3,
            total: total,
            onSeek: (to) {
              player.seek(to);
            },
            timeLabelTextStyle: const TextStyle(color: Colors.white),
            baseBarColor: Colors.grey[200],
            progressBarColor: const Color.fromARGB(255, 62, 4, 116),
            bufferedBarColor: const Color.fromARGB(255, 72, 63, 171),
            thumbColor: const Color.fromARGB(255, 5, 5, 5),
          ),
        );
      }),
    );
  }
}
