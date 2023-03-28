library AuthModel;

import '../screens/sign_in/email_check.dart';

/// {@category Models}
/// this model represents the authentication of the user
/// it contains the email and the password of the user
/// it's used in the [EmailCheck] screen
/// to get the email and password of the user
/// and send it to the DBMock to check if the user is valid.
class Auth {
  //parameters of the EventCard Widget
  final String email;
  final String password;

  //constructor
  Auth(this.email, this.password);
}
