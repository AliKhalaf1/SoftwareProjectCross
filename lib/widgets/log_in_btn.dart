import 'package:flutter/material.dart';

class LogInBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  const LogInBtn(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 5),
      child: SizedBox(
        height: 66,
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 80,
          child: TextButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              foregroundColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            onPressed: () => onPressed(context),
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
