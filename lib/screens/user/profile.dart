library UserProfileScreen;

import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:Eventbrite/helper_functions/log_in.dart';

import 'package:Eventbrite/providers/events/fav_events.dart';
import 'package:Eventbrite/screens/user/account_settings.dart';
import 'package:Eventbrite/widgets/loading_spinner.dart';
import 'package:provider/provider.dart';

import '../../helper_functions/api/google_signin_api.dart';
import '../../helper_functions/events_handlers.dart';
import '../../helper_functions/log_out.dart';
import '../../helper_functions/organizer_view.dart';
import '../../helper_functions/userInfo.dart';

import '../../widgets/button_notificatin.dart';
import '../../widgets/grey_area.dart';
import '../../widgets/profile_layer.dart';
import '../../widgets/round_profile_image.dart';
import '../../widgets/verticaldivider.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_find_things.dart';
import '../../widgets/button_link.dart';
import '../../widgets/counter_button.dart';
import '../event_page.dart';

/// {@category user}
/// {@category Screens}
/// # A screen that displays a user's profile information and allows the user to log out.
///
/// This screen displays the user's profile picture, name, email, and various counters for likes, tickets,
/// and followings.
///
/// It also displays buttons for accessing various parts of the app, such as the notification
/// center and settings page.
///
/// To log out of the app, the user can tap the "Log out" button at the bottom of the screen.
///
///This Screen depends mainly on 6 widgets GreyArea , ProfileImage, ProfileLayer, CounterButton, ButtonLink
///
///and GreyButtonLogOut.

class Profile extends StatefulWidget {
  String firstName = '';
  String lastName = '';
  String email = '';
  String imageUrl = '';
  int likesCount = 0;
  int myTicketsCount = 0;
  int followingCount = 0;
  bool isLoading = false;
  final Function logOut;
  Profile(this.logOut, {super.key});
  static const emailCheckRoute = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void logOutLogic(BuildContext ctx) {
    setLoggedOut();

    GoogleSignInApi.isSignedIn().then((value) {
      if (value == true) {
        GoogleSignInApi.logout();
      }
    });

    widget.logOut();
  }

