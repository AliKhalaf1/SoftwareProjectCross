library GuestProfileScreen;

import 'package:Eventbrite/helper_functions/events_handlers.dart';
import 'package:Eventbrite/widgets/tab_bar_Events.dart';
import 'package:flutter/material.dart';
import '../../helper_functions/constants.dart';
import '../../widgets/button_link.dart';
import '../../widgets/log_in_btn.dart';
import '../../helper_functions/log_in.dart';
import '../event_page.dart';

/// {@category Guest}
/// {@category Screens}
///# The ProfileSignUp class is a StatelessWidget,that defines a screen for the guest user's profile.
///
///The screen displays three buttons labeled "Ticket Issues," "Manage Events," and "Settings" inside a ListView widget.
///
///At the bottom of the screen, there is a container that contains a LogInBtn widget labeled "Log In".
///
/// The LogInBtn widget has a callback function named "loggingIn" that is executed when the button is pressed.
///
class ProfileSignUp extends StatefulWidget {
  const ProfileSignUp({super.key});

  @override
  State<ProfileSignUp> createState() => _ProfileSignUpState();
}

class _ProfileSignUpState extends State<ProfileSignUp> {
  String error = '';

  final fieldKey = GlobalKey<FormFieldState>();

  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ButtonLink('Ticket Issues', () {},
                          key: const Key('ticket_issues_btn')),
                      ButtonLink('Manage Events', () {
                        loggingIn(context);
                      }, key: const Key('manage_events_btn')),
                      ButtonLink('Access Event By id', () {
                        showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              //------------------------ user input -------------------//
                              return GestureDetector(
                                onTap: () {},
                                behavior: HitTestBehavior.opaque,
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      height: 80,
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Form(
                                        //key: fieldKey,
                                        child: TextFormField(
                                          controller: _emailController,
                                          key: fieldKey,
                                          //Validations

                                          validator: (valuesss) {
                                            if (valuesss!.isEmpty) {
                                              return "Please enter event id";
                                            }
                                          },

                                          /// Go to valid
                                          onSaved: (newValue) async {
                                            bool asd = await checkLoggedUser();
                                            Map<String, dynamic> args = {
                                              'eventId':
                                                  Constants.MockServer == false
                                                      ? newValue
                                                      : "",
                                              'isLogged':
                                                  asd == true ? "1" : "0",
                                              'eventIdMock':
                                                  Constants.MockServer == true
                                                      ? newValue
                                                      : 0,
                                            };

                                            Navigator.of(context).pushNamed(
                                              EventPage.eventPageRoute,
                                              arguments: args,
                                            );
                                          },

                                          cursorColor: const Color.fromARGB(
                                              255, 50, 100, 237),
                                          // maxLength: 20,
                                          style: const TextStyle(),
                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                key: const Key(
                                                    'privateEventBtn'),
                                                icon: const Icon(
                                                    Icons.check_circle),
                                                onPressed: () {
                                                  String message = "";

                                                  selectEventById(
                                                          _emailController.text)
                                                      .then((value) {
                                                    if (value == 200) {
                                                      fieldKey.currentState
                                                          ?.save();
                                                    } else if (value == 404) {
                                                      message =
                                                          "Event is not found";
                                                    } else if (value == 400) {
                                                      message =
                                                          "Event Id is not valid";
                                                    } else {
                                                      message =
                                                          "Something went wrong";
                                                    }
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());
                                                    setState(() {
                                                      error = message;
                                                    });
                                                  });
                                                },
                                                color: Color.fromARGB(
                                                    255, 50, 100, 237),
                                              ),
                                              hintText: "Enter event pass",
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                              floatingLabelStyle:
                                                  const TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 50, 100, 237)),
                                              labelText: 'event password',
                                              border: const OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0)),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 50, 100, 237),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(0)),
                                              )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      error,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              );
                            });
                      }, key: const Key('settings_btn')),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 235, 233, 233),
                  blurRadius: 1.0,
                  spreadRadius: 0.0,
                  offset: Offset.zero, // shadow direction: bottom right
                )
              ],
              border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromARGB(255, 232, 231, 231)),
              ),
            ),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, right: 5),
                child: LogInBtn('Log In', loggingIn, key: Key('LogInBtn')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
