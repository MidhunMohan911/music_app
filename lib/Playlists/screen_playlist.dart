import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Model/plmodel.dart';
import 'package:music_app/Playlists/createplaylist.dart';

class ScreenPlaylist extends StatelessWidget {
  const ScreenPlaylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          title: Text('Playlist'),
          centerTitle: true,
          toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: const [
            Icon(Icons.search),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CreatePlaylist();
                });
          },
        ),
        body: ValueListenableBuilder<Box<PlSongs>>(
          valueListenable: Hive.box<PlSongs>(plboxname).listenable(),
          builder: (BuildContext context, Box<PlSongs> playlistBox, child) {
            List<PlSongs> playlists = playlistBox.values.toList();

            if (playlistBox.isEmpty) {
              return const Center(
                child: Text('No playlists'),
              );
            }

            return ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.done),
                  title: Text(playlists[index].playlistName!),
                  trailing: IconButton(
                    onPressed: () {
                      playlistBox.deleteAt(index);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
