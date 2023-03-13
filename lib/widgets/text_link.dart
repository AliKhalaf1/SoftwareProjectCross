import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  const TextLink(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () {},
        child: SizedBox(
          width: double.infinity,
          child: Text(
            text,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 15,
              color: Color.fromRGBO(66, 94, 203, 1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
