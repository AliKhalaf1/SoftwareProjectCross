library EditPassPage;

import 'dart:convert';

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/screens/sign_in/email_check.dart';
import 'package:Eventbrite/screens/user/account_settings.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/loading_spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helper_functions/constants.dart';
import '../../helper_functions/log_out.dart';
import '../../models/db_mock.dart';
import 'package:http/http.dart' as http;

/// {@category user}
/// {@category Screens}
///
/// This Page is used to update the user's <strong> Password </strong>
/// it's used in the [AccountSettings] screen.

class UpdatePassPage extends StatefulWidget {
  UpdatePassPage({super.key});
  static const updatePassRoute = '/Update-Pass';
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  List<bool> checks = [false, false];
  bool _saveBtnActive = false;
  bool _isLoading = false;
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;

  @override
  State<UpdatePassPage> createState() => _UpdatePassPageState();
}

class _UpdatePassPageState extends State<UpdatePassPage> {
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

  void _setCheck(int i, bool value) {
    if (widget.checks[i] != value) {
      widget.checks[i] = value;
    }

    setState(() {
      if ((widget.checks[0] &&
          widget.checks[1] &&
          (widget.newPassController.text != widget.oldPassController.text))) {
        widget._saveBtnActive = true;
      } else {
        widget._saveBtnActive = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const AppBarText('Update Password'),
      ),
      body: widget._isLoading
          ? const LoadingSpinner()
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        margin: const EdgeInsets.only(top: 15),
                        child: TextField(
                          key: const Key('old_password_field'),
                          controller: widget.oldPassController,
                          obscureText: !widget._oldPasswordVisible,
                          onChanged: (value) => value.isNotEmpty
                              ? (value.length >= 8)
                                  ? _setCheck(0, true)
                                  : _setCheck(0, false)
                              : _setCheck(0, false),
                          cursorWidth: 0.5,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            labelText: 'Old Password',
                            suffixIcon: widget._oldPasswordVisible
                                ? IconButton(
                                    icon: Icon(
                                      size: 20,
                                      CupertinoIcons.eye_slash_fill,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget._oldPasswordVisible =
                                            !widget._oldPasswordVisible;
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
                                        widget._oldPasswordVisible =
                                            !widget._oldPasswordVisible;
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 15),
                        margin: const EdgeInsets.only(top: 15),
                        child: TextField(
                          key: const Key('new_password_field'),
                          controller: widget.newPassController,
                          obscureText: !widget._newPasswordVisible,
                          onChanged: (value) {
                            validatePassword(value);
                            value.isNotEmpty
                                ? (value.length >= 8)
                                    ? _setCheck(1, true)
                                    : _setCheck(1, false)
                                : _setCheck(1, false);
                          },
                          cursorWidth: 0.5,
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            labelText: 'New Password',
                            suffixIcon: widget._newPasswordVisible
                                ? IconButton(
                                    icon: Icon(
                                      size: 20,
                                      CupertinoIcons.eye_slash_fill,
                                      color: Colors.grey[600],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        widget._newPasswordVisible =
                                            !widget._newPasswordVisible;
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
                                        widget._newPasswordVisible =
                                            !widget._newPasswordVisible;
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
                                  color:
                                      const Color.fromARGB(255, 101, 103, 125),
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
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            height: 4,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: LinearProgressIndicator(
                                                backgroundColor:
                                                    Colors.grey[300],
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
                Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  height: 65,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 15, top: 0),
                  child: TextButton(
                    key: const Key("save_button"),
                    style: ButtonStyle(
                      overlayColor: widget._saveBtnActive
                          ? MaterialStateProperty.all(Colors.black12)
                          : MaterialStateProperty.all(Colors.transparent),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                          color: widget._saveBtnActive
                              ? Colors.black38
                              : const Color.fromARGB(255, 219, 219, 219),
                          width: 2.2,
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.transparent),
                      foregroundColor: widget._saveBtnActive
                          ? MaterialStateProperty.all(Colors.black87)
                          : MaterialStateProperty.all(Colors.grey[400]),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    onPressed: widget._saveBtnActive
                        ? () async {
                            setState(() {
                              widget._isLoading = true;
                            });
                            // getEmail().then((value) {
                            //   DBMock.updateUserName(
                            //       value,
                            //       widget.firstNameText.text,
                            //       widget.lastNameText.text);

                            //   Navigator.of(context).pop();
                            //   Navigator.of(context).pop(true);
                            // });

                            String token = await getToken();
                            var uri = Uri.parse(
                                '${Constants.host}/auth/update-password');

                            //create multipart request
                            Map<String, String> reqHeaders = {
                              "Content-type": "application/json",
                              'Authorization': 'Bearer $token',
                            };

                            Map<String, String> body = {
                              "old_password": widget.oldPassController.text,
                              "new_password": widget.newPassController.text,
                            };

                            var reqbody = json.encode(body);
                            var response = await http.put(
                              uri,
                              headers: reqHeaders,
                              body: reqbody,
                            );
                            int responseCode = response.statusCode;
                            setState(() {
                              widget._isLoading = false;
                            });
                            print(responseCode);
                            if (responseCode == 200) {
                              setLoggedOut();
                              //handle success
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => EmailCheck(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Password Updated, Please Login Again'),
                                ),
                              );
                            } else if (responseCode == 401) {
                              //handle unauthorized
                              print('unauthorized');
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Wrong password'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Something Went Wrong'),
                                ),
                              );
                            }
                          }
                        : () => {},
                    child: const Text(
                      'Save Changes',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
