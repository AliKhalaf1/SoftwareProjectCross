library LogInOrSignUpScreen;

import '../../widgets/title_text_1.dart';
import '../../widgets/title_text_2.dart';
import 'package:flutter/material.dart';
import '../../widgets/log_in_btn.dart';
import '../sign_in/email_check.dart';
import '../find_tickets.dart';
import '../../widgets/transparent_button.dart';

/// {@category Sign Up}
/// {@category Screens}
///
/// It is surrounded by scafold to be rendered as a screen because it is screen widget.
///
/// Extends StatelessWidget as there is no change in any state in screen that could change rendered page content.
///
///###  Login Button
///
///   Handler for button navigate to SignUpOrLogIn screen when pressing on to it.
///
///   The user can signIn or signUp from navigated page.
///
///###  TitleText1 • LogInBtn • TransparentButton
///
///    Widgets with certain styling and not built in widgets like (i.e. Text)
///
///    You can find them in folder  under the name widgets.
///###  FindTicket Button
///
///    Handler for button navigate to FindTickets screen whare user can find its tickets if he doesnt have an account.
///
///    User also can create an account from navigated page
///

class SignUpOrLogIn extends StatelessWidget {
  const SignUpOrLogIn({super.key});

  //Routing value
  static const signUpRoute = '/SignUp';

  //facebook icon
  static const IconData facebookData =
      IconData(0xe255, fontFamily: 'MaterialIcons');
  static const Icon facebook = Icon(
    facebookData,
    color: Color.fromRGBO(5, 117, 254, 1),
    size: 23,
  );

  //Log in with mail function
  void emailLogIn(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return EmailCheck();
    }));
  }

  //Find Ticket with mail function
  void findTicket(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const FindTickets();
    }));
  }

  //Find Ticket with facebook function
  void signWithFacebook() {}

  //Find Ticket with google function
  void signWithGoogle() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("SignupOrLoginScreen"),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white38,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // first column of page
              Padding(
                padding: const EdgeInsets.only(bottom: 70, top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    // child one
                    TitleText1('Let\'s get started'),

                    // child two
                    SizedBox(
                      width: 250,
                      child: TitleText2(
                        'Sign up or log in in to see what\'s happening near you',
                      ),
                    ),
                  ],
                ),
              ),

              //second column of page
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //First child
                  LogInBtn(
                    key: const Key('LogInWithEmailBtn'),
                    'Continue with email address',
                    emailLogIn,
                  ),

                  //Second child
                  TransparentButton(
                    0,
                    key: const Key('LogInWithFacebookBtn'),
                    'Continue With Facebook',
                    signWithFacebook,
                    facebook,
                  ),

                  //Third child
                  TransparentButton(
                    key: const Key('LogInWithGoogleBtn'),
                    1,
                    'Continue With Google',
                    signWithGoogle,
                    facebook,
                  ),

                  //Fourth child
                  TextButton(
                    key: const Key('FindTicketsBtn'),
                    onPressed: () => findTicket(context),
                    child: const Text(
                      'I bought tickets, but I don\'t have an account.',
                      style: TextStyle(
                          color: Color.fromARGB(255, 16, 84, 211),
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
