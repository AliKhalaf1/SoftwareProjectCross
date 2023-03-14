import 'package:flutter/material.dart';

import '../widgets/button_find_things.dart';
import '../widgets/title_text_1.dart';
import '../widgets/title_text_2.dart';
import '../widgets/log_in_btn.dart';
import '../common_functions/log_in.dart';

class Tickets extends StatelessWidget {
  const Tickets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/images.jfif"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: const [
                SizedBox(
                  height: 100,
                ),
                TitleText1('Looking for your mobile tickets?'),
                TitleText2(
                    'Log into the same account you used to buy your tickets.'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: const LogInBtn('Log In', loggingIn),
                ),
                ButtonThingsToDo(() {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
