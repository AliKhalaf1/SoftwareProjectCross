import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../models/event.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Event event = Event(
        123,
        DateTime.now(),
        'description',
        'https://cdn.evbstatic.com/s3-build/fe/build/images/7240401618ed7526be7cec3b43684583-2_tablet_1067x470.jpg',
        'eventRoute',
        EventState.online);
    return Scaffold(
      body: Column(
        children: [
        const Text("Title"),
        SizedBox(
          height: 700,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return EventCard(event);
            },
            itemCount: 7, //length of the list
          ),
        ),
      ]),
    );
  }
}
