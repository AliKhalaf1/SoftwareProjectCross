import 'package:flutter/material.dart';

class TitleText1 extends StatelessWidget {
  final String text;
  const TitleText1(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: 30,
            height: 0.9,
            letterSpacing: 1.3,
            fontFamily: 'Neue Plak Extended',
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(40, 27, 67, 1)),
      ),
    );
  }
}
