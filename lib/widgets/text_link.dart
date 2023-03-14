import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final Function onPressed;
  final int alignment;
  TextLink(this.text, this.alignment, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 6),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        onPressed: () => onPressed,
        child: SizedBox(
          width: double.infinity,
          child: Text(
            text,
            textAlign: alignment == 0
                ? TextAlign.left
                : alignment == 1
                    ? TextAlign.center
                    : TextAlign.right,
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
