import 'dart:convert';

import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:http/http.dart' as http;

Future<String> signUpApi(
    String firstname, String lastname, String email, String password) async {
  var uri = Uri.parse('${Constants.host}/auth/signup');
  var request = http.MultipartRequest("POST", uri);
  request.fields['firstname'] = firstname;
  request.fields['lastname'] = lastname;
  request.fields['email'] = email;
  request.fields['password'] = password;
  request.fields['is_verified'] = "false";
  var response = await request.send();
  var res = await response.stream.bytesToString();
  var data = jsonDecode(res);
  return data['message'];
}
