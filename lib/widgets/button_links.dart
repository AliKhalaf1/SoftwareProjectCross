import 'package:flutter/material.dart';

class SignUpButtonLink extends StatelessWidget {
  final String text;
  const SignUpButtonLink(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.all(10),
      //padding: const EdgeInsets.all(8.0),
      foregroundDecoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            style: ButtonStyle(
              alignment: Alignment.topLeft,
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: () {},
            child: Text(text),
          ),
          const Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey),
        ],
      ),
    );
  }
}
