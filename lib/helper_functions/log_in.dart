import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/sign_up/sign_up_or_log_in.dart';

void loggingIn(BuildContext ctx) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return const SignUpOrLogIn();
  }));
}

Future<void> setLoggedIn(email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLoggedIn", true);
  prefs.setString("email", email);
}
