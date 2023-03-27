library AppBarText;

import 'package:flutter/material.dart';

/// {@name AppBarText}
/// {@category Widgets}
/// This Widget is used to set the title of the AppBar of all the screens in the app.

class AppBarText extends StatelessWidget {
  /// The title of the AppBar.
  final String _title;

  /// The key of the AppBarText Widget.
  const AppBarText(this._title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      _title,
      style: const TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        //wordSpacing: -2.0,
        fontFamily: 'Neue Plak Text',
        fontSize: 23,
      ),
    );
  }
}
