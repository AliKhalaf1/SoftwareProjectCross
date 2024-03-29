library UserModel;

import '../screens/user/profile.dart';

import '../screens/sign_up/sign_up_form.dart';
import 'package:objectbox/objectbox.dart';

/// {@category Models}
///
///   <h1> This model represents the user Data </h1>
///
/// it contains the <b>email</b>, the image <bold>url</bold>, the <bold>first name</bold> and the <bold>last name</bold> of the user
///
/// it's used in the [Profile] screen
/// to get the user's data from the DBMock and display it.
///
/// it's also used in the [SignUpForm] screen
/// to get the user's data from the user and send it to the DBMock to create a new user.
@Entity()
class User {
  @Id()
  int mockId = 0;
  //parameters
  @Unique()
  String email;
  String imageUrl;

  String firstName;

  String lastName;
  //constructor
  User(
    this.email,
    this.imageUrl,
    this.firstName,
    this.lastName,
  );
}
