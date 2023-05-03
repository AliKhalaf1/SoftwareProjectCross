library past_events;

import 'package:flutter/material.dart';
import 'package:splash_route/splash_route.dart';

import '../../widgets/backgroud.dart';
import 'event_title.dart';

/// {@category Creator}
/// {@category Screens}
///
/// This Page is used to display the creator's past events.
///
class PastEvents extends StatelessWidget {
  const PastEvents({super.key});
  static const route = '/Pastevents';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background("assets/images/past_events.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            SplashRoute(
              targetPage: EventTitle(),
              splashColor: const Color.fromRGBO(209, 65, 12, 1),
              startFractionalOffset: const FractionalOffset(1.0, 1.0),
              transitionDuration: const Duration(milliseconds: 800),
            ),
          );
        },
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          key: Key("AddPastEvent"),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
