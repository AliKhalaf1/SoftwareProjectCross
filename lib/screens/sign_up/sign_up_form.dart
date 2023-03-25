import 'dart:ui';
import 'package:eventbrite_replica/models/db_mock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helper_functions/log_in.dart';
import '../../models/auth.dart';
import '../../models/user.dart';
import '../../widgets/app_bar_text.dart';
import 'package:google_fonts/google_fonts.dart';

import '../tab_bar.dart';

class SignUpForm extends StatefulWidget {
  bool _signUpBtnActive = false;
  bool _passwordVisible = false;
  final _passwordText = TextEditingController();
  final _firstNameText = TextEditingController();
  final _lastNameText = TextEditingController();
  List<bool> checks = [false, false, false, false];
  final String emailText;
  String passText = '';

  SignUpForm(this.emailText, {super.key});

  static const signUpFormRoute = '/Sign-Up-Form';
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // regular expression to check if string
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double passwordStrength = 0;
  // 0: No password
  // 1/4: Weak
  // 1/2: Average
  //   1: Great
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (password.isEmpty) {
      setState(() {
        passwordStrength = 0;
      });
    } else if (password.length < 8) {
      setState(() {
        passwordStrength = 1 / 4;
      });
    } else {
      if (passValid.hasMatch(password)) {
        setState(() {
          passwordStrength = 1;
        });
        return true;
      } else {
        setState(() {
          passwordStrength = 1 / 2;
        });
        return false;
      }
    }
    return false;
  }

  void signUp() {
    String userFirstName = widget._firstNameText.text;
    String userLastName = widget._lastNameText.text;
    String userPassword = widget._passwordText.text;
    String userEmail = widget.emailText;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          'Terms and Conditions'),
                      const SizedBox(height: 3),
                      Text(
                        'By signing up or logging in, you agree to our Terms and Conditions and Privacy Policy',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).primaryColor),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  child: const Text('Agree'),
                  onPressed: () {
                    signUp2();
                  },
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                      style: TextStyle(
                        color: Colors.blue[900],
                      ),
                      'Cancel'),
                ),
              ],
            ),
          );
        });
  }

  void signUp2() {
    String userFirstName = widget._firstNameText.text;
    String userLastName = widget._lastNameText.text;
    String userPassword = widget._passwordText.text;
    String userEmail = widget.emailText;
    bool added = DBMock.addUser(
      User(
        userEmail,
        '',
        userFirstName,
        userLastName,
      ),
      Auth(userEmail, userPassword),
    );
    if (added) {
      setLoggedIn(userEmail);
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context)
          .pushReplacementNamed(TabBarScreen.tabBarScreenRoute, arguments: {
        'title': 'Eventbrite',
        'tabBarIndex': 4,
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email already exists'),
        ),
      );
    }
  }

  void _setCheck(bool check, int i) {
    validatePassword(widget._passwordText.text);
    if (widget.checks[i] != check) {
      setState(() {
        widget.passText = widget._passwordText.text;
        widget.checks[i] = check;
        if (widget.checks[0] &&
            widget.checks[1] &&
            widget.checks[2] &&
            widget.checks[3]) {
          widget._signUpBtnActive = true;
        } else {
          widget._signUpBtnActive = false;
        }
      });
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: MediaQuery.of(context).orientation == Orientation.landscape
          ? null
          : AppBar(
              backgroundColor: Colors.white,
              foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
              title: const AppBarText('Sign up'),
            ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: ListView(
              children: [
                //////////////////////////EMAIL///////////////////////////////////
                DisabledEmailField(widget: widget),
                ////////////////////////////CONFIM EMAIL FIELD///////////////////////////////////
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    onChanged: (value) => value.isNotEmpty
                        ? value == widget.emailText
                            ? _setCheck(true, 0)
                            : _setCheck(false, 0)
                        : _setCheck(false, 0),
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
                      labelText: 'Confirm Email*',
                      hintText: 'Confirm email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                ////////////////////////////FIRST NAME & LAST NAME FIELDS///////////////////////////////////
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextField(
                          controller: widget._firstNameText,
                          selectionWidthStyle: BoxWidthStyle.tight,
                          onChanged: (value) => value.isNotEmpty
                              ? _setCheck(true, 1)
                              : _setCheck(false, 1),
                          keyboardType: TextInputType.name,
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
                            labelText: 'First Name*',
                            hintText: 'Enter first name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: TextField(
                          controller: widget._lastNameText,
                          selectionWidthStyle: BoxWidthStyle.tight,
                          onChanged: (value) => value.isNotEmpty
                              ? _setCheck(true, 2)
                              : _setCheck(false, 2),
                          keyboardType: TextInputType.name,
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
                            labelText: 'Surname*',
                            hintText: 'Enter surname',
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
                ),
                ////////////////////////////PASSWORD FIELD///////////////////////////////////
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  margin: const EdgeInsets.only(top: 15),
                  child: TextField(
                    controller: widget._passwordText,
                    obscureText: !widget._passwordVisible,
                    onChanged: (value) => value.isNotEmpty
                        ? (value.length >= 8)
                            ? _setCheck(true, 3)
                            : _setCheck(false, 3)
                        : _setCheck(false, 3),
                    cursorWidth: 0.5,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      suffixIcon: widget._passwordVisible
                          ? IconButton(
                              icon: Icon(
                                size: 20,
                                CupertinoIcons.eye_slash_fill,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                setState(() {
                                  widget._passwordVisible =
                                      !widget._passwordVisible;
                                });
                              },
                            )
                          : IconButton(
                              icon: Icon(
                                size: 20,
                                CupertinoIcons.eye_fill,
                                color: Colors.grey[600],
                              ),
                              onPressed: () {
                                setState(() {
                                  widget._passwordVisible =
                                      !widget._passwordVisible;
                                });
                              },
                            ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 67, 96, 244),
                        ),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Color.fromARGB(255, 67, 96, 244),
                        ),
                      ),
                      floatingLabelStyle: const TextStyle(
                        color: Color.fromARGB(255, 67, 96, 244),
                        fontSize: 14,
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                ////////////////////////////PASSWORD STRENGTH BAR///////////////////////////////////
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          passwordStrength == 0
                              ? 'Passwords must have at least 8 characters'
                              : 'Password strength',
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(255, 101, 103, 125),
                            fontSize: 13.5,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              passwordStrength == 0
                                  ? ''
                                  : passwordStrength <= 1 / 4
                                      ? 'Weak'
                                      : passwordStrength == 1 / 2
                                          ? 'Average'
                                          : 'Great!',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 101, 103, 125),
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                            passwordStrength == 0
                                ? const Text('')
                                : Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height: 4,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: LinearProgressIndicator(
                                          backgroundColor: Colors.grey[300],
                                          color: passwordStrength <= 1 / 4
                                              ? const Color.fromARGB(
                                                  255, 189, 33, 21)
                                              : passwordStrength == 1 / 2
                                                  ? Colors.yellow
                                                  : Colors.green[700],
                                          minHeight: 5,
                                          value: passwordStrength,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(child: SignUpBtn(SignUpFn: signUp, widget: widget)),
        ],
      ),
    );
  }
}

