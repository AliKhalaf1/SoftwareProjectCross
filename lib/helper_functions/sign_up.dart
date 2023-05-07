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

/// {@category Helper Functions}

/// <h1>This function is used to sign in the user using api's.</h1>

// Future<void> signInwithGoogle(
//     String firstname, String lastname, String email) async {
//   var signInUri = Uri.parse('${Constants.host}/auth/login-with-google');

//   // create multipart request

//   //encode Map to JSON
//   Map<String, String> reqHeaders = {
//     'Content-Type': 'application/x-www-form-urlencoded'
//   };
//   Map reqData = {
//     'username': email,
//     'password': password,
//   };
//   //encode Map to JSON
//   var reqBody = reqData;

//   var response = await http.post(
//     uri,
//     headers: reqHeaders,
//     encoding: Encoding.getByName('utf-8'),
//     body: reqBody,
//   );
// }

// Future<String> signUpwithGoogle(
//     String firstname, String lastname, String email) {


// Map signUpreqData = {
//     "email": email,
//     "password": "dummy",
//     "firstname": firstname,
//     "lastname": lastname,
//   };

//   var res = response.body;
//   var resData = jsonDecode(res);
//   //try to sign in first
//   var signInreqBody = json.encode(reqData);

//   var response = await http.post(uri,
//       headers: {"Content-Type": "application/json"}, body: reqBody);

//   int resCode = response.statusCode;
//   return resCode;









//     }
