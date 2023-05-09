import "dart:convert";

import "package:Eventbrite/objectbox.g.dart";
import "package:Eventbrite/providers/events/event.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../models/liked_event_card_model.dart";
import "../models/user_likes_event.dart";
import "../objectbox.dart";
import "constants.dart";
import "log_in.dart";
import 'package:http/http.dart' as http;

/// {@category Helper Functions}
/// {@category User}
Future<List<Event>> getLikedEvents() async {
///////////////////////////////////////////////////////////
  ///api
  ///
  List<Event> LikedEvents = <Event>[];
  if (Constants.MockServer == false) {
    print(
        "I'm in ---------------------------------------------------------------------");
    var uri = Uri.parse('${Constants.host}/users/me/event/liked');
    var token = await getToken();
    print(token);
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

    print("hello");
    print(resCode);

    if (resCode == 200) {
      var resBody = response.body;
      var resData = jsonDecode(resBody);
      List<Event> LikedEvents = <Event>[];
      print(resData.length);
      //Maping logic
      return [];
    } else {
      return [];
    }
  } else {
    /////////////////////////////////////////////////////////////
    ///mock
    ///
    ///

    var eventsbox = ObjectBox.eventBox;
    var likesbox = ObjectBox.likesBox;
    var userbox = ObjectBox.userBox;
    String email = await getEmail();

    var user = userbox.query(User_.email.equals(email)).build().findFirst();

    ///////////for testing///////////////////
    var firstevent = eventsbox.get(1);
    var newlike = UserLikesEvents(user!.mockId, firstevent!.mockId);
    if (likesbox.isEmpty()) {
      likesbox.put(newlike);
    }
    ///////////for testing///////////////////

    var likedevents = likesbox
        .query(UserLikesEvents_.userId.equals(user!.mockId))
        .build()
        .find();

    LikedEvents = likedevents.map((e) {
      var event = eventsbox.get(e.eventId);
      return event!;
    }).toList();
  }
  return LikedEvents;
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
