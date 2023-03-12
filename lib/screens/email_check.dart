import 'package:eventbrite_replica/widgets/google_icon.dart';
import 'package:eventbrite_replica/widgets/transparent_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailCheck extends StatelessWidget {
  const EmailCheck({super.key});
  static const emailCheckRoute = '/Email-Check';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        title: const Text(
          'Log in or Sign up',
          style: TextStyle(
            color: Colors.black,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w700,
            fontFamily: 'Neue Plak Extended',
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFormField(
                    cursorWidth: 0.5,
                    cursorColor: Colors.grey,
                    decoration: const InputDecoration(
                      focusColor: Colors.black,
                      labelText: 'Email',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            margin: const EdgeInsets.only(top: 20),
            width: double.infinity,
            child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(
                  Colors.grey,
                ),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  GoogleFonts.notoSansSharada(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                  const Size(double.infinity, 50),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(255, 255, 255, 1),
                ),
                foregroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromRGBO(0, 0, 0, 0.7),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(
                      width: 2.0,
                      color: Color.fromARGB(175, 154, 153, 153),
                    ),
                  ),
                ),
              ),
              child: const Text('Next'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
