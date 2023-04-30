/// {@nodoc}
/// nodoc
/// 

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final String imageurl;
  Background(@required this.imageurl);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imageurl), fit: BoxFit.cover),
      ),
    );
  }
}
