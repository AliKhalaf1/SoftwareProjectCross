library LogInBtn;

// import 'package:eventbrite_replica/widgets/google_icon.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

/// {@category Widgets}
///<b> TextButton() </b>
/// with certain styling used for
///<b>LogIn</b>
///.
///
/// It navigates to
///<strong>sign_up_or_log_in</strong>
///screen.
class LogInBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  const LogInBtn(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 70,
        width: double.infinity,
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
          // height: 60,
          child: TextButton(
            key: key,
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
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
