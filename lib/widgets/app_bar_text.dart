library AppBarText;

import 'package:flutter/material.dart';

/// {@category Widgets}
/// <h1>This Widget is used to set the title of the AppBar of all the screens in the app.</h1>

class AppBarText extends StatelessWidget {
  final String _title;

  const AppBarText(this._title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: const TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        fontFamily: 'Neue Plak Text',
        fontSize: 23,
      ),
    );
  }
}
