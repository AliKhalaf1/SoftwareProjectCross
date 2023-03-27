library GreyArea;

import 'package:flutter/material.dart';

/// {@category Widgets}
/// # This widget displays a gray area with a white-to-gray linear gradient.
///
/// This widget takes no arguments and has a height of 90.
///
/// It is intended to be used to visually separate different parts of a user interface.

class GreyArea extends StatelessWidget {
  const GreyArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Color.fromRGBO(246, 246, 248, 1)],
        ),
      ),
      height: 90,
    );
  }
}
