library GreyButton;

import 'package:flutter/material.dart';

/// {@category Widgets}
///# The GreyButtonLogout widget is a StatelessWidget that displays a grey button with a text label.
///
///The widget is designed to be flexible and expand to fill its parent widget.
///It is wrapped in a Container widget that has a white background color and a fixed height of 65.
/// The Container widget also has padding on all sides, with extra padding at the bottom.
///
///The button itself is a TextButton widget with an onPressed callback function that is passed in through the onPressed property.
///The button's child widget is a Text widget, which displays the text property as the button label.
class GreyButtonLogout extends StatelessWidget {
  final Function onPressed;
  final String text;
  const GreyButtonLogout(this.onPressed, this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 65,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
      child: TextButton(
        key: key,
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black12),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
              color: Colors.black38,
              width: 2.2,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black87),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        onPressed: () => onPressed(context),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
