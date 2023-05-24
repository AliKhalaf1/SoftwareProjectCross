import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/google_signin_api.dart';

/// {@category Helper Functions}
///
/// <h1>This function is used to set the user logged out using Cache Memory.</h1>
///
/// It removes the value of the key "token" and the value of the key "email" from the cache.
///
Future<void> setLoggedOut() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  prefs.remove('email');
}

/// {@category Helper Functions}
/// <h1>This function is used to log out the user.</h1>
///
/// It takes the context of the page, the email of the user and the logOut function as parameters.
///
/// It calls the setLoggedOut function to remove the user's email and token from the cache.
///
/// then,  It then calls the logOut function to navigate to the login page.
void logOutLogic(BuildContext ctx, String email, Function logOut) async {
  setLoggedOut();
  GoogleSignInApi.isSignedIn().then((value) {
    if (value == true) {
      GoogleSignInApi.logout();
    }
  });
  logOut();
}
