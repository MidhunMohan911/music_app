import 'package:flutter/material.dart';
import 'package:music_app/dialogs/policy.dart';
import 'package:share_plus/share_plus.dart';
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
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      shadows: [Shadow(color: Colors.red, blurRadius: 15)]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 3,
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text(
                  'Share',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  Share.share(
                      'https://github.com/MidhunMohan911/music_app.git');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.notifications_active_outlined,
                ),
                title: const Text(
                  'Notification',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                trailing: SwitcherButton(
                  value: true,
                  size: 27,
                  onChange: (value) {},
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return Policy(mdFilename: 'privacy_policy.md');
                      });
                },
              ),
              ListTile(
                leading: const Icon(Icons.verified_user_outlined),
                title: const Text(
                  'Terms & Conditions',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (builder) {
                        return Policy(mdFilename: 'terms_&_condition.md');
                      });
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text(
                  'About',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const About(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Version',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '2.7.5',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w300),
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

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
            primaryColorDark: Colors.white70,
            cardColor: Colors.white70,
            backgroundColor: Colors.white70,
            accentColor: Colors.black),
      ),
      child: LicensePage(
        applicationIcon: Image.asset(
          'assets/1.png',
          width: 200,
          height: 200,
        ),
        applicationVersion: '2.7.5',
        applicationLegalese: 'Developed by MIDHUN M',
      ),
    );
  }
}
