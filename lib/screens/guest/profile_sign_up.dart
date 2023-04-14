library GuestProfileScreen;

import 'package:Eventbrite/widgets/tab_bar_Events.dart';
import 'package:flutter/material.dart';
import '../../widgets/button_link.dart';
import '../../widgets/log_in_btn.dart';
import '../../helper_functions/log_in.dart';

/// {@category Guest}
/// {@category Screens}
///# The ProfileSignUp class is a StatelessWidget,that defines a screen for the guest user's profile.
///
///The screen displays three buttons labeled "Ticket Issues," "Manage Events," and "Settings" inside a ListView widget.
///
///At the bottom of the screen, there is a container that contains a LogInBtn widget labeled "Log In".
///
/// The LogInBtn widget has a callback function named "loggingIn" that is executed when the button is pressed.
///
class ProfileSignUp extends StatelessWidget {
  const ProfileSignUp({super.key});
  void eventNavigate(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      TabBarEvents.route,
    ); // we use same string in main it’s a key
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ButtonLink('Ticket Issues', () {}),
                      ButtonLink('Manage Events', () {
                        eventNavigate(context);
                      }),
                      ButtonLink('Settings', () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 235, 233, 233),
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset.zero, // shadow direction: bottom right
                )
              ],
              border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromARGB(255, 232, 231, 231)),
              ),
            ),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 5),
                child: LogInBtn('Log In', loggingIn),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
