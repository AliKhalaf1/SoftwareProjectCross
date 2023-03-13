import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar_text.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpForm extends StatefulWidget {
  bool _signUpBtnActive = false;
  bool _passwordVisible = false;
  var _passwordText = TextEditingController();
  List<bool> checks = [false, false, false, false];
  final String emailText;
  String passText = '';

  SignUpForm(this.emailText, {super.key});

  static const signUpFormRoute = '/Sign-Up-Form';
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  void _setCheck(bool check, int i) {
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
      resizeToAvoidBottomInset: false, // this is new

      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        title: const AppBarText('Sign up'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            //////////////////////////Email///////////////////////////////////
            children: [
              DisabledEmailField(widget: widget),
              ////////////////////////////Confirm Email///////////////////////////////////
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
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: TextField(
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
            ],
          ),
          SignUpBtn(widget: widget),

          //////////////////////////First Name///////////////////////////////////
        ],
      ),
    );
  }
}

class SignUpBtn extends StatelessWidget {
  const SignUpBtn({
    super.key,
    required this.widget,
  });

  final SignUpForm widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 10),
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
            onPressed: widget._signUpBtnActive
                ? () => print('lets gooooooooooo')
                : () {},
            child: const Text('Sign Up'),
          ),
        ),
      ],
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
