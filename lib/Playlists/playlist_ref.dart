
import 'package:flutter/material.dart';
import 'package:music_app/Home/screen_home.dart';

class PlaylistRef extends StatelessWidget {
  final dynamic plImage;
  final String plText;
  final dynamic plIcon;

  const PlaylistRef({
    Key? key,
    required this.plImage,
    required this.plText,
    this.plIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        width: 50,
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            plImage,
            fit: BoxFit.fill,
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: ((context) => ScreenHome()),),);
      },
      title: Text(
        plText,
        style: const TextStyle(
            fontSize: 23, fontWeight: FontWeight.w400, color: Colors.white),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              plIcon,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {  },
             
          ),
        ],
      ),
    );
  }
}
