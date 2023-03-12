import 'package:flutter/material.dart';

class FavouriteText2 extends StatelessWidget {
  const FavouriteText2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 0),
      child: const Text(
        "Log in to see your favourites",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 17),
      ),
    );
  }
}
