import 'package:eventbrite_replica/screens/favourites_sign_up.dart';
import 'package:flutter/material.dart';
import './profile_sign_up.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

//////////////////////FONTS IMPORT/////////////////////////////
///
///
///
///
///
///
///

///////////////////////////////////////////////////////

class TabBarScreen extends StatefulWidget {
  // const TabBarScreen({super.key});

  //Routing value
  static const tabBarScreenRoute = '/';
  final String title;
  const TabBarScreen({super.key, required this.title});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  var _currentIndex = 0;

  List<Widget> pages = [
    Container(
      alignment: Alignment.center,
      child: const Text('Home'),
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('Search'),
    ),
    const Favourites(),
    Container(
      alignment: Alignment.center,
      child: const Text('tickets'),
    ),
    const ProfileLogIn(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          iconSize: 22,
          elevation: 5,
          backgroundColor: Colors.white,
          selectedIconTheme:
              IconThemeData(color: Theme.of(context).primaryColor),
          unselectedItemColor: const Color.fromARGB(255, 43, 41, 41),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Likes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Typicons.ticket),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_4_outlined),
              label: 'Profile',
            ),
          ]),
      body: pages[_currentIndex],
    );
  }
}