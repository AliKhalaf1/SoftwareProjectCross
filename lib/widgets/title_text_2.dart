import 'package:flutter/material.dart';

class TitleText2 extends StatelessWidget {
  final String text;
  const TitleText2(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 10, top: 0),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: const TextStyle(
            fontSize: 15.5, color: Color.fromRGBO(0, 0, 0, 0.8)),
      ),
    );
  }
}
