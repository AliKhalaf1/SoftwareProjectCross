import 'dart:convert';

import 'package:Eventbrite/providers/createevent/createevent.dart';
import 'package:Eventbrite/providers/events/event.dart';
import 'package:intl/intl.dart';

import '../providers/getevent/getevent.dart';
import 'constants.dart';
import 'log_in.dart';
import 'package:http/http.dart' as http;

Future<Event> selectEventApi(String id) async {
  Event selectedEvent;
  var uri = Uri.parse('${Constants.host}/events/id/${id}');
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
    return Event(
        resData['id'],
        DateTime.parse(resData['date_and_time']['start_date_time']),
        DateTime.parse(resData['date_and_time']['end_date_time']),
        resData['description'],
        resData['image_link'],
        resData['location']['is_online'],
        false,
        resData['basic_info']['category'],
        [],
        resData['basic_info']['title'],
        resData['basic_info']['organizer'],
        resData['state']['is_public']);
    // print('Length is :   ${categoreyEvents.length}');
  } else {
    return Event('', DateTime.now(), DateTime.now(), '', '', false, false, '',
        [], '', '', false);
  }
}
