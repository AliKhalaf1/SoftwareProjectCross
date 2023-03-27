import '../../screens/sign_in/email_check.dart';
import '../../widgets/app_bar_text.dart';
import '../../widgets/photo_and_email.dart';
import '../../widgets/text_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helper_functions/log_in.dart';
import '../../models/db_mock.dart';
import '../../models/user.dart';
import '../user/profile.dart';
import '../tab_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PasswordCheck extends StatefulWidget {
  bool _passwordVisible = false;
  bool _logInBtnActive = false;
  final _passwordText = TextEditingController();
  final String email;
  final String imageURL;
  PasswordCheck(this.email, this.imageURL, {super.key});

  static const emailCheckRoute = '/password-check';

  @override
  State<PasswordCheck> createState() => _PasswordCheckState();
}

void signIn(BuildContext ctx, String password, String email) {
  if (DBMock.checkAuth(email, password)) {
    setLoggedIn(email);
    Navigator.of(ctx).popUntil((route) => route.isFirst);
    Navigator.of(ctx).pushReplacement(MaterialPageRoute(builder: (_) {
      return TabBarScreen(title: 'Profile', tabBarIndex: 4);
    }));
  } else {
    ScaffoldMessenger.of(ctx)
        .showSnackBar(const SnackBar(content: Text('Wrong password')));
  }
}

class _PasswordCheckState extends State<PasswordCheck> {
  void _setLogInBtnActive(bool set) {
    if (widget._logInBtnActive != set) {
      setState(() {
        widget._logInBtnActive = set;
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
        foregroundColor: Colors.black,
        title: const AppBarText('Log in'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        margin: const EdgeInsets.only(top: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            PhotoAndEmail(widget.email, widget.imageURL),
                            TextField(
                              controller: widget._passwordText,
                              obscureText: !widget._passwordVisible,
                              onChanged: (value) => value.isNotEmpty
                                  ? _setLogInBtnActive(true)
                                  : _setLogInBtnActive(false),
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
                                labelText: 'Password*',
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 77, 77, 77),
                                  fontSize: 14,
                                ),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ////////////////////Container of Buttons///////////////
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 15, bottom: 10),
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: widget._logInBtnActive
                          ? MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 199, 197, 197))
                          : MaterialStateProperty.all<Color>(
                              Colors.transparent),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.notoSansSharada(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        const Size(double.infinity, 50),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        widget._logInBtnActive
                            ? Theme.of(context).primaryColor
                            : CupertinoColors.systemGrey6,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        widget._logInBtnActive
                            ? Colors.white
                            : const Color.fromARGB(255, 186, 186, 186),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    onPressed: widget._logInBtnActive
                        ? () => signIn(
                            context, widget._passwordText.text, widget.email)
                        : () {},
                    child: const Text('Log In'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all<Color>(
                        Colors.grey[300]!,
                      ),
                      textStyle: MaterialStateProperty.all<TextStyle>(
                        GoogleFonts.notoSansSharada(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                        Size(MediaQuery.of(context).size.width, 50),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(255, 255, 255, 1),
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(0, 0, 0, 0.7)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(174, 134, 132, 132),
                          ),
                        ),
                      ),
                    ),
                    onPressed: widget._logInBtnActive ? () {} : () {},
                    child: const Text('Email me a login link'),
                  ),
                ),
                SizedBox(child: TextLink('I forgot my password', 1, () {})),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomWidget extends StatelessWidget {
  Function onLoginBtnPressed;
  BuildContext ctx;
  BottomWidget({
    super.key,
    required this.widget,
    required this.onLoginBtnPressed,
    required this.ctx,
  });

  final PasswordCheck widget;

  @override
  Widget build(BuildContext context) {
    return const Text('');
  }
}
