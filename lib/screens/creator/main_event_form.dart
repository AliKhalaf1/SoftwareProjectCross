import 'package:Eventbrite/screens/user/profile.dart';

import '../../widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../../widgets/tab_bar_Events.dart';

class EventForm extends StatefulWidget {
  const EventForm({super.key});
  static const route = '/maineventsform';

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        int count = 0;
        Navigator.pushNamedAndRemoveUntil(
          context,
          TabBarEvents.route,
          (route) => count++ == 2 || route.isFirst,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                int count = 0;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  TabBarEvents.route,
                  (route) => count++ == 2 || route.isFirst,
                );
              },
              icon: Icon(Icons.cancel_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.upload),
            )
          ],
        ),
        drawer: EventDrawer(),
      ),
    );
  }
}
