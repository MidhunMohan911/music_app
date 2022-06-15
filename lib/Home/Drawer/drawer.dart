import 'package:flutter/material.dart';

class DrawerRef extends StatelessWidget {
  final dynamic dIcon;
  final String dText;
  final dynamic dTrail;
  final dynamic dTrailColor;

  const DrawerRef({Key? key,required this.dIcon,required this.dText, this.dTrail, this.dTrailColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(icon: dIcon,color: Colors.black,iconSize: 30,
      onPressed: () {  },
      ),
      title: Text(dText,style: const TextStyle(fontSize: 17,color: Colors.white),),
      trailing: dTrail,
      
    );
  }
}
