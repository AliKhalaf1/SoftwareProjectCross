import 'package:eventbrite_replica/widgets/log_in_btn_forTickets.dart';
import 'package:flutter/material.dart';

import '../widgets/button_find_things.dart';
import '../widgets/favourite_ticket_text1.dart';
import '../widgets/favourite_ticket_text2.dart';

class Tickets extends StatelessWidget {
  const Tickets({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                height: 80,
              ),
              TicketText1(),
              TicketText2(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 55,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 15, top: 0),
                child: LogInBtnFavourites(() {}),
              ),
              GreyButton(() {}, 'Find things to do'),
            ],
          ),
        ],
      ),
    );
  }
}
