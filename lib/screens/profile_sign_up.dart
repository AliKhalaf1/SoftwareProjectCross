import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/button_links.dart';

class ProfileLogIn extends StatelessWidget {
  const ProfileLogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [
              SizedBox(
                height: 30,
                child: Text(''),
              ),
              SignUpButtonLink('Ticket Issues'),
              SignUpButtonLink('Manage Events'),
              SignUpButtonLink('Settings'),
            ],
          ),
        ),
        Container(
          height: 50,
          child: Card(
            elevation: 3,
            child: TextButton(
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
          ),
        ),
      ],
    );
  }
}
