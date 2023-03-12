import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/sign_up.dart';
import 'screens/tab_bar_screen.dart';
import './screens/email_check.dart';
import 'screens/find_tickets.dart';

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
            const TabBarScreen(title: 'Eventbrite'),
        Signup.signUpRoute: (ctx) => const Signup(),
        EmailCheck.emailCheckRoute: (ctx) => EmailCheck(),
        FindTickets.findTicketsRoute: (ctx) => const FindTickets(),
      },
    );
  }
}
