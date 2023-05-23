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
      for (int i = 0; i < resData.length; i++) {
        var event = Event(
          resData[i]['id'],
          DateTime.parse(resData[i]['start_date_time']),
          DateTime(2001, 1, 1),
          "",
          resData[i]['image_link'],
          resData[i]['is_online'],
          false,
          "",
          [],
          resData[i]['title'],
          resData[i]['creator_info']['firstname'] +
              " " +
              resData[i]['creator_info']['lastname'],
          false,
        );
        event.city = resData[i]['location']['city'];
        LikedEvents.add(event);
      }
      //Maping logic
      return LikedEvents;
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

Future<bool> UnlikeEventHelper(String id, int eventid) async {
  ///////////////////////////////////////////////////////////
  ///api
  ///
  if (Constants.MockServer == false) {
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
    return (resCode == 200);
  }
  ///////////////////////////////////////////////////////////
  //mock
  else {
    var userLikesBox = ObjectBox.likesBox;
    var userbox = ObjectBox.userBox;
    String email = await getEmail();
    var user = userbox.query(User_.email.equals(email)).build().findFirst();
    var userlike = userLikesBox
        .query(UserLikesEvents_.userId.equals(user!.mockId) &
            UserLikesEvents_.eventId.equals(eventid))
        .build()
        .findFirst();
    userLikesBox.remove(userlike!.mockId);
    return true;
  }
}

Future<bool> likeEventHelper(String id, int eventid) async {
  ///////////////////////////////////////////////////////////
  ///api
  ///
  if (Constants.MockServer == false) {
    var uri = Uri.parse('${Constants.host}/users/me/event/${id}/like');
    var token = await getToken();
    print(uri);
    //encode Map to JSON
    Map<String, String> reqHeaders = {
      'Authorization': 'Bearer $token',
    };
    //encode Map to JSON
    var response = await http.post(
      uri,
      headers: reqHeaders,
    );
    var resCode = response.statusCode;
    print(resCode);
    return (resCode == 200);
  }
  ///////////////////////////////////////////////////////////
  //mock
  else {
    var userLikesBox = ObjectBox.likesBox;
    var userbox = ObjectBox.userBox;
    String email = await getEmail();
    var user = userbox.query(User_.email.equals(email)).build().findFirst();
    var userlike = UserLikesEvents(user!.mockId, eventid);
    userLikesBox.put(userlike);
    return true;
  }
}

Future<bool> isEventLikedHelper(String id, int eventid) async {
  ///////////////////////////////////////////////////////////
  ///api
  ///
  if (Constants.MockServer == false) {
    var uri = Uri.parse('${Constants.host}/users/me/event/${id}/is_liked');
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

    print("ana hna");
    print(resCode);
    if (resCode == 200) {
      print("rg3t 200");
      print(resBody);
      if (resBody == "true") {
        return true;
      } else {
        return false;
      }
    } else {}
    return (resCode == 200);
  }
  ///////////////////////////////////////////////////////////
  //mock
  else {
    var userLikesBox = ObjectBox.likesBox;
    var userbox = ObjectBox.userBox;
    String email = await getEmail();
    var user = userbox.query(User_.email.equals(email)).build().findFirst();
    var userlike = userLikesBox
        .query(UserLikesEvents_.userId.equals(user!.mockId) &
            UserLikesEvents_.eventId.equals(eventid))
        .build()
        .findFirst();
    return userlike != null;
  }
}
