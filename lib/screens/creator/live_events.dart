import 'package:Eventbrite/widgets/backgroud.dart';
import 'package:flutter/material.dart';

import '../../widgets/live_card.dart';

class LiveEvents extends StatelessWidget {
  const LiveEvents({super.key});
  static const route = '/Liveevents';

  @override
  Widget build(BuildContext context) {
    bool tester = true;
    return Scaffold(
      body: tester
          ? InkWell(
              onTap: () {},
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  LiveCard('2023-05-25 20:00:00', 'event 1', 10, 5, 100),
                  LiveCard('2023-05-25 20:00:00', 'event 1', 10, 0, 20),
                ],
              ),
            )
          : Background("assets/images/live_events.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
