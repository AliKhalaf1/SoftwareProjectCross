library EventTicketsHelperFunctions;

import '../models/event_ticket.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'log_in.dart';

/// {@category Helper Functions}
///
/// To Be: first list: list of free tickets of event / second list: list of vip tickets of event
Future<List<List<EventTicketInfo>>> getEventTicketsInfo(String eventId) async {
  /// Notice that eventTickets is list of only 2 list one for freeTickets and one for vipTickets
  List<List<EventTicketInfo>> eventTickets = [];
  List<EventTicketInfo> eventFreeTicketsData = [];
  List<EventTicketInfo> eventVipTicketsData = [];

  var uri = Uri.parse('${Constants.host}/tickets/event_id/$eventId');
  var token = await getToken();
  print(uri);
  var response = await http.get(
    uri,
  );

  var resCode = response.statusCode;
  print('-----------------');
  print("ResCode:");
  print(resCode);
  print('-----------------');
  if (resCode == 200) {
    var resBody = response.body;
    var resData = jsonDecode(resBody);
    // print('**************************************************************');
    // print(resData[i]['id']);
    // print(resData[i]['date_and_time']['start_date_time']);
    // print(resData[i]['date_and_time']['end_date_time']);
    // print(resData[i]['date_and_time']['end_date_time']);
    // print(resData[i]['description']);
    // print(resData[i]['image_link']);
    // print(resData[i]['location']['is_online']);
    // print(resData[i]['location']['is_online']);
    // print(resData[i]['basic_info']['category']);
    // print(resData[i]['basic_info']['title']);
    // print(resData[i]['basic_info']['organizer']);
    // print(resData[i]['state']['is_public']);
    // print('**************************************************************');
    if (resData.length > 0) {
      for (int i = 0; i < resData.length; i++) {
        // If free
        if (resData[i]['type'] == "regular") {
          eventFreeTicketsData.add(EventTicketInfo(
              resData[i]['id'],
              resData[i]['type'],
              resData[i]['name'],
              resData[i]['price'],
              DateTime.parse(resData[i]['sales_start_date_time']),
              DateTime.parse(resData[i]['sales_end_date_time']),
              resData[i]['available_quantity']));
        }
        // If Vip
        else {
          eventVipTicketsData.add(EventTicketInfo(
              resData[i]['id'],
              resData[i]['type'],
              resData[i]['name'],
              resData[i]['price'],
              DateTime.parse(resData[i]['sales_start_date_time']),
              DateTime.parse(resData[i]['sales_end_date_time']),
              resData[i]['available_quantity']));
        }
      }
    }
  } else {}

  eventTickets.add(eventFreeTicketsData);
  eventTickets.add(eventVipTicketsData);
  return eventTickets;
}
