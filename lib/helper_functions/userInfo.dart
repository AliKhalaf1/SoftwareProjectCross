library LogInHelperFunctions;

import 'dart:convert';

import 'package:Eventbrite/screens/sign_in/password_check.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth.dart';
import '../models/db_mock.dart';
import '../models/user.dart';
import '../objectbox.dart';
import '../objectbox.g.dart';
import '../screens/sign_up/sign_up_form.dart';
import '../screens/sign_up/sign_up_or_log_in.dart';
import 'package:http/http.dart' as http;

import '../screens/tab_bar.dart';
import 'constants.dart';

/// {@category Helper Functions}
///
Future<User> getUserInfo(String info) async {
  User currUser = new User("", "", "", "");
  if (Constants.MockServer == true) {
    var userbox = ObjectBox.userBox;
    currUser = userbox.query(User_.email.equals(info)).build().findFirst()!;
  } else {
    //////////////////////////////////////////////////////////////////////////////////
    var uri = Uri.parse('${Constants.host}/users/me/info');

    //create multipart request
    Map<String, String> reqHeaders = {
      'Authorization': 'Bearer ${info}',
    };
    var response = await http.get(
      uri,
      headers: reqHeaders,
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      currUser.email = data['email'];
      currUser.firstName = data['firstname'];
      currUser.lastName = data['lastname'];
      currUser.imageUrl = data['avatar_url'];
      print('avatar url: ${currUser.imageUrl}');
      setUserinfo(currUser.firstName, currUser.lastName);
      return currUser;
    } else {}
  }
  ////////////////////////////////////////////////////////////////////////////////////

  return currUser;
}

void setUserinfo(String firstname, String lastname) {
  // var userbox = ObjectBox.userBox;
  // var user = userbox.query(User_.email.equals(email)).build().findFirst()!;
  // user.firstName = firstname;
  // user.lastName = lastname;

  // userbox.put(user);

  SharedPreferences.getInstance().then((prefs) {
    prefs.setString('firstname', firstname);
    prefs.setString('lastname', lastname);
  });
}

Future<String> getFirstName() async {
  var cache_mem = await SharedPreferences.getInstance();
  return cache_mem.getString('firstname') ?? "";
}

Future<String> getLastName() async {
  var cache_mem = await SharedPreferences.getInstance();
  return cache_mem.getString('lastname') ?? "";
}
