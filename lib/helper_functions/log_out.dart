import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setLoggedOut(email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  prefs.remove('email');
}

void logOutLogic(BuildContext ctx, String email, Function logOut) {
  setLoggedOut(email);
  logOut();
}
