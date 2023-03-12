import 'package:flutter/material.dart';

class FavouriteText3 extends StatelessWidget {
  const FavouriteText3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6),
      child: TextButton(
        onPressed: () {},
        child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Explore events",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 17,
              color: Color.fromRGBO(66, 94, 203, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
