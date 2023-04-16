library EventCollection;

import 'package:Eventbrite/widgets/fav_event_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../screens/tab_bar.dart';
import '../../widgets/title_text_1.dart';
import 'package:flutter/material.dart';
import '../widgets/event_card.dart';
import '../providers/events/event.dart';

/// {@category Widgets}
/// Collection of Favourite events with similar categorey.
///
class FavEventCollection extends StatelessWidget {
  //Data needed to render the categoryscreen and taken from home screen
  final String collectionTitle;
  final List<Event> collecionListOfEvents;

  /// It takes:
  ///
  ///   • Collection title
  ///
  ///   • List of events
  ///
  const FavEventCollection(this.collectionTitle, this.collecionListOfEvents,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15, bottom: 5),
          child: Text(
            collectionTitle,
            style: GoogleFonts.roboto(
              fontSize: 20,
              height: 0.9,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ),
        ),
        Column(
          children: collecionListOfEvents.map((e) {
            return ChangeNotifierProvider.value(
                value: e, child: FavouriteEventCard());
          }).toList(),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
