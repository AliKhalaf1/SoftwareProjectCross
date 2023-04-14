import 'package:Eventbrite/screens/user/past_events.dart';
import 'package:flutter/material.dart';

import 'screens/sign_up/sign_up_or_log_in.dart';
import 'screens/tab_bar.dart';
import 'screens/sign_in/email_check.dart';
import './screens/find_tickets.dart';
import 'widgets/tab_bar_Events.dart';

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
        // This is the theme of your application.

        fontFamily: 'Neue Plack Extended',
        primaryColor: const Color.fromARGB(255, 209, 65, 12),
      ),

      // home: const TabBarScreen(title: 'Eventbrite'),
      initialRoute: TabBarScreen.tabBarScreenRoute,
      routes: {
        TabBarScreen.tabBarScreenRoute: (ctx) =>
            TabBarScreen(title: 'Eventbrite', tabBarIndex: 0),
        SignUpOrLogIn.signUpRoute: (ctx) => const SignUpOrLogIn(),
        EmailCheck.emailCheckRoute: (ctx) => EmailCheck(),
        FindTickets.findTicketsRoute: (ctx) => const FindTickets(),
        TabBarEvents.route: (ctx) => TabBarEvents(),
        PastEvents.route: (context) => PastEvents(),
      },
    );
  }
}
