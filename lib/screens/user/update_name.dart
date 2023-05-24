library EditInfoPage;

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/screens/user/account_settings.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../helper_functions/constants.dart';
import '../../models/db_mock.dart';
import 'package:http/http.dart' as http;

import '../../objectbox.dart';
import '../../objectbox.g.dart';

/// {@category user}
/// {@category Screens}
///
/// This Page is used to update the user's <strong> First Name </strong> and <strong> Last Name </strong>.
/// it's used in the [AccountSettings] screen.

class UpdateNamePage extends StatefulWidget {
  String firstName;
  String lastName;
  UpdateNamePage(this.firstName, this.lastName, {super.key});
  static const updateNameRoute = '/Update-Name';
  var firstNameText = TextEditingController();
  var lastNameText = TextEditingController();
  List<bool> checks = [false, false, false];
  bool _saveBtnActive = false;
  bool _isLoading = false;

  @override
  State<UpdateNamePage> createState() => _UpdateNamePageState();
}

class _UpdateNamePageState extends State<UpdateNamePage> {
  void _setCheck(int i, bool value) {
    if (widget.checks[i] != value) {
      widget.checks[i] = value;
    }
    widget.checks[2] = (widget.firstNameText.text.isNotEmpty &&
        widget.lastNameText.text.isNotEmpty);

    setState(() {
      if ((widget.checks[0] || widget.checks[1]) && widget.checks[2]) {
        widget._saveBtnActive = true;
      } else {
        widget._saveBtnActive = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.firstNameText.text = widget.firstName;
    widget.lastNameText.text = widget.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const AppBarText('Edit Profile'),
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
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        margin: const EdgeInsets.only(top: 20),
                        child: TextField(
                          maxLength: 20,
                          key: const Key("first_name_text_field"),
                          controller: widget.firstNameText,
                          onChanged: (value) {
                            _setCheck(0,
                                value.isNotEmpty && value != widget.firstName);
                          },
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
                            labelText: 'First Name',
                            hintText: 'Enter first name',
                            hintStyle: TextStyle(
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
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        margin: const EdgeInsets.only(top: 20),
                        child: TextField(
                          maxLength: 20,
                          key: const Key("last_name_text_field"),
                          controller: widget.lastNameText,
                          onChanged: (value) {
                            _setCheck(1,
                                value.isNotEmpty && value != widget.lastName);
                          },
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
                            labelText: 'Last Name',
                            hintText: 'Enter last name',
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
                            ///////////////////////////////////////////////////////////////////////////////////////
                            if (Constants.MockServer == true) {
                              getEmail().then((value) {
                                var userbox = ObjectBox.userBox;
                                var user = userbox
                                    .query(User_.email.equals(value))
                                    .build()
                                    .findFirst();
                                user!.firstName = widget.firstNameText.text;
                                user.lastName = widget.lastNameText.text;

                                userbox.put(user);

                                Navigator.of(context).pop();
                                Navigator.of(context).pop(true);
                              });
                            } else {
                              ///////////////////////////////////////////////////////////////////////////////////////
                              /// api implementation
                              String token = await getToken();
                              var uri = Uri.parse(
                                  '${Constants.host}/users/me/edit?firstname=${widget.firstNameText.text}&lastname=${widget.lastNameText.text}');

                              //create multipart request
                              Map<String, String> reqHeaders = {
                                'Authorization': 'Bearer $token',
                              };
                              var response = await http.put(
                                uri,
                                headers: reqHeaders,
                              );
                              int responseCode = response.statusCode;
                              setState(() {
                                widget._isLoading = false;
                              });
                              Navigator.of(context).pop();
                              Navigator.of(context).pop(true);
                              print(responseCode);
                              if (responseCode != 200) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Error updating info'),
                                  ),
                                );
                              }
                            }
                            ///////////////////////////////////////////////////////////////////////////////////////
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
