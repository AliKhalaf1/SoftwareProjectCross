library EventsHelperFunctions;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/event_page.dart';
import '../screens/sign_up/sign_up_or_log_in.dart';

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

