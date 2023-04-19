import 'dart:convert';

import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:http/http.dart' as http;

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
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "password": password,
    "is_verified": false,
    "avatar_url": ""
  };
  //encode Map to JSON
  var reqBody = json.encode(reqData);

  var response = await http.post(uri,
      headers: {"Content-Type": "application/json"}, body: reqBody);

  int resCode = response.statusCode;
  return resCode;
  //Check Response
}
