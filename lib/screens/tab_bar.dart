library BottomNavBar;

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/screens/user/favourites.dart';
import 'package:Eventbrite/screens/user/tickets_tab_bar.dart';
import 'package:Eventbrite/widgets/loading_spinner.dart';
import 'package:provider/provider.dart';

import '../../screens/guest/favourites_sign_up.dart';
import '../../screens/guest/tickets_sign_up.dart';
import '../../screens/user/profile.dart';
import 'package:flutter/material.dart';
import '../providers/filters/filter_selection_values.dart';
import '../providers/filters/tags.dart';
import 'guest/profile_sign_up.dart';
import 'guest/home.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/db_mock.dart';
import '../models/user.dart';
import 'search_screen.dart';

/// {@category User}
/// {@category Screens}
///
/// This is the main screen of the app.
///
/// It contains a [BottomNavigationBar] that allows the user to navigate between the app's main screens.
///
/// The screens are:
///
/// * [Home]
///
/// * [TicketsSignUp]
///
/// * [FavouritesSignUp]
///
/// * [Search]
///
/// * [Profile]
///
/// The [Home] screen is the default screen.
///
class TabBarScreen extends StatefulWidget {
  // const TabBarScreen({super.key});

  //Routing value
  static const tabBarScreenRoute = '/tabBar';
  final String title;
  int tabBarIndex;
  bool isLoading = false;
  TabBarScreen({super.key, required this.title, this.tabBarIndex = 0});

  @override
  State<TabBarScreen> createState() => TabBarScreenState(tabBarIndex);
}

/// {@category User}
/// {@category Screens}
///
class TabBarScreenState extends State<TabBarScreen> {
  Future<void> checkLoggedUser() async {
    widget.isLoading = true;
    String token = await getToken();

    print('tab_bar token: $token');

    bool isLoggedIn = await checkToken(token);
    widget.isLoading = false;
    //bool isLoggedIn = token.isNotEmpty;
    print('tab_bar isLoggedIn: $isLoggedIn');
    if (isLoggedIn) {
      setState(() {
        widget.tabBarIndex = 4;
        pages = [
          Home(),
          const Search(),
          Favourites(),
          TicketsTabBar(),
          Profile(
            checkLoggedUser,
          ),
        ];
      });
    } else {
      setState(() {
        pages = [
          Home(),
          const Search(),
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
    Home(),
    const Search(),
    const FavouritesSignUp(),
    const TicketsSignUp(),
    const ProfileSignUp(),
  ];

  TabBarScreenState(this._currentIndex);

  @override
  Widget build(BuildContext context) {
    final tagsData = Provider.of<Tags>(context);
    final filtersDataValues = Provider.of<FilterSelectionValues>(context);

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
              if (index == 1) {
                tagsData.resetTags();
                filtersDataValues.resetSelectionValues();
              }
              _currentIndex = index;
            });
          },
          key: const Key('bottom_nav_bar'),
          items: const [
            BottomNavigationBarItem(
              tooltip: 'Home',
              backgroundColor: Colors.white,
              icon: Icon(Icons.home_outlined, key: Key('home')),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              tooltip: 'Search',
              icon: Icon(Icons.search, key: Key('search')),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              tooltip: 'Favourites',
              icon: Icon(Icons.favorite_border, key: Key('favourites')),
              label: 'Likes',
            ),
            BottomNavigationBarItem(
              tooltip: 'Tickets',
              icon: Icon(
                CommunityMaterialIcons.ticket_confirmation_outline,
                key: Key('tickets'),
              ),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              tooltip: 'Profile',
              icon: Icon(Icons.person_outline_rounded, key: Key('profile')),
              label: 'Profile',
            ),
          ]),
      body: widget.isLoading ? const LoadingSpinner() : pages[_currentIndex],
    );
  }
}
