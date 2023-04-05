library FilterCategWidget;

import 'package:flutter/material.dart';

class FilterCateg extends StatelessWidget {
  final String title;
  String selection;
  bool buttonState;
  FilterCateg(this.title, this.selection, this.buttonState, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 122, 121, 121),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            selection,
            style: const TextStyle(
                fontSize: 22,
                height: 0.9,
                letterSpacing: 1.3,
                fontFamily: 'Neue Plak Extended',
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(17, 3, 59, 1)),
          ),
        ],
      ),
    );
  }
}
