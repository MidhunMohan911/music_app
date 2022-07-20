import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:music_app/Controller/controller.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Model/plmodel.dart';

class CreatePlaylist extends StatelessWidget {
  CreatePlaylist({Key? key}) : super(key: key);

  List<PlSongs> playlists = [];
  late Box<PlSongs> plBox;
  final formkey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    plBox = Hive.box<PlSongs>(plboxname);
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        'Playlist Name',
        style: TextStyle(color: Colors.white70, fontSize: 16),
      ),
      content: Form(
          key: formkey,
          child: TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                hintText: 'Enter a playlistName',
                fillColor: Colors.white70,
                filled: true),
            validator: (value) {
              List<PlSongs> values = plBox.values.toList();

              bool isAlreadyused = values
                  .where((element) => element.playlistName == value!.trim())
                  .isNotEmpty;

              if (value!.trim() == '') {
                return 'Name required';
              }
              if (isAlreadyused) {
                return 'This Name Already Exist';
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
            GetBuilder<Controller>(
                init: Controller(),
                builder: (getcontrlr) {
                  return TextButton(
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          // getcontrlr.addPlaylist()
                          Navigator.pop(context);
                          getcontrlr.createPlaylist(PlSongs(
                            playlistName: controller.text,
                            playlistSongs: [],
                          ));

                          // plBox.add(
                          //   PlSongs(
                          //     playlistName: controller.text,
                          //     playlistSongs: [],
                          //   ),
                          // );

                        }
                      },
                      child: const Text(
                        'save',
                        style: TextStyle(color: Colors.white70),
                      ));
                })
          ],
        )
      ],
    );
  }
}
