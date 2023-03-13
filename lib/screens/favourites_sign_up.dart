import 'package:eventbrite_replica/widgets/title_text_1.dart';
import 'package:flutter/material.dart';
import '../widgets/title_text_2.dart';
import '../widgets/text_link.dart';
import '../widgets/log_in_btn.dart';
import '../common_functions/log_in.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/images1.jfif"), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              SizedBox(
                height: 100,
              ),
              TitleText1('See your favourite in one place'),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: TitleText2('Log in to see your favourites'),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: TextLink('Explore events'),
              ),
            ],
          ),
          const LogInBtn('Log In', loggingIn),
        ],
      ),
    );
  }
}
