library VerticalDivider;

import 'package:flutter/material.dart';

/// {@category Widgets}
///
/// <h1>The VDivider is a StatelessWidget that displays a vertical line. </h1>
///
/// it takes no parameters.
///
class VDivider extends StatelessWidget {
  const VDivider({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return VerticalDivider(
      color: Colors.black,
      thickness: 0.3,
    );
  }
}
