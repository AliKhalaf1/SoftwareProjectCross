import 'package:eventbrite_replica/screens/tab_bar.dart';
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

  //View more on click handler
  void viewMoreEvents(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const TabBarScreen(title: 'Search', tabBarIndex: 1);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
        child: TitleText1(collectionTitle),
      ),
      Column(
        children: collecionListOfEvents.map((e) {
          return EventCard(e);
        }).toList(),
      ),
      collecionListOfEvents.length > 5
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, bottom: 15),
                child: TextButton(
                  onPressed: () => viewMoreEvents(context),
                  child: const Text(
                    'View more events',
                    style: TextStyle(
                        color: Color.fromARGB(255, 16, 84, 211),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          : const SizedBox(
              height: 15,
            ),
    ]);
  }
}
