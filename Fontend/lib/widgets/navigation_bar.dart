import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mangaaro_app/screens/profile_screen.dart';
import '../screens/home_screen.dart';
import '../screens/favorite_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {

  int _page = 1; //current page index
  final GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _listPages = [
     const Favorites(),
    const MangaHome(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 55.0,
          items: const <Widget>[
            Icon(Icons.bookmark_border_outlined, size: 25),
            Icon(Icons.home_outlined, size: 25),
            Icon(Icons.perm_identity_outlined, size: 25),
          ],
          color: Colors.blue.shade500,
          buttonBackgroundColor: Colors.yellow.shade500,
          backgroundColor: const Color.fromARGB(133, 255, 255, 255),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: _listPages[_page]
    );
  }
}