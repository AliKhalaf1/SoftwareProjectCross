import 'package:eventbrite_replica/widgets/title_text_1.dart';
import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../models/event.dart';

class EventCollections extends StatelessWidget {
  //Data needed to render the categoryscreen and taken from home screen
  final String collectionTitle;
  final List<Event> collecionListOfEvents;

  const EventCollections(this.collectionTitle, this.collecionListOfEvents,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
        child: TitleText1(collectionTitle),
      ),
      Column(
        children: collecionListOfEvents.map((e) {
          return EventCard(e);
        }).toList(),
      )
    ]);
  }
}
