import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:hive/hive.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/Favourites/favorite_icon.dart';
import 'package:music_app/Home/screen_home.dart';
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
bool isRepeat = false;

// Audio find(List<Audio> source, String fromPath) {
//   return source.firstWhere((element) => element.path == fromPath);
// }

class _PlayMusicState extends State<PlayMusic> {
  final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

  late Box<Songs> box;
  late List<Songs> allsongs;

  @override
  void initState() {
    box = Hive.box<Songs>(boxname);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    // dbSongs = box.get('musics') as List<Songs>;

    allsongs = box.values.toList();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Color.fromARGB(255, 2, 24, 41),
            Color.fromARGB(255, 34, 12, 73),
            Color.fromARGB(255, 29, 6, 60),
            Color.fromARGB(255, 24, 17, 37),
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

          int songId = int.parse(playing!.audio.audio.metas.id!);

          return Center(
            child: Column(
              children: [
                SizedBox(height: height * .03),
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
                      SizedBox(height: height * .02),
                      SizedBox(
                        height: height * .03,
                        width: width * .3,
                        child: Marquee(
                          blankSpace: 20,
                          velocity: 20,
                          text: player.getCurrentAudioTitle,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: height * .03,
                        width: width * .15,
                        child: Marquee(
                          blankSpace: 20,
                          velocity: 20,
                          text: player.getCurrentAudioArtist,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.02,
                // ),
                // ======== fav & playlist ======== //
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    FavoriteIcon(
                        allSongs: allsongs,
                        index: playing.index,
                      ),
                        PlButtonHome(
                        songIndex: playing.index,
                      )
                    ],
                  ),
                ),

                // ========= Progress_bar ========= //
                seekBarWidget(context),
                const SizedBox(
                  height: 10,
                ),

                // ========= Player_Controls ========= //
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    // const Spacer(),
                    // ====== Shuffle ====== //
                    IconButton(
                        onPressed: () {
                          player.toggleShuffle();
                          setState(() {});
                        },
                        icon: player.isShuffling.value ? const Icon(Icons.shuffle_on_outlined,
                            color: 
                                 
                                 Colors.white)
                                 : const Icon(Icons.shuffle,
                                 color: Colors.white,)
                                 ),

                    // ====== Previous_button ====== //
                    IconButton(
                      onPressed: playing.index != 0
                          ? () {
                              player.previous();
                            }
                          : () {},
                      icon: playing.index == 0
                          ? const Icon(
                              CupertinoIcons.backward_end,
                              color: Colors.white,
                              size: 30,
                            )
                          : const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                              size: 35,
                            ),
                    ),
                    // const Spacer(),

                    // ========= Play_button ========= //
                    CircleAvatar(
                      minRadius: 35,
                      backgroundColor: Color.fromARGB(255, 37, 3, 47),
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
                              size: 30,
                            )
                          : const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                              size: 35,
                            ),
                    ),
                    // ======== Repeat mode ======= //
                    IconButton(
                        onPressed: () {
                          if (isRepeat) {
                            player.setLoopMode(LoopMode.none);
                            isRepeat = false;
                          } else {
                            player.setLoopMode(LoopMode.single);
                            isRepeat = true;
                          }
                          setState(() {
                            
                          });
                        },
                        icon: isRepeat ? const Icon(
                          Icons.repeat_one_sharp,
                          color:  Colors.white 
                        )
                        : const Icon(Icons.repeat,
                        color: Colors.white,)
                        ),
                  
                  ],
                ),
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
