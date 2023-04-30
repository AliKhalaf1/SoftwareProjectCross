library live_events;

import 'package:Eventbrite/screens/creator/event_title.dart';
import 'package:Eventbrite/widgets/backgroud.dart';
import 'package:flutter/material.dart';
import 'package:splash_route/splash_route.dart';

import '../../widgets/live_card.dart';

/// {@category Creator}
/// {@category Screens}
///
/// This Page is used to display the creator's live events.
///
/// It takes the context of the page as a parameter.
///
/// It then pushes the TabBarEvents page to the Navigator.
class LiveEvents extends StatelessWidget {
  const LiveEvents({super.key});
  static const route = '/Liveevents';

  @override
  Widget build(BuildContext context) {
    bool tester = true;
    String EventDesc = "event";
    return Scaffold(
      body: tester
          ? ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                LiveCard(
                  '2023-05-25 20:00:00',
                  EventDesc,
                  10,
                  5,
                  100,
                  key: Key(EventDesc),
                ),
                LiveCard(
                  '2023-05-25 20:00:00',
                  EventDesc,
                  10,
                  0,
                  20,
                  key: Key(EventDesc),
                ),
              ],
            )
          : Background("assets/images/live_events.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(SplashRoute(
            targetPage: EventTitle(),
          ));
        },
        tooltip: 'Increment',
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, key: Key("AddLiveEvent")),
      ),
    );
  }
}
