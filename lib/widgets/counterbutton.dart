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
              // ignore: prefer_const_constructors
              style: TextStyle(
                  fontFamily: 'Neue Plak extended',
                  fontWeight: FontWeight.w500,
                  fontSize: 19),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              title,
              // ignore: prefer_const_constructors
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
