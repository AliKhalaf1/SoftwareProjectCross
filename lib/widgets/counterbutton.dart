import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final String title;
  final int counter;
  const CounterButton(this.title, this.counter, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        onPressed: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              counter.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 19,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Color.fromRGBO(66, 94, 203, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
