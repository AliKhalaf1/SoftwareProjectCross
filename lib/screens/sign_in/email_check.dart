import 'package:eventbrite_replica/helper_functions/get_users_data.dart';
import 'package:eventbrite_replica/screens/sign_in/password_check.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/sign_in_hint.dart';
import '../../widgets/app_bar_text.dart';
import 'package:email_validator/email_validator.dart';
import '../sign_up/sign_up_form.dart';
import '../../models/user.dart';
import '../../helper_functions/get_auths.dart';

class EmailCheck extends StatefulWidget {
  //Next_btn_active is a boolean variable that is used to determine whether the next button is active or not. If the email is valid, the next button is active, otherwise it is not active.
  var emailText = TextEditingController();
  bool _nextBtnActive = false;
  EmailCheck({super.key});
  static const emailCheckRoute = '/Email-Check';

  @override
  State<EmailCheck> createState() => _EmailCheckState();
}

void emailCheck(BuildContext ctx, String email) {
  if (checkEmail(email)) {
    User user1 = getUserData(email);
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return PasswordCheck(email, user1.imageUrl);
    }));
  } else {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return SignUpForm(email);
    }));
  }
}

class _EmailCheckState extends State<EmailCheck> {
  void _setNextBtnActive(bool set) {
    if (widget._nextBtnActive != set) {
      setState(() {
        widget._nextBtnActive = set;
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        title: const AppBarText('Log in or Sign up'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                margin: const EdgeInsets.only(top: 20),
                child: TextField(
                  controller: widget.emailText,
                  onChanged: (value) => value.isNotEmpty
                      ? _setNextBtnActive(EmailValidator.validate(value))
                      : _setNextBtnActive(false),
                  keyboardType: TextInputType.emailAddress,
                  cursorWidth: 0.5,
                  cursorColor: Colors.grey,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 67, 96, 244),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 67, 96, 244),
                      ),
                    ),
                    floatingLabelStyle: TextStyle(
                      color: Color.fromARGB(255, 67, 96, 244),
                      fontSize: 14,
                    ),
                    labelText: 'Email',
                    hintText: 'Enter email address',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SingInHint(),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 15, bottom: 10),
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                child: TextButton(
                  style: ButtonStyle(
                    overlayColor: widget._nextBtnActive
                        ? MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 199, 197, 197))
                        : MaterialStateProperty.all<Color>(Colors.transparent),
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      GoogleFonts.notoSansSharada(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    fixedSize: MaterialStateProperty.all<Size>(
                      const Size(double.infinity, 50),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(255, 255, 255, 1),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      widget._nextBtnActive
                          ? const Color.fromRGBO(0, 0, 0, 0.7)
                          : const Color.fromARGB(255, 186, 186, 186),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(
                          width: 2.0,
                          color: widget._nextBtnActive
                              ? const Color.fromARGB(174, 134, 132, 132)
                              : const Color.fromARGB(255, 237, 236, 236),
                        ),
                      ),
                    ),
                  ),
                  onPressed: widget._nextBtnActive
                      ? () => emailCheck(context, widget.emailText.text)
                      : () {},
                  child: const Text('Next'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
