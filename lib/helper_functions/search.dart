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
  var resBody = response.body;
  var resData = jsonDecode(resBody);
  print("hello");
  print(resCode);
  print(resData);
  if (resCode == 200) {
    print(resData.length);
    for (int i = 0; i < resData.length; i++) {
      print(resData[i]['id']);
      print(resData[i]['basic_info']['title']);
    }
    return [];
  } else {
    return [];
  }
}
