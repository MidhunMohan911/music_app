import 'package:flutter/material.dart';
import 'package:music_app/Home/Drawer/drawer.dart';
import 'package:switcher_button/switcher_button.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Container(
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
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white,fontSize: 30),
                ),
              ),
              const SizedBox(height: 10,),
              const Divider(thickness: 3,),
              const SizedBox(height: 10,),
              DrawerRef(
                dIcon: const Icon(
                  Icons.chat_outlined,
                ),
                dText: 'Feedback',
                dTrail: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              DrawerRef(
                dIcon: const Icon(
                  Icons.error_outline,
                ),
                dText: 'About',
                dTrail: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
              DrawerRef(
                dIcon: const Icon(
                  Icons.notifications_outlined,
                ),
                dText: 'Notifications',
                dTrail: SwitcherButton(
                  value: true,
                  size: 30,
                  onChange: (value) {},
                ),
              ),
              DrawerRef(
                dIcon: const Icon(
                  Icons.chat_outlined,
                ),
                dText: 'Share',
                dTrail: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Version',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '10.7.5',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
