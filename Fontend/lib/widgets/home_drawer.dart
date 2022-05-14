import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../screens/help_screen.dart';
import '../services/authservice.dart';
import '../widgets/settings.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({ Key? key }) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
  return Drawer(
      child: Material(
        color: const Color.fromARGB(235, 6, 50, 228),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            drawerHeader(),
            Container(
              padding: padding,
              width: double.infinity,
              child: Column(
                children: [
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 30),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 30),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 20),
                  buildMenuItem(
                    text: 'Help',
                    icon: Icons.help_outline_outlined,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 20),
                  buildMenuItem(
                    text: 'Log Out',
                    icon: Icons.logout_sharp,
                    onClicked: () {
                      AuthService().signOut(context);
                    }
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerHeader() =>
      InkWell(
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 50)),
          child: Column(
            children: [
              const CircleAvatar(radius: 40, backgroundImage: AssetImage('assets/images/Anime.jpg')),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${loggedInUser.displayName}",
                    style: const TextStyle(fontSize: 18, color: Colors.white,
                    fontFamily: 'Trueno'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SettingsScreen(),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HelpScreen(),
        ));
        break;
    }
  }
}