import 'sign_up.dart';
import 'package:flutter/material.dart';
import '../widgets/button_links.dart';
import '../widgets/log_in_btn.dart';

class ProfileLogIn extends StatelessWidget {
  const ProfileLogIn({super.key});

  void loggingIn(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return const Signup();
    }));
  }

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
        LogInBtn('Log In', loggingIn),
      ],
    );
  }
}
