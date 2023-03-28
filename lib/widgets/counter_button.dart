library CounterButton;

import 'package:flutter/material.dart';

/// {@category Widgets}
///# The CounterButton is a StatelessWidget that displays a button with a title and a counter.
///
///The title is displayed below the counter and is passed as a string.
///
///The counter is passed as an integer and is displayed at the top of the button.
///
///The widget is designed to be flexible and expand to fill its parent widget.
///
/// It is wrapped in an Expanded widget, which ensures that it takes up all available space in its parent widget.
///
/// The button itself is a MaterialButton widget with an onPressed callback function.
///
/// The button's child widget is a Column widget, which contains two Text widgets.
///
/// The first Text widget displays the counter value as a string.

/// The second Text widget displays the title string.
class CounterButton extends StatelessWidget {
  final String title;
  final int counter;
  const CounterButton(this.title, this.counter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              counter.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color.fromRGBO(66, 94, 203, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
