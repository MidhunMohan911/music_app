import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_app/Favourites/favorite_icon.dart';
import 'package:music_app/Model/model.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavoriteAdd extends StatelessWidget {
   FavoriteAdd({Key? key}) : super(key: key);


   List<Songs> dbSongs = [];
  late Box<Songs> allsongbox;

 
  @override
  Widget build(BuildContext context) {
  allsongbox = Hive.box<Songs>(boxname);

    List<Songs> allsongs = allsongbox.values.toList();

    return ListView.builder(
      itemCount: allsongs.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: QueryArtworkWidget(
            id: allsongs[index].id!,
            type: ArtworkType.AUDIO,
            artworkBorder: BorderRadius.circular(20),
            artworkFit: BoxFit.cover,
            nullArtworkWidget: 
            
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Image.asset(
                'assets/tumblr_o1h4njg3ku1sgjgnbo1_500-3396.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 3, left: 5, bottom: 3),
            child: Text(
              allsongs[index].songname!,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              allsongs[index].artist!,
            ),
          ),
          trailing: FavoriteIcon(
            index: index,
            allSongs: allsongs,
          ),
        );
      },
    );
  }
}
