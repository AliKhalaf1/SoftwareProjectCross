library EventTicketsHelperFunctions;

import '../models/event_ticket.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

/// {@category Helper Functions}
///
/// To Be: first list: list of free tickets of event / second list: list of vip tickets of event
Future<List<List<EventTicketInfo>>> getEventTicketsInfo(String eventId) async {
  /// Notice that eventTickets is list of only 2 list one for freeTickets and one for vipTickets
  List<List<EventTicketInfo>> eventTickets = [];
  List<EventTicketInfo> eventFreeTicketsData = [];
  List<EventTicketInfo> eventVipTicketsData = [];

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

  eventTickets.add(eventFreeTicketsData);
  eventTickets.add(eventVipTicketsData);
  return eventTickets;
}
