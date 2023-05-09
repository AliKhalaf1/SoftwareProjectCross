library EventsHelperFunctions;

import 'package:Eventbrite/models/liked_event_card_model.dart';
import 'package:flutter/material.dart';
import '../screens/event_page.dart';
import '../providers/events/event.dart';
import 'log_in.dart';

/// {@category Helper Functions}
/// Navigate to event page and render selected event
///
/// Used inside EventCard widget
///
/// Get token if logged user or not and event id then sent them as an arguments to naviated screen
Future<void> selectEvent(BuildContext ctx, Event event) async {
  checkLoggedUser().then((isLogged) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return EventPage(event.id, isLogged);
    }));
  });

  // Navigator.of(ctx).pushNamed(
  //   EventPage.eventPageRoute,
  //   arguments: {'eventId': event.id, 'isLogged': isLogged},
  // );
}

Future<void> selectFavEvent(BuildContext ctx, LikedEventCardModel event) async {
  checkLoggedUser().then((isLogged) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return EventPage(event.id, isLogged);
    }));
  });
}
