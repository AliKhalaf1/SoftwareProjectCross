library LinkButtonWidget;

import 'package:flutter/material.dart';

/// {@category Widgets}
///
/// This widget is a button that has a text and an arrow icon used in most styling.
///
class ButtonLink extends StatelessWidget {
  final String text;
  final Function Navigate;
  const ButtonLink(this.text, this.Navigate, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 211, 209, 209),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: TextButton(
              onPressed: Navigate as void Function(),
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(
                  const Size(double.infinity, 65),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(8),
                ),
                overlayColor: MaterialStateProperty.all(Colors.grey[200]),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                alignment: Alignment.topLeft,
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                foregroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                ),
              ),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
        ],
      ),
    );
  }
}
