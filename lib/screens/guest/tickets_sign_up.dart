import 'package:flutter/material.dart';

import '../../widgets/button_find_things.dart';
import '../../widgets/title_text_1.dart';
import '../../widgets/title_text_2.dart';
import '../../widgets/log_in_btn.dart';
import '../../helper_functions/log_in.dart';
import '../tab_bar.dart';

/// {@category Guest}
/// {@category Screens}
/// ========================= TicketsSignUp ===========================
///    • It is surrounded by scafold to be rendered as a screen because it is screen widget 
///    • Extends StatelessWidget as there is no change in any state in screen that could change rendered page content 
/// 
/// ====================== findThingsToDoHandler ======================
///    • Handler for (Find things to do) button to navigate to search screen when pressing on to it
///    • Search screen --> its index is 1 in tabBaerScreen so we send its index to tabBaerScreen to understands which page to render
/// 
///  =========================== loggingIn ============================
///    • Handler for (logIn) button to navigate to SignUpOrLogIn screen when pressing on to it
///    • The user can signIn or signUp from navigated page
/// 
///  ==== TitleText1 /  TitleText2 / LogInBtn / GreyButtonLogout =====
///    • Widgets with certain styling and not built in widgets like (i.e. Text)
///    • You can find them in folder  under the name widgets 
///  
///  ============================= Image ==============================
///    • You can find it in file under the name pubspec under assets title
///    
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
                GreyButtonLogout(findThingsToDoHandler, 'Find things to do'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
