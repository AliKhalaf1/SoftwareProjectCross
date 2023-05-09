import 'dart:convert';

import 'package:Eventbrite/providers/createevent/createevent.dart';
import 'package:Eventbrite/providers/events/event.dart';
import 'package:intl/intl.dart';

import '../providers/getevent/getevent.dart';
import 'constants.dart';
import 'log_in.dart';
import 'package:http/http.dart' as http;

Future<List<Event>> search(
    String city,
    String isOnline,
    String isfree,
    String title,
    DateTime start_date,
    DateTime end_date,
    String Category) async {
  // Events of certein categorey
  List<Event> categoreyEvents = [];
  // Event catEvent = Event('', DateTime(2100, 1, 1), DateTime(2100, 1, 1), '', '',
  //     false, false, '', [], '', '', false, 0);
  String params = "city=";

  if (isOnline != "") {
    params += "&online=$isOnline";
  }
  if (isfree != "") {
    params += "&free=$isfree";
  }
  if (title != "") {
    params += "&title=$title";
  }
  if (start_date != DateTime(2100, 1, 1)) {
    params +=
        "&start_date=${DateFormat('yyyy-MM-ddTHH:mm:ss').format(start_date)}";
  }
  if (end_date != DateTime(2100, 1, 1)) {
    params += "&end_date=${DateFormat('yyyy-MM-ddTHH:mm:ss').format(end_date)}";
  }
  if (Category != "") {
    params += "&category=$Category";
  }

  var uri = Uri.parse('${Constants.host}/events/search?${params}');
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
    print(resData.length);
    if (resData.length > 0) {
      for (int i = 0; i < resData.length; i++) {
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
        categoreyEvents.add(Event(
            resData[i]['id'],
            DateTime.parse(resData[i]['date_and_time']['start_date_time']),
            DateTime.parse(resData[i]['date_and_time']['end_date_time']),
            resData[i]['description'],
            resData[i]['image_link'],
            resData[i]['location']['is_online'],
            false,
            resData[i]['basic_info']['category'],
            [],
            resData[i]['basic_info']['title'],
            resData[i]['basic_info']['organizer'],
            resData[i]['state']['is_public']));
        // print('Length is :   ${categoreyEvents.length}');
      }
    } else {
      return [];
    }
    return categoreyEvents;
  } else {
    return [];
  }
}
