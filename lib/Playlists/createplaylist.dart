import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Model/plmodel.dart';

class CreatePlaylist extends StatefulWidget {
  const CreatePlaylist({Key? key}) : super(key: key);

  @override
  State<CreatePlaylist> createState() => _CreatePlaylistState();
}

class _CreatePlaylistState extends State<CreatePlaylist> {
  List<PlSongs> playlists = [];
  late Box<PlSongs> plBox;
  final formkey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    plBox = Hive.box<PlSongs>(plboxname);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: const Text(
        'Playlist Name',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      content: Form(
          key: formkey,
          child: TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
                hintText: 'Enter a playlistName',
                fillColor: Colors.white,
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
                style: TextStyle(color: Colors.white),
              ),
            ),
            const Spacer(),
            TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    plBox.add(
                      PlSongs(
                        playlistName: controller.text,
                        playlistSongs: [],
                      ),
                    );

                    Navigator.pop(context);
                    // setState(() {});
                  }
                },
                child: const Text(
                  'save',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        )
      ],
    );
  }
}
