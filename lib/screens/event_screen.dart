import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../models/event.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

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
      body: EventCard(event),
    );
  }
}