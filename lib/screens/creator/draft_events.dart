import 'package:Eventbrite/widgets/draft_card.dart';
import 'package:Eventbrite/widgets/live_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/backgroud.dart';

class DraftEvents extends StatelessWidget {
  bool tester = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tester
          ? InkWell(
              onTap: () {},
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  DraftCard('2023-05-25 20:00:00', 'event 1'),
                  DraftCard('2023-05-25 20:00:00', 'event 1'),
                ],
              ),
            )
          : Background("assets/images/draft_events.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
