import 'package:flutter/material.dart';

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