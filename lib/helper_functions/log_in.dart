library LogInHelperFunctions;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/sign_up/sign_up_or_log_in.dart';

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
Future<void> setLoggedIn(email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLoggedIn", true);
  prefs.setString("email", email);
}

/// {@category Helper Functions}
/// <h1>This function is used to check Cache for already logged in user and returns a boolean</h1>
Future<bool> checkLoggedUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getBool('isLoggedIn') ?? false;
  return status;
}
