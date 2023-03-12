import 'package:flutter/material.dart';

class TicketText2 extends StatelessWidget {
  const TicketText2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 0),
      child: const Text(
        "Log into the same account you used to buy your tickets.",
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 17,
        ),
      ),
    );
  }
}
