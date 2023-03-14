import 'package:flutter/material.dart';

class GreyArea extends StatelessWidget {
  const GreyArea({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        // ignore: prefer_const_constructors
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [Colors.white, Color.fromRGBO(246, 246, 248, 1)],
        ),
      ),
      height: 90,
    );
  }
}
