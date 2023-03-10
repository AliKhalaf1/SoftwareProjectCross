import 'package:eventbrite_replica/screens/tabBarScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './screens/profile_sign_up.dart';
import './screens/signup.dart';
import './screens/tabBarScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eventbrite',
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.deepOrange,
      ),
      // home: const TabBarScreen(title: 'Eventbrite'),
      initialRoute: TabBarScreen.TabBarScreenRoute,
      routes: {
        TabBarScreen.TabBarScreenRoute: (ctx) => const TabBarScreen(title: 'Eventbrite'),
        Signup.signUpRoute:(ctx) => const Signup(),
      },
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   var _currentIndex = 0;

//   List<Widget> pages = [
//     Container(
//       alignment: Alignment.center,
//       child: const Text('Home'),
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: const Text('Search'),
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: const Text('Likes'),
//     ),
//     Container(
//       alignment: Alignment.center,
//       child: const Text('tickets'),
//     ),
//     const ProfileLogIn(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//           landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
//           iconSize: 22,
//           elevation: 5,
//           backgroundColor: Colors.white,
//           selectedIconTheme: const IconThemeData(color: Colors.deepOrange),
//           unselectedItemColor: const Color.fromARGB(255, 43, 41, 41),
//           showSelectedLabels: false,
//           showUnselectedLabels: false,
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search),
//               label: 'Search',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.arrow_forward_ios),
//               label: 'Likes',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(CupertinoIcons.ticket),
//               label: 'Tickets',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_4_outlined),
//               label: 'Profile',
//             ),
//           ]),
//       body: pages[_currentIndex],
//     );
//   }
// }
