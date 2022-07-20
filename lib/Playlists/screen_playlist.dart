import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/Controller/controller.dart';
import 'package:music_app/Model/plmodel.dart';
import 'package:music_app/Playlists/createplaylist.dart';
import 'package:music_app/Playlists/playlistpage.dart';

class ScreenPlaylist extends StatelessWidget {
  ScreenPlaylist({Key? key}) : super(key: key);

  List<PlSongs> plSongs = [];
  // late Box<PlSongs> plBox;
  final formkey = GlobalKey<FormState>();

  final playlistBox = Hive.box<PlSongs>(plboxname);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
          title: const Text(
            'Playlists',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                shadows: [
                  Shadow(
                    blurRadius: 14,
                    color: Colors.red,
                  )
                ]),
          ),
          centerTitle: true,
          // toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.playlist_add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return CreatePlaylist();
                });
          },
        ),
        body: GetBuilder<Controller>(
          init: Controller(),
          builder: (controller) {
            List<PlSongs> playlists = playlistBox.values.toList();
            if (playlistBox.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: height * .35),
                    const Text('No playlists')
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                TextEditingController textController =
                    TextEditingController(text: playlists[index].playlistName);
                return Slidable(
                  endActionPane:
                      ActionPane(motion: const StretchMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  backgroundColor: Colors.black,
                                  content: const Text(
                                    'Do you Really want to delete ?',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        controller.deletePlaylist(index);
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'No',
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                    ),
                                  ],
                                ));
                      },
                      backgroundColor: const Color.fromARGB(255, 93, 18, 13),
                      foregroundColor: Colors.white,
                      icon: CupertinoIcons.delete_simple,
                      label: 'Delete',
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.black26,
                            title: const Text(
                              'Edit your playlist name',
                              style: TextStyle(color: Colors.white70),
                            ),
                            content: Form(
                                key: formkey,
                                child: TextFormField(
                                  controller: textController,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                      hintText: 'Enter a playlistName',
                                      fillColor: Colors.white70,
                                      filled: true),
                                  validator: (value) {
                                    List<PlSongs> values =
                                        playlistBox.values.toList();

                                    if (value!.trim() == '') {
                                      return 'Name required';
                                    }

                                    return null;
                                  },
                                )),
                            actions: [
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'cancel',
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {
                                        PlSongs? playlistDetails =
                                            playlistBox.getAt(index);

                                        if (formkey.currentState!.validate()) {
                                          controller.editPlaylist(
                                            index,
                                            PlSongs(
                                              playlistName: textController.text,
                                              playlistSongs: playlistDetails!
                                                  .playlistSongs,
                                            ),
                                          );

                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text(
                                        'save',
                                        style: TextStyle(color: Colors.white70),
                                      ))
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      icon: CupertinoIcons.tag,
                      label: 'Rename',
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                    )
                  ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 35, 26, 80),
                              Color.fromARGB(255, 31, 5, 125),
                              Color.fromARGB(255, 28, 2, 65)
                            ],
                            tileMode: TileMode.clamp,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListTile(
                          leading: const Text(
                            '🎧',
                            style: TextStyle(fontSize: 20),
                          ),
                          title: Text(
                            playlists[index].playlistName!,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 17),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PlaylistPage(
                                playlistName: playlists[index].playlistName!,
                                allSongs: playlists[index].playlistSongs!,
                                indexx: index,
                              ),
                            ));
                          },
                        ),
                      ),
                    ),
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
