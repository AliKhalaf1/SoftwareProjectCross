library EventsHelperFunctions;

import 'package:flutter/material.dart';
import '../screens/event_page.dart';
import '../providers/event.dart';

/// {@category Helper Functions}
/// Navigate to event page and render selected event
///
/// Used inside EventCard widget
///
void selectEvent(BuildContext ctx, Event event) {
  Navigator.of(ctx).pushNamed(
              EventPage.eventPageRoute,
              arguments: event.id,
            );
}
