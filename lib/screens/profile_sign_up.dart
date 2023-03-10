import '/screens/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileLogIn extends StatelessWidget {
  const ProfileLogIn({super.key});

  void loggingIn(BuildContext ctx)
  {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_)
    {
      return const Signup();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 50,
            child: Text(''),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Ticket Issues',
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {},
                  child:
                      const Text('Manage Features', textAlign: TextAlign.left),
                ),
              ),
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
            onPressed: () => loggingIn(context),
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
