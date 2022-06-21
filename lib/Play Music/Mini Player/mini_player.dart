import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_app/Play%20Music/play_music.dart';
import 'package:music_app/Splash%20Screen/splash_screen.dart';
import 'package:music_app/bottomnav.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

final AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

// Audio find(List<Audio> source, String fromPath) {
//   return source.firstWhere((element) => element.path == fromPath);
// }

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(
        builder: (BuildContext context, Playing? playing) {
      // final myAudio = find(fullSongs, playing!.audio.assetAudioPath);

      int songId = int.parse(playing!.audio.audio.metas.id!);

      return player.builderCurrent(
        builder: ((context, playing) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.black,
                    Color.fromARGB(255, 63, 20, 71),
                    Color.fromARGB(255, 17, 5, 1),
                  ],
                  tileMode: TileMode.clamp
                  ),
            ),
            child: player.builderCurrent(
              builder: ((context, Playing? playing) {
                // final myAudio =
                //     find(fullSongs, playing!.audio.assetAudioPath);
                // final currentSong = dbSongs.firstWhere((element) =>
                //     element.id.toString() == myAudio.metas.id.toString());
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PlayMusic(
                            fullSongs: fullSongs,
                            index: 0,
                          ),
                        ),
                      );
                    },
                    // <<<<<<<< Thumbnail >>>>>>>>> //
                    leading: QueryArtworkWidget(
                      id: songId,
                      type: ArtworkType.AUDIO,
                      artworkHeight: 50,
                      artworkWidth: 50,
                      size: 2000,
                      quality: 100,
                      artworkBorder: BorderRadius.circular(20),
                      nullArtworkWidget: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        child: Image.asset(
                          'assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: SizedBox(
                      height: 22,
                      child: Marquee(
                        blankSpace: 20,
                        velocity: 20,
                        text: playing!.audio.audio.metas.title!,
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 18),
                      ),
                    ),
                    subtitle: SizedBox(
                      height: 15,
                      child: Marquee(
                        blankSpace: 20,
                        velocity: 20,
                        text: playing.audio.audio.metas.artist!,
                        style: const TextStyle(color: Colors.white60),
                      ),
                    ),
                    trailing: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        IconButton(
                          onPressed: playing.index != 0
                              ? () {
                                  player.previous();
                                }
                              : () {},
                          // <<<<<< Previous >>>>>>> //
                          icon: playing.index == 0
                              ? const Icon(
                                  CupertinoIcons.backward_end,
                                  color: Colors.white60,
                                  size: 26,
                                )
                              : const Icon(
                                    Icons.skip_previous,
                                    color: Colors.white60,
                                    size: 30,
                                  )
                        ),

                        //<<<<<<< Play >>>>>>>//
                        PlayerBuilder.isPlaying(
                            player: player,
                            builder: (context, isPlaying) {
                              return IconButton(
                                onPressed: () {
                                  player.playOrPause();
                                },
                                icon: Icon(isPlaying
                                    ? CupertinoIcons.pause_circle
                                    : CupertinoIcons.play_circle),
                                iconSize: 35,
                                color: Colors.white70,
                              );
                            }),

                        //<<<<<<<< Next >>>>>>>>
                        IconButton(
                            onPressed: playing.index == allSongs.length - 1
                                ? () {}
                                : () {
                                    player.next();
                                  },
                            icon: playing.index == allSongs.length - 1
                                ? const Icon(
                                    CupertinoIcons.forward_end,
                                    color: Colors.white60,
                                    size: 26,
                                  )
                                : const Icon(
                                    Icons.skip_next,
                                    color: Colors.white60,
                                    size: 30,
                                  )),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }),
      );
    });
  }
}
