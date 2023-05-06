library EventPromocodeHelperFunctions;

import '../models/event_promocode.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

Future<EventPromocodeInfo> getEventPrmocodeInfo(String eventId) async {
  // To Be: Remove initialization
  EventPromocodeInfo eventPromo = EventPromocodeInfo(
      '', false, 0, 'value', 0, DateTime.now(), DateTime.now());

  // To Be: parse API url in uri
  // var uri = Uri.parse('${Constants.host}/users/me/eventId');

  // To Be: Put reqHeaders
  //create multipart request
  // Map<String, String> reqHeaders = {
  //   'Authorization': 'Bearer ${eventId}',
  // };
  // var response = await http.get(
  //   uri,
  //   headers: reqHeaders,
  // );

  // print(response.statusCode);

  // To Be: if response is 200 get data and put it in class eventTickets
  // To Be: Dont forget to parse the end_date of ticket from string to DateTime
  // if (response.statusCode == 200) {
  // var data = json.decode(response.body);
  // eventTickets.names = /*list of names */;
  // eventTickets.types = /*list of types */;
  // eventTickets.avaliableQuantaties = /*list of quantaties */;
  // eventTickets.durations = /*list of durations */;
  // return eventTickets;
  // } else {}
  return eventPromo;
}
