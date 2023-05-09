import "dart:convert";

import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../models/liked_event_card_model.dart";
import "constants.dart";
import "log_in.dart";
import 'package:http/http.dart' as http;

/// {@category Helper Functions}
/// {@category User}
Future<List<LikedEventCardModel>> getLikedEvents() async {
///////////////////////////////////////////////////////////
  ///api
  ///
  var uri = Uri.parse('${Constants.host}/users/me/event/liked');
  var token = await getToken();
  //encode Map to JSON
  Map<String, String> reqHeaders = {
    'Authorization': 'Bearer $token',
  };
  //encode Map to JSON
  var response = await http.get(
    uri,
    headers: reqHeaders,
  );

  var resCode = response.statusCode;
  var resBody = response.body;
  var resData = jsonDecode(resBody);
  print("hello");
  print(resCode);
  print(resData);
  if (resCode == 200) {
    print(resData.length);
    return [];
  } else {
    return [];
  }

/////////////////////////////////////////////////////////////
  ///mock
}

Future<bool> UnlikeEvent(String id, int eventid) async {
  ///////////////////////////////////////////////////////////
  ///api
  ///
  var uri = Uri.parse('${Constants.host}/users/me/event/${id}/unlike');
  var token = await getToken();
  //encode Map to JSON
  Map<String, String> reqHeaders = {
    'Authorization': 'Bearer $token',
  };
  //encode Map to JSON
  var response = await http.delete(
    uri,
    headers: reqHeaders,
  );
  var resCode = response.statusCode;
  var resBody = response.body;
  var resData = jsonDecode(resBody);
  return (resCode == 200);
}
