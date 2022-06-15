import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class FavoriteRef extends StatelessWidget {
  final  favImage;
  final  favTitle;
  final  favArtist;

  const FavoriteRef({
    Key? key,
    required this.favImage,required this.favTitle,required this.favArtist,
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
        child: Image.asset(
          favImage,
          fit: BoxFit.fill,
        ),
      ),
      
      title: Text(
        favTitle,
        style: const TextStyle(
            fontSize: 23, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      subtitle: Text(
        favArtist,
        style: const TextStyle(fontSize: 20, color: Colors.white),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FavoriteButton(
            isFavorite: false,
            iconColor: Colors.red,
            iconSize: 40,
            iconDisabledColor: Colors.grey,
            valueChanged: (_isFavorite){
              print('Is Favorite : $_isFavorite');
            }),
          
          IconButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    height: 100,
                    color: const Color.fromARGB(255, 87, 50, 113),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'Add to playlist',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.playlist_add))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
