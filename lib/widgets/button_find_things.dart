import 'package:flutter/material.dart';

class GreyButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  const GreyButton(this.onPressed, this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 0),
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.black12),
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
        onPressed: () => onPressed(context),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
