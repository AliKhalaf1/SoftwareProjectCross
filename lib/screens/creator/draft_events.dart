library DraftEventsScreen;

import 'package:Eventbrite/widgets/draft_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/backgroud.dart';

/// {@category Creator}
/// {@category Screens}
///
/// This Page is used to display the creator's draft events.
class DraftEvents extends StatelessWidget {
  bool tester = true;
  String EventDesc = "event1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tester
          ? ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                DraftCard(
                  '2023-05-25 20:00:00',
                  EventDesc,
                  key: Key(EventDesc),
                ),
                DraftCard(
                  '2023-05-25 20:00:00',
                  EventDesc,
                  key: Key(EventDesc),
                ),
              ],
            )
          : Background("assets/images/draft_events.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, key: Key("AddDraftEvent")),
      ),
    );
  }
}
