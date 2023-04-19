library LogInHelperFunctions;

import 'dart:convert';

import 'package:Eventbrite/screens/sign_in/password_check.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/db_mock.dart';
import '../models/user.dart';
import '../screens/sign_up/sign_up_form.dart';
import '../screens/sign_up/sign_up_or_log_in.dart';
import 'package:http/http.dart' as http;

import '../screens/tab_bar.dart';
import 'constants.dart';

/// {@category Helper Functions}
///
/// <h1>This function is called when the user logs in.</h1>
///
/// It's used to navigate to Login Page.
///
void loggingIn(BuildContext ctx) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return const SignUpOrLogIn();
  }));
}

/// {@category Helper Functions}
///
/// <h1>This function is used to set the user logged using Cache Memory.</h1>
///
/// It takes the email of the user as a parameter.
///
/// It sets the value of the key "isLoggedIn" to true and the value of the key "email" to the email of the user.
///
Future<void> setLoggedIn(email, token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
  prefs.setString('token', token);
}

/// {@category Helper Functions}
/// <h1>This function is used to check Cache for already logged in user and returns a boolean</h1>
Future<bool> checkLoggedUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token') ?? '';
  return token.isNotEmpty;
}

/// {@category Helper Functions}
/// <h1>This function is used to get the email of the user from Cache Memory.</h1>
Future<String> getEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getString('email') ?? '';
  return status;
}

/// {@category Helper Functions}
/// <h1>This function is used to check whether an email exists using api's.</h1>
///
/// It takes the email of the user as a parameter.
///
Future<void> emailCheck(BuildContext ctx, String email) async {
  // string to uri
  // var uri = Uri.parse('${Constants.host}/auth/login');

  // // create multipart request

  // Map reqData = {
  //   'email': email,
  //   'password': 'dummy',
  // };
  // //encode Map to JSON
  // var reqBody = json.encode(reqData);

  // var response = await http.post(uri,
  //     headers: {"Content-Type": "application/json"}, body: reqBody);

  // var res = response.body;
  // var resData = jsonDecode(res);

  // //Check Response
  // if (resData['message'] == 'wrong password') {
  //   // user is already registered
  //   Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
  //     return PasswordCheck(email, "");
  //   }));
  // } else if (resData['message'] == 'email is not registered') {
  //   // user is not registered
  //   Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
  //     return SignUpForm(email);
  //   }));
  // } else if (resData['message'] == 'email is not verified') {
  //   // user is not verified
  //   ScaffoldMessenger.of(ctx).showSnackBar(
  //     const SnackBar(
  //       content: Text('Email needs to be verified'),
  //     ),
  //   );
  // } else {
  //   ScaffoldMessenger.of(ctx).showSnackBar(
  //     const SnackBar(
  //       content: Text('Something went wrong'),
  //     ),
  //   );
  // }

  if (DBMock.checkEmail(email)) {
    User user1 = DBMock.getUserData(email);
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return PasswordCheck(email, user1.imageUrl);
    }));
  } else {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return SignUpForm(email);
    }));
  }
}

Future<void> passCheck(BuildContext ctx, String password, String email) async {
  // var uri = Uri.parse('${Constants.host}/auth/login');

  // create multipart request

  // Map reqData = {
  //   'email': email,
  //   'password': password,
  // };
  //encode Map to JSON
  // var reqBody = json.encode(reqData);

  // var response = await http.post(uri,
  //     headers: {"Content-Type": "application/json"}, body: reqBody);

  // var res = response.body;
  // var resData = jsonDecode(res);

  //Check Response
  // if (response.statusCode == 200) {
  //   // user is already registered
  //   String token = resData['token'];
  //   setLoggedIn(email, token);
  //   Navigator.of(ctx).popUntil((route) => route.isFirst);
  //   Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
  //     return TabBarScreen(title: 'Profile', tabBarIndex: 4);
  //   }));
  // } else if (resData['message'] == 'wrong password') {
  //   // user is already registered
  //   ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
  //     content: Text('Wrong password'),
  //   ));
  // } else if (resData['message'] == 'email is not verified') {
  //   // user is already registered
  //   setLoggedIn(email, 'Dummy Token');
  //   Navigator.of(ctx).popUntil((route) => route.isFirst);
  //   Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
  //     return TabBarScreen(title: 'Profile', tabBarIndex: 4);
  //   }));

  //   ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
  //     content: Text('Email needs to be verified'),
  //   ));
  // } else {
  //   ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
  //     content: Text('Something went wrong'),
  //   ));
  // }

  if (DBMock.checkAuth(email, password)) {
    setLoggedIn(email, 'Dummy Token');
    Navigator.of(ctx).popUntil((route) => route.isFirst);
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return TabBarScreen(title: 'Profile', tabBarIndex: 4);
    }));
  } else {
    ScaffoldMessenger.of(ctx)
        .showSnackBar(const SnackBar(content: Text('Wrong password')));
  }
}
