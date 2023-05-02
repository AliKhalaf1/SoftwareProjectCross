library AuthModel;

import '../screens/sign_in/email_check.dart';

/// {@category Models}
/// <h1>This model represents the authentication of the user</h1>
///
/// it contains the <strong>email</strong> and the <strong>password</strong> of the user.
///
/// it's used in the [EmailCheck] screen
/// to get the email and password of the user
/// and send it to the DBMock to check if the user is valid.
class Auth {
  //new comment
  //parameters of the EventCard Widget
  final String email;
  final String password;

  //constructor
  Auth(this.email, this.password);
}
