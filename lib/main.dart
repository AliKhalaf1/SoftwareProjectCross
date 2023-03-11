import 'package:flutter/material.dart';
import './screens/signup.dart';
import './screens/tabBarScreen.dart';
import './screens/email_check.dart';
import './screens/findTickets.dart';

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
        primaryColor: const Color.fromARGB(255, 213, 84, 36),
      ),
      // home: const TabBarScreen(title: 'Eventbrite'),
      initialRoute: TabBarScreen.TabBarScreenRoute,
      routes: {
        TabBarScreen.TabBarScreenRoute: (ctx) =>
            const TabBarScreen(title: 'Eventbrite'),
        Signup.signUpRoute: (ctx) => const Signup(),
        EmailCheck.emailCheckRoute: (ctx) => const EmailCheck(),
        FindTickets.findTicketsRoute: (ctx) => const FindTickets(),
      },
    );
  }
}