  void goToAccountSettings(BuildContext ctx) {
    var res = Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return AccountSettings(
        widget.email,
        widget.firstName,
        widget.lastName,
        widget.imageUrl,
      );
    }));
    res.then((value) {
      if (value != null) {
        if (value == true) {
          print("value is true");
          Refresh();
        } else {
          print("value is false");
        }
      } else {
        print("value is null");
      }
    });
  }

  void Refresh() {
    setState(() {
      widget.isLoading = true;
    });

    Future<String> token;
    if (Constants.MockServer == true) {
      token = getEmail();
    } else {
      token = getToken();
    }

    token.then((value) {
      var favEventsData = Provider.of<FavEvents>(context, listen: false);
      getUserInfo(value).then((currUser) {
        setState(() {
          widget.email = currUser.email;
          widget.firstName = currUser.firstName;
          widget.lastName = currUser.lastName;
          widget.imageUrl = currUser.imageUrl;
          widget.likesCount = favEventsData.favs.length;
          widget.myTicketsCount = 0;
          widget.followingCount = 0;
        });
      });
      setState(() {
        widget.isLoading = false;
      });
    });
  }

  @override
  void initState() {
    Refresh();
    super.initState();
  }

  String error = '';
  final fieldKey = GlobalKey<FormFieldState>();

  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Refresh();
        },
        child: widget.isLoading == true
            ? const LoadingSpinner()
            : Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        Stack(
                          children: [
                            //uppergray
                            const GreyArea(),
                            //image
                            InkWell(
                              onTap: () => goToAccountSettings(context),
                              // onFocusChange: (value) => goToAccountSettings(context),

                              child: IgnorePointer(
                                  child: ProfileImage(widget.imageUrl)),
                            ),

                            Column(
                              children: [
                                // two texts with icon & layerfortab
                                ProfileLayer(
                                  widget.firstName,
                                  widget.lastName,
                                  widget.email,
                                  () => goToAccountSettings(context),
                                  key: const Key('Profile Layer'),
                                ),

                                const SizedBox(
                                  height: 5,
                                ),
                                // Container(
                                //   margin: const EdgeInsets.only(
                                //       top: 15, bottom: 15),
                                //   padding: const EdgeInsets.only(
                                //       top: 15, bottom: 15),
                                //   decoration: const BoxDecoration(
                                //     gradient: LinearGradient(
                                //       begin: Alignment.topCenter,
                                //       end: Alignment.bottomCenter,
                                //       colors: [
                                //         Colors.transparent,
                                //         Colors.transparent
                                //       ],
                                //     ),
                                //   ),
                                //   child: IntrinsicHeight(
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceEvenly,
                                //       children: [
                                //         CounterButton(
                                //           "Likes",
                                //           widget.likesCount,
                                //           key: const Key('Likes'),
                                //         ),
                                //         const VDivider(),
                                //         CounterButton(
                                //             "My tickets", widget.myTicketsCount,
                                //             key: const Key('Mytickets')),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                //  Container(
                                //   margin: const EdgeInsets.only(
                                //       top: 15, bottom: 15),
                                //   padding: const EdgeInsets.only(
                                //       top: 15, bottom: 15),
                                //   decoration: const BoxDecoration(
                                //     gradient: LinearGradient(
                                //       begin: Alignment.topCenter,
                                //       end: Alignment.bottomCenter,
                                //       colors: [
                                //         Colors.transparent,
                                //         Colors.transparent
                                //       ],
                                //     ),
                                //   ),
                                //   child: IntrinsicHeight(
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceEvenly,
                                //       children: [
                                //         CounterButton(
                                //           "Likes",
                                //           widget.likesCount,
                                //           key: const Key('Likes'),
                                //         ),
                                //         const VDivider(),
                                //         CounterButton(
                                //             "My tickets", widget.myTicketsCount,
                                //             key: const Key('Mytickets')),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const ButtonNotification(
                                        "Notification Centre",
                                        key: Key('Notification'),
                                      ),
                                      ButtonLink("Linked Accounts", () {},
                                          key: const Key('Linked')),
                                      ButtonLink("Access Event By Id", () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (_) {
                                              //------------------------ user input -------------------//
                                              return GestureDetector(
                                                onTap: () {},
                                                behavior:
                                                    HitTestBehavior.opaque,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.9,
                                                      height: 80,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10),
                                                      child: Form(
                                                        //key: fieldKey,
                                                        child: TextFormField(
                                                          controller:
                                                              _emailController,
                                                          key: fieldKey,
                                                          //Validations

                                                          validator:
                                                              (valuesss) {
                                                            if (valuesss!
                                                                .isEmpty) {
                                                              return "Please enter event id";
                                                            }
                                                          },

                                                          /// Go to valid
                                                          onSaved:
                                                              (newValue) async {
                                                            bool asd =
                                                                await checkLoggedUser();
                                                            Map<String, dynamic>
                                                                args = {
                                                              'eventId':
                                                                  Constants.MockServer ==
                                                                          false
                                                                      ? newValue
                                                                      : "",
                                                              'isLogged':
                                                                  asd == true
                                                                      ? "1"
                                                                      : "0",
                                                              'eventIdMock':
                                                                  Constants.MockServer ==
                                                                          true
                                                                      ? newValue
                                                                      : 0,
                                                            };

                                                            Navigator.of(
                                                                    context)
                                                                .pushNamed(
                                                              EventPage
                                                                  .eventPageRoute,
                                                              arguments: args,
                                                            );
                                                          },

                                                          cursorColor:
                                                              const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  50,
                                                                  100,
                                                                  237),
                                                          // maxLength: 20,
                                                          style:
                                                              const TextStyle(),
                                                          decoration:
                                                              InputDecoration(
                                                                  suffixIcon:
                                                                      IconButton(
                                                                    key: const Key(
                                                                        'privateEventBtn'),
                                                                    icon: const Icon(
                                                                        Icons
                                                                            .check_circle),
                                                                    onPressed:
                                                                        () {
                                                                      String
                                                                          message =
                                                                          "";

                                                                      selectEventById(_emailController
                                                                              .text)
                                                                          .then(
                                                                              (value) {
                                                                        if (value ==
                                                                            200) {
                                                                          fieldKey
                                                                              .currentState
                                                                              ?.save();
                                                                        } else if (value ==
                                                                            404) {
                                                                          message =
                                                                              "Event is not found";
                                                                        } else if (value ==
                                                                            400) {
                                                                          message =
                                                                              "Event Id is not valid";
                                                                        } else {
                                                                          message =
                                                                              "Something went wrong";
                                                                        }
                                                                        FocusScope.of(context)
                                                                            .requestFocus(FocusNode());
                                                                        setState(
                                                                            () {
                                                                          error =
                                                                              message;
                                                                        });
                                                                      });
                                                                    },
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            50,
                                                                            100,
                                                                            237),
                                                                  ),
                                                                  hintText:
                                                                      "Enter event pass",
                                                                  floatingLabelBehavior:
                                                                      FloatingLabelBehavior
                                                                          .always,
                                                                  floatingLabelStyle: const TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237)),
                                                                  labelText:
                                                                      'event password',
                                                                  border:
                                                                      const OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(0)),
                                                                  ),
                                                                  focusedBorder:
                                                                      const OutlineInputBorder(
                                                                    borderSide:
                                                                        BorderSide(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          50,
                                                                          100,
                                                                          237),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.all(
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
                                                      style: const TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      }, key: const Key('Following')),
                                      ButtonLink("Ticket Issues", () {},
                                          key: const Key('Issues')),
                                      ButtonLink("Manage Events",
                                          () => eventNavigate(context),
                                          key: const Key('Manage Events')),
                                      ButtonLink("Settings", () {},
                                          key: const Key('Settings')),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: Color.fromARGB(255, 226, 225, 225),
                          width: 1,
                        ),
                        top: BorderSide(
                          color: Color.fromRGBO(246, 246, 248, 1),
                          width: 1,
                        ),
                      ),
                    ),
                    height: 80,
                    padding: const EdgeInsetsDirectional.only(top: 15),
                    width: double.infinity,
                    key: const Key("LogOut"),
                    child: GreyButtonLogout(logOutLogic, 'Log out'),
                  ),
                ],
              ),
      ),
    );
  }
}
