library UserProfileScreen;

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/models/db_mock.dart';
import 'package:Eventbrite/providers/events/event.dart';
import 'package:Eventbrite/providers/events/fav_events.dart';
import 'package:Eventbrite/screens/user/account_settings.dart';
import 'package:provider/provider.dart';

import '../../helper_functions/log_out.dart';
import '../../helper_functions/organizer_view.dart';
import '../../models/user.dart';
import '../../objectbox.dart';
import '../../objectbox.g.dart';
import '../../providers/events/events.dart';
import '../../widgets/button_notificatin.dart';
import '../../widgets/grey_area.dart';
import '../../widgets/profile_layer.dart';
import '../../widgets/round_profile_image.dart';
import '../../widgets/verticaldivider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/button_find_things.dart';
import '../../widgets/button_link.dart';
import '../../widgets/counter_button.dart';

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
  final Function logOut;
  Profile(this.logOut, {super.key});
  static const emailCheckRoute = '/profile';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  void logOutLogic(BuildContext ctx) {
    setLoggedOut(widget.email);
    widget.logOut();
  }

  void goToAccountSettings(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return AccountSettings(imageurl: widget.imageUrl);
    }));
  }

  void Refresh() {
    Future<String> s = getEmail();

    s.then((value) {
      var userbox = ObjectBox.userBox;
      User currUser =
          userbox.query(User_.email.equals(value)).build().findFirst()!;

      // User currUser = DBMock.getUserData(value);
      var favEventsData = Provider.of<FavEvents>(context, listen: false);

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
  }

  @override
  void initState() {
    Refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          Refresh();
        },
        child: Column(
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

                        child:
                            IgnorePointer(child: ProfileImage(widget.imageUrl)),
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
                          Container(
                            margin: const EdgeInsets.only(top: 15, bottom: 15),
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.transparent
                                ],
                              ),
                            ),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CounterButton(
                                    "Likes",
                                    widget.likesCount,
                                    key: const Key('Likes'),
                                  ),
                                  const VDivider(),
                                  CounterButton(
                                      "My tickets", widget.myTicketsCount,
                                      key: const Key('Mytickets')),
                                  const VDivider(),
                                  CounterButton(
                                      "Following", widget.followingCount,
                                      key: const Key('Following')),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const ButtonNotification(
                                  "Notification Centre",
                                  key: Key('Notification'),
                                ),
                                ButtonLink("Linked Accounts", () {},
                                    key: const Key('Linked')),
                                ButtonLink("Following", () {},
                                    key: const Key('Following')),
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
              child: GreyButtonLogout(logOutLogic, 'Log out'),
              key: const Key("LogOut"),
            ),
          ],
        ),
      ),
    );
  }
}
