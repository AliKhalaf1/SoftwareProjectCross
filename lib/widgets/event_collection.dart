library EventCollection;

import 'package:provider/provider.dart';

import '../../screens/tab_bar.dart';
import '../../widgets/title_text_1.dart';
import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../providers/events/event.dart';

/// {@category Widgets}
/// Collection of events with similar categorey.
///
class EventCollections extends StatelessWidget {
  //Data needed to render the categoryscreen and taken from home screen
  final String collectionTitle;
  final bool parent; //1: home and 0:search
  final List<Event> collecionListOfEvents;

  /// It takes:
  ///
  ///   • Collection title
  ///
  ///   • List of events
  ///
  const EventCollections(
      this.collectionTitle, this.parent, this.collecionListOfEvents,
      {super.key});

  //View more on click handler
  void viewMoreEvents(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return TabBarScreen(title: 'Search', tabBarIndex: 1);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      parent
          ? Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
              child: TitleText1(collectionTitle),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 15, bottom: 10),
                child: Text(
                  collectionTitle,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 20,
                      height: 0.9,
                      letterSpacing: 1.3,
                      fontFamily: 'Neue Plak Extended',
                      fontWeight: FontWeight.w100,
                      color: Colors.black),
                ),
              ),
            ),
      Column(
        children: collecionListOfEvents.map((e) {
          return ChangeNotifierProvider.value(value: e, child: EventCard());
        }).toList(),
      ),
      (collecionListOfEvents.length > 5 && parent)
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
