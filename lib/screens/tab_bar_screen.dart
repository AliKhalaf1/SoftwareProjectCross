import 'package:eventbrite_replica/screens/favourites_sign_up.dart';
import 'package:eventbrite_replica/screens/tickets_sign_up.dart';
import 'package:flutter/material.dart';
import './profile_sign_up.dart';
import '../screens/home.dart';
import 'package:community_material_icon/community_material_icon.dart';

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
    GridView(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: double.infinity),
        children: const [
          Home(),
        ]),
    Container(
      alignment: Alignment.center,
      child: const Text('Search'),
    ),
    const Favourites(),
    const Tickets(),
    const ProfileLogIn(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
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
              icon: Icon(CommunityMaterialIcons.ticket_confirmation_outline),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profile',
            ),
          ]),
      body: pages[_currentIndex],
    );
  }
}
