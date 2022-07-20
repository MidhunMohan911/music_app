import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:music_app/Model/favmodel.dart';
import 'package:music_app/Model/model.dart';
import 'package:music_app/Model/plmodel.dart';
import 'package:music_app/Splash%20Screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);

  Hive.registerAdapter(FavSongsAdapter());
  await Hive.openBox<FavSongs>(favboxname);

  Hive.registerAdapter(PlSongsAdapter());
  await Hive.openBox<PlSongs>(plboxname); 


  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}
