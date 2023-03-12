import 'package:eventbrite_replica/widgets/favourite_sign_text1.dart';
import 'package:eventbrite_replica/widgets/log_in_btn_forTickets.dart';
import 'package:flutter/material.dart';
import '../widgets/favourite_sign_text2.dart';
import '../widgets/favourite_sign_text3.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: const [
              SizedBox(
                height: 80,
              ),
              FavouriteText1(),
              FavouriteText2(),
              FavouriteText3(),
            ],
          ),
          Container(
            height: 55,
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
            child: LogInBtnFavourites(() {}),
          ),
        ],
      ),
    );
  }
}
