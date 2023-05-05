library EventsHelperFunctions;

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
  bool isLogged = await checkLoggedUser();
  Navigator.of(ctx).pushNamed(
    EventPage.eventPageRoute,
    arguments: {'eventId': event.id, 'isLogged': isLogged},
  );
}
