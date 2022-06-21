import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:music_app/Model/plmodel.dart';
import 'package:music_app/Playlists/createplaylist.dart';
import 'package:music_app/Playlists/playlistpage.dart';

class ScreenPlaylist extends StatefulWidget {
  const ScreenPlaylist({Key? key}) : super(key: key);

  @override
  State<ScreenPlaylist> createState() => _ScreenPlaylistState();
}

class _ScreenPlaylistState extends State<ScreenPlaylist> {
  List<PlSongs> plSongs = [];
  late Box<PlSongs> plBox;
  final formkey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    plBox = Hive.box<PlSongs>(plboxname);
  }

  @override
  Widget build(BuildContext context) {
    // controller.text="sjmsl";
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
          title: const  Text('Playlists',

            style: TextStyle(
               fontWeight: FontWeight.w400,
               fontStyle: FontStyle.italic,
              shadows: [
                Shadow(
                  blurRadius: 14,
                  color: Colors.red,
                )
              ]
            ),),
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
                  return const CreatePlaylist();
                });
          },
        ),
        body: ValueListenableBuilder<Box<PlSongs>>(
          valueListenable: Hive.box<PlSongs>(plboxname).listenable(),
          builder: (BuildContext context, Box<PlSongs> playlistBox, _) {
            List<PlSongs> playlists = playlistBox.values.toList();

            if (playlistBox.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: height * .35),
                    // Lottie.network(
                    //   'https://assets2.lottiefiles.com/packages/lf20_mmwivxcd.json',
                    //   width: 30,
                    //   height: 30,
                    // ),
                    const Text('No playlists')
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                controller.text = playlists[index].playlistName!;
                return Slidable(
                  endActionPane:
                      ActionPane(motion: const StretchMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
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
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'No',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            playlistBox.deleteAt(index);
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Yes',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                      ),
                                    ],
                                  ));
                        });
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
                        setState(() {
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
                                    // initialValue: playlists[index].playlistName,
                                    controller: controller,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: const InputDecoration(
                                        hintText: 'Enter a playlistName',
                                        fillColor: Colors.white70,
                                        filled: true),
                                    validator: (value) {
                                      List<PlSongs> values =
                                          plBox.values.toList();

                                      // bool isAlreadyused = values
                                      //     .where((element) =>
                                      //         element.playlistName ==
                                      //         value!.trim())
                                      //     .isNotEmpty;

                                      if (value!.trim() == '') {
                                        return 'Name required';
                                      }
                                      // if (isAlreadyused) {
                                      //   return 'This Name Already Exist';
                                      // }
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
                                          if (formkey.currentState!
                                              .validate()) {
                                            plBox.putAt(
                                                index,
                                                PlSongs(
                                                    playlistName:
                                                        controller.text,
                                                    playlistSongs: []));

                                            // plBox.add(
                                            //   PlSongs(
                                            //     playlistName: controller.text,
                                            //     playlistSongs: [],
                                            //   ),
                                            // );

                                            Navigator.pop(context);
                                            // setState(() {});
                                          }
                                        },
                                        child: const Text(
                                          'save',
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          );
                        });
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
                                index: index,
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

  update() async {
    return await plBox.add(
      PlSongs(
        playlistName: controller.text,
        playlistSongs: [],
      ),
    );
  }
}
