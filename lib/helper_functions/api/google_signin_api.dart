import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn();

  static Future<bool?> isSignedIn() async {
    return _googleSignIn.isSignedIn();
  }

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
