import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/log_in_btn.dart';
import './email_check.dart';
import './findTickets.dart';
import '../widgets/button_links.dart';
import '../widgets/transparent_button.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  //Routing value
  static const signUpRoute = '/SignUp';

  //facebook icon
  static const IconData facebookData =
      IconData(0xe255, fontFamily: 'MaterialIcons');
  static const Icon facebook =
      Icon(facebookData, color: Color.fromRGBO(1, 101, 225, 1));

  //google icon
  static const IconData googleData =
      IconData(0xe255, fontFamily: 'MaterialIcons');
  static const Icon google =
      Icon(facebookData, color: Color.fromRGBO(1, 101, 225, 1));

  //Log in with mail function
  void emailLogIn(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const EmailCheck();
    }));
  }

  //Find Ticket with mail function
  void findTicket(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const FindTickets();
    }));
  }

  //Find Ticket with facebook function
  void SignWithFacebook() {}

  //Find Ticket with google function
  void SignWithGoogle() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white38,
          foregroundColor: Color.fromRGBO(0, 0, 0, 0.7),
          elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // fisrt column of page
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                // child one
                Text('Let\'s get started',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
                SizedBox(
                  height: 15,
                ),
                // child two
                SizedBox(
                  width: 250,
                  child: Text(
                    'Sign up or log in in to see what\'s happening near you',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),

            //second column of page
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //First child
                LogInBtn('Continue with email address', emailLogIn),

                //Second child
                TransparentButton(
                    'Continue With Facebook', SignWithFacebook, facebook),

                //Third child
                TransparentButton(
                    'Continue With Google', SignWithGoogle, google),

                //Fourth child
                TextButton(
                  onPressed: () => findTicket(context),
                  child: Text(
                    'I bought tickets,but I don\'t have an account.',
                    style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
