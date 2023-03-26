import 'package:flutter/material.dart';

import '../../widgets/button_find_things.dart';
import '../../widgets/title_text_1.dart';
import '../../widgets/title_text_2.dart';
import '../../widgets/log_in_btn.dart';
import '../../helper_functions/log_in.dart';
import '../tab_bar.dart';

class TicketsSignUp extends StatelessWidget {
  const TicketsSignUp({super.key});

  // on click handler Routing
  void findThingsToDoHandler(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return TabBarScreen(title: 'Search', tabBarIndex: 1);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: const Key('myContainerKey'),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/images.jfif"),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 12),
              child: Column(
                children: const [
                  SizedBox(
                    height: 100,
                  ),
                  TitleText1('Looking for your mobile tickets?'),
                  TitleText2(
                      'Log into the same account you used to buy your tickets.'),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 6, top: 0),
                  child: LogInBtn('Log In', loggingIn),
                ),
                GreyButton(findThingsToDoHandler, 'Find things to do'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
