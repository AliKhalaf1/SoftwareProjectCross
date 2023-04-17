import 'dart:convert';

import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:http/http.dart' as http;

Future<int> signUpApi(
    String firstname, String lastname, String email, String password) async {
  var uri = Uri.parse('${Constants.host}/auth/signup');

  // create multipart request

  Map reqData = {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "password": password,
    "is_verified": false
  };
  //encode Map to JSON
  var reqBody = json.encode(reqData);

  var response = await http.post(uri,
      headers: {"Content-Type": "application/json"}, body: reqBody);

  int resCode = response.statusCode;
  return resCode;
  //Check Response
}
