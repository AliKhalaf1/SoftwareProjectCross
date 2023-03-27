import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/sign_up/sign_up_or_log_in.dart';

void loggingIn(BuildContext ctx) {
  ///
  /// This function is called when the user logs in.
  /// It pushes the SignUpOrLogIn screen to the Navigator stack.
  /// The user can only go back to the LogIn screen when he/she logs out.
  ///
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return const SignUpOrLogIn();
  }));
}

Future<void> setLoggedIn(email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLoggedIn", true);
  prefs.setString("email", email);
}
