import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './profile_sign_up.dart';

class TabBarScreen extends StatefulWidget {
  // const TabBarScreen({super.key});

  //Routing value
  static final TabBarScreenRoute = '/';
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
    Container(
      alignment: Alignment.center,
      child: const Text('Likes'),
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('tickets'),
    ),
    const ProfileLogIn(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
          iconSize: 22,
          elevation: 5,
          backgroundColor: Colors.white,
          selectedIconTheme: const IconThemeData(color: Colors.deepOrange),
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
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_forward_ios),
              label: 'Likes',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.ticket),
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
