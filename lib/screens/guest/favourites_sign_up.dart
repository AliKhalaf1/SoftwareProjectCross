import '../../widgets/title_text_1.dart';
import 'package:flutter/material.dart';
import '../../widgets/title_text_2.dart';
import '../../widgets/text_link.dart';
import '../../widgets/log_in_btn.dart';
import '../../helper_functions/log_in.dart';

/// {@category Guest}
/// {@category Screens}
/// ========================= FavouritesSignUp ========================
///    • It is surrounded by scafold to be rendered as a screen because it is screen widget 
///    • Extends StatelessWidget as there is no change in any state in screen that could change rendered page content 
/// 
///  =========================== loggingIn ============================
///    • Handler for (logIn) button to navigate to SignUpOrLogIn screen when pressing on to it
///    • The user can signIn or signUp from navigated page
/// 
///  ============== TitleText1 /  TitleText2 / LogInBtn  ==============
///    • Widgets with certain styling and not built in widgets like (i.e. Text)
///    • You can find them in folder  under the name widgets 
///  


class FavouritesSignUp extends StatelessWidget {
  const FavouritesSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: const Key('myContainerKey'),
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/images1.jfif"),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const TitleText1('See your favourite in one place'),
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: TitleText2('Log in to see your favourites'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextLink('Explore events', 0, () {}),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 6, top: 0),
              child: LogInBtn('Log In', loggingIn),
            ),
          ],
        ),
      ),
    );
  }
}
