import 'dart:convert';
import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:Eventbrite/models/auth.dart';
import 'package:http/http.dart' as http;
import 'package:objectbox/objectbox.dart';

import '../objectbox.dart';

import '../models/user.dart';
import '../objectbox.g.dart';
import 'log_in.dart';

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

/// {@category Helper Functions}

/// <h1>This function is used to sign in the user using api's.</h1>

Future<int> signInHelper(
    String email, String firstname, String lastname) async {
  var signInUri = Uri.parse('${Constants.host}/auth/login-with-google');

  //encode Map to JSON
  Map<String, String> reqHeaders = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  Map reqData = {
    'username': email,
    'password': "dummy",
  };
  //encode Map to JSON
  var reqBody = reqData;

  var response = await http.post(
    signInUri,
    headers: reqHeaders,
    encoding: Encoding.getByName('utf-8'),
    body: reqBody,
  );

  var res = response.body;
  var resData = jsonDecode(res);
  var resCode = response.statusCode;
  print(resData);
  print("resCode: $resCode");
  if (resCode == 200) {
    String token = resData['access_token'];

    //String tokenType = resData['token_type'];
    setLoggedIn(email, token);
    return 200;
  } else if (resCode == 404) {
    return signUpHelper(firstname, lastname, email);
  } else if (resCode == 401) {
    return 401;
  } else {
    return 500;
  }
}

Future<int> signUpHelper(
    String firstname, String lastname, String email) async {
  var uri = Uri.parse('${Constants.host}/auth/signup');

  // create multipart request

  //encode Map to JSON
  Map signUpreqData = {
    "email": email,
    "password": "dummy",
    "firstname": firstname,
    "lastname": lastname,
  };

  //try to sign in first
  var signUpreqBody = json.encode(signUpreqData);

  var response = await http.post(uri,
      headers: {"Content-Type": "application/json"}, body: signUpreqBody);

  int resCode = response.statusCode;
  if (resCode == 200) {
    return 401;
  } else {
    return 500;
  }
}
