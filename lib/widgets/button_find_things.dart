import 'package:flutter/material.dart';

class ButtonThingsToDo extends StatelessWidget {
  final Function onPressed;
  const ButtonThingsToDo(this.onPressed, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
      child: TextButton(
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(
              color: Colors.black38,
              width: 2.2,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.white),
          foregroundColor: MaterialStateProperty.all(Colors.black54),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        onPressed: () {
          onPressed;
        },
        child: const Text(
          'Find things to do',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
