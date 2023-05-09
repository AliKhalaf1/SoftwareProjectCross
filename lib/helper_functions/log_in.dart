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

Future<bool> checkToken(token) async {
  var uri = Uri.parse('${Constants.host}/auth/verify-email');

  //create multipart request
  Map<String, String> reqHeaders = {
    'Authorization': 'Bearer ${token}',
  };
  var response = await http.put(
    uri,
    headers: reqHeaders,
  );

  return response.statusCode == 200;
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

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token') ?? '';
  return token;
}

/// {@category Helper Functions}
/// <h1>This function is used to check whether an email exists using api's.</h1>
///
/// It takes the email of the user as a parameter.
///
Future<void> emailCheck(BuildContext ctx, String email) async {
  if (Constants.MockServer == false) {
    print("I'm here");
    // string to uri
    var uri =
        Uri.parse('${Constants.host}/users/email/info/avatar?email=$email');
    print(uri);
    //create multipart request

    var response = await http.get(uri);

    var res = response.body;
    var resData = jsonDecode(res);

    //Check Response
    if (response.statusCode == 200) {
      // user is already registered
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
        return PasswordCheck(email, resData["avatar_url"] ?? "");
      }));
    } else if (response.statusCode == 404) {
      // user is not registered
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
        return SignUpForm(email);
      }));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
        ),
      );
    }
  } else {
    var authbox = ObjectBox.authBox;
    var userbox = ObjectBox.userBox;

    var authQuery =
        authbox.query(Auth_.email.equals(email)).build().findFirst();
    if (authQuery != null) {
      var userQuery =
          userbox.query(User_.email.equals(email)).build().findFirst();

      User user = userQuery!;

      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
        return PasswordCheck(email, user.imageUrl);
      }));
    } else {
      Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
        return SignUpForm(email);
      }));
    }
  }
}

Future<void> passCheck(BuildContext ctx, String password, String email) async {
  if (Constants.MockServer == false) {
    var uri = Uri.parse('${Constants.host}/auth/login');

    // create multipart request

    Map<String, String> reqHeaders = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    Map reqData = {
      'username': email,
      'password': password,
    };
    //encode Map to JSON
    var reqBody = reqData;

    var response = await http.post(
      uri,
      headers: reqHeaders,
      encoding: Encoding.getByName('utf-8'),
      body: reqBody,
    );

    var res = response.body;
    var resData = jsonDecode(res);

    // Check Response
    if (response.statusCode == 200) {
      // user is already registered
      String token = resData['access_token'];

      //String tokenType = resData['token_type'];
      setLoggedIn(email, token);
      Navigator.of(ctx).popUntil((route) => route.isFirst);
      Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
        return TabBarScreen(title: 'Profile', tabBarIndex: 4);
      }));
    } else if (response.statusCode == 401) {
      // user is already registered
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(resData['detail']),
      ));
    } else if (response.statusCode == 404) {
      // user is already registered
      Navigator.of(ctx).pop();
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text('Email doesn\'t exist'),
      ));
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
        content: Text('Something went wrong'),
      ));
    }

    print(response.statusCode);
    print(resData);
  } else {
    var authbox = ObjectBox.authBox;

    var authQuery =
        authbox.query(Auth_.email.equals(email)).build().findFirst();
    if (authQuery != null) {
      if (authQuery.password == password) {
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
  }
}
