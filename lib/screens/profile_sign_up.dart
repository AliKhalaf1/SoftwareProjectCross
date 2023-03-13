import 'package:flutter/material.dart';
import '../widgets/button_links.dart';
import '../widgets/log_in_btn.dart';
import 'sign_up_or_log_in.dart';
import '../common_functions/log_in.dart';

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
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 235, 233, 233),
                blurRadius: 1.0,
                spreadRadius: 0.0,
                offset: Offset.zero, // shadow direction: bottom right
              )
            ],
            border: Border(
              bottom: BorderSide(
                  width: 1, color: Color.fromARGB(255, 232, 231, 231)),
            ),
          ),
          child: LogInBtn('Log In', loggingIn),
        ),
      ],
    );
  }
}
