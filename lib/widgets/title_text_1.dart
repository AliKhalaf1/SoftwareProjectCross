library TextTitle1;

import 'package:flutter/material.dart';

/// {@category Widgets}
///
class TitleText1 extends StatelessWidget {
  final String text;
  const TitleText1(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(right: 15, bottom: 10),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: 30,
            height: 0.9,
            letterSpacing: 1.3,
            fontFamily: 'Neue Plak Extended',
            fontWeight: FontWeight.w700,
            color: Color.fromRGBO(10, 5, 19, 1)),
      ),
    );
  }
}
