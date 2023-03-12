import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class LogInBtnFavourites extends StatelessWidget {
  final Function onPressed;
  const LogInBtnFavourites(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 209, 65, 12)),
        foregroundColor: MaterialStateProperty.all(Colors.white),
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
        'Log In',
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
