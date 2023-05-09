library EventPromocodeHelperFunctions;

import '../models/event_promocode.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

Future<EventPromocodeInfo> getEventPrmocodeInfo(String eventId) async {
  // To Be: Remove initialization
  EventPromocodeInfo eventPromo = EventPromocodeInfo('',
      '', false, 0, false, 0.0, DateTime.now(), DateTime.now());
      
  return eventPromo;
}
