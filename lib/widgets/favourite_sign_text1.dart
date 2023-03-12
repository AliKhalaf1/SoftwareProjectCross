import 'package:flutter/material.dart';

class FavouriteText1 extends StatelessWidget {
  const FavouriteText1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 0),
      child: const Text(
        "See your favourites in one place",
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 37,
            height: 0.9,
            fontFamily: 'Neue Plak Extended',
            color: Color.fromRGBO(40, 27, 67, 1)),
      ),
    );
  }
}
