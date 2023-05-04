import 'dart:convert';

import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:Eventbrite/models/auth.dart';
import 'package:http/http.dart' as http;
import 'package:objectbox/objectbox.dart';

import '../objectbox.dart';

import '../models/user.dart';
import '../objectbox.g.dart';

/// {@category Helper Functions}
/// <h1>This function is used to sign up the user using api's.</h1>
///
/// It takes the firstname, lastname, email and password of the user as parameters.
///
/// It then sends a post request to the api with the user's details.
///
///  then, it returns the response code of the request.
///
///
Future<int> signUpApi(
    String firstname, String lastname, String email, String password) async {
  var uri = Uri.parse('${Constants.host}/auth/signup');

  // create multipart request

  Map reqData = {
    "email": email,
    "password": password,
    "firstname": firstname,
    "lastname": lastname,
  };
  //encode Map to JSON
  var reqBody = json.encode(reqData);

  var response = await http.post(uri,
      headers: {"Content-Type": "application/json"}, body: reqBody);

  int resCode = response.statusCode;
  return resCode;

  //Check Response

  // Auth auth = Auth(email, password);
  // User user1 = User(email, "", firstname, lastname);
  // var authbox = ObjectBox.authBox;
  // var userbox = ObjectBox.userBox;

  // var authQuery = authbox.query(Auth_.email.equals(email)).build();
  // if (authQuery.count() == 0) {
  //   authbox.put(auth);
  //   userbox.put(user1);
  //   return 200;
  // } else {
  //   return 400;
  // }
}
