library NotificationButton;

import 'package:flutter/material.dart';

/// {@category Widgets}
///
/// <h1>This widget is a button that is used to navigate to the [NotificationScreen]</h1>.
///
/// It contains a bell icon and takes it's text as input.
class ButtonNotification extends StatelessWidget {
  final String text;
  const ButtonNotification(this.text, {super.key});

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
              onPressed: () {},
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
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 13),
                    Text(
                      text,
                    ),
                  ],
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