class SignUpBtn extends StatelessWidget {
  Function SignUpFn;
  SignUpBtn({
    required this.SignUpFn,
    super.key,
    required this.widget,
  });

  final SignUpForm widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: widget._signUpBtnActive
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
            widget._signUpBtnActive
                ? Theme.of(context).primaryColor
                : CupertinoColors.systemGrey6,
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            widget._signUpBtnActive
                ? Colors.white
                : const Color.fromARGB(255, 186, 186, 186),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
        ),
        onPressed: widget._signUpBtnActive ? () => SignUpFn() : () {},
        child: const Text('Sign Up'),
      ),
    );
  }
}

class DisabledEmailField extends StatelessWidget {
  const DisabledEmailField({
    super.key,
    required this.widget,
  });

  final SignUpForm widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
          margin: const EdgeInsets.only(top: 10, bottom: 15),
          child: TextField(
            decoration: InputDecoration(
              border: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Color.fromARGB(255, 67, 96, 244),
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.solid,
                  color: Color.fromARGB(255, 67, 96, 244),
                ),
              ),
              floatingLabelStyle: const TextStyle(
                color: Color.fromARGB(255, 67, 96, 244),
                fontSize: 14,
              ),
              labelText: 'Email',
              enabled: false,
              hintText: widget.emailText,
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ),
      ],
    );
  }
}
