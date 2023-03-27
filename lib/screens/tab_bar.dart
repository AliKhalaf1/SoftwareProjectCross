import 'package:eventbrite_replica/screens/guest/favourites_sign_up.dart';
import 'package:eventbrite_replica/screens/guest/tickets_sign_up.dart';
import 'package:eventbrite_replica/screens/user/profile.dart';
import 'package:flutter/material.dart';
import 'guest/profile_sign_up.dart';
import 'guest/home.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/user/profile.dart';
import '../models/db_mock.dart';
import '../models/user.dart';

class TabBarScreen extends StatefulWidget {
  // const TabBarScreen({super.key});

  //Routing value
  static const tabBarScreenRoute = '/';
  final String title;
  int tabBarIndex;
  TabBarScreen({super.key, required this.title, this.tabBarIndex = 0});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState(tabBarIndex);
}

class _TabBarScreenState extends State<TabBarScreen> {
  Future<void> checkLoggedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status == true) {
      var email = prefs.getString('email') ?? '';
      User user = DBMock.getUserData(email);

      setState(() {
        widget.tabBarIndex = 4;
        pages = [
          Home(10),
          Container(
            alignment: Alignment.center,
            child: const Text('Search'),
          ),
          const FavouritesSignUp(),
          const TicketsSignUp(),
          Profile(
            user.firstName,
            user.lastName,
            user.imageUrl,
            user.email,
            0,
            0,
            0,
            checkLoggedUser,
          ),
        ];
      });
    } else {
      setState(() {
        pages = [
          Home(10),
          Container(
            alignment: Alignment.center,
            child: const Text('Search'),
          ),
          const FavouritesSignUp(),
          const TicketsSignUp(),
          const ProfileSignUp(),
        ];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoggedUser();
  }

  var _currentIndex = 0;

  List<Widget> pages = [
    Home(10),
    Container(
      alignment: Alignment.center,
      child: const Text('Search'),
    ),
    const FavouritesSignUp(),
    const TicketsSignUp(),
    const ProfileSignUp(),
  ];

  _TabBarScreenState(this._currentIndex);

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