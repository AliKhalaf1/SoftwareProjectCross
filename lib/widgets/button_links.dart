import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpButtonLink extends StatelessWidget {
  final String text;
  SignUpButtonLink(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text('Don\'t have an account?'),
          TextButton(
            onPressed: () {},
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
