import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/button_links.dart';

class ProfileLogIn extends StatelessWidget {
  static const profileLogInRoute = '/profile-signup';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 10,
                child: Text(''),
              ),
              const SignUpButtonLink('Ticket Issues'),
              const SignUpButtonLink('Manage Events'),
            ],
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  const Color.fromARGB(255, 207, 62, 18)),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Log In',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
