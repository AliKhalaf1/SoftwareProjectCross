library LinkButton;

import 'package:flutter/material.dart';

/// {@category Widgets}
///
/// <h1>The TextLink is a StatelessWidget that displays a hyperText that navigates to another page. </h1>
///
/// it takes a string as a </b>text</b> , <b>OnPressed</b> Function and an <b>integer</b> as an alignment.
///
/// the alignment is used to align the text to the left, center or right.
///
/// the text is displayed as a button.
///
/// the onPressed callback function is used to navigate to another page.
///
class TextLink extends StatelessWidget {
  final String text;
  final Function onPressed;
  final int alignment;
  const TextLink(this.text, this.alignment, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: () => onPressed(),
      child: SizedBox(
        height: 25,
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
    );
  }
}
