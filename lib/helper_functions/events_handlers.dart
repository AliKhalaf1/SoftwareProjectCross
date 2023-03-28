library EventsHelperFunctions;

import 'package:flutter/material.dart';
import '../screens/event_page.dart';

/// {@category Helper Functions}
/// Navigate to event page and render selected event
///
/// Used inside EventCard widget
///
void selectEvent(BuildContext ctx) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return const EventPage();
  }));
}
