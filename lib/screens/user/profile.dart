import 'package:eventbrite_replica/widgets/grey_area.dart';
import 'package:eventbrite_replica/widgets/profile_layer.dart';
import 'package:eventbrite_replica/widgets/round_profile_image.dart';
import 'package:eventbrite_replica/widgets/verticaldivider.dart';
import 'package:flutter/material.dart';
import '../../widgets/button_find_things.dart';
import '../../widgets/button_link.dart';
import '../../widgets/counterbutton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatelessWidget {
  String firstName;
  String lastName;
  String email;
  String imageUrl;
  int likesCount;
  int myTicketsCount;
  int followingCount;
  final Function logOut;
  Profile(this.firstName, this.lastName, this.imageUrl, this.email,
      this.likesCount, this.myTicketsCount, this.followingCount, this.logOut,
      {super.key});
  static const emailCheckRoute = '/profile';

  Future<void> setLoggedOut(email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLoggedIn", false);
    prefs.setString("email", '');
  }

  void logOutLogic(BuildContext ctx) {
    setLoggedOut(email);
    logOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Stack(
                  children: [
                    //uppergray
                    const GreyArea(),
                    //image
                    ProfileImage(imageUrl),
                    Column(
                      children: [
                        // two texts with icon&layerfortab
                        ProfileLayer(firstName, lastName, email),

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
                              colors: [Colors.transparent, Colors.transparent],
                            ),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CounterButton("Likes", likesCount),
                                const VDivider(),
                                CounterButton("My tickets", myTicketsCount),
                                const VDivider(),
                                CounterButton("Following", followingCount),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              ButtonLink("Notification Centre"),
                              ButtonLink("Linked Accounts"),
                              ButtonLink("Following"),
                              ButtonLink("Ticket Issues"),
                              ButtonLink("Manage Events"),
                              ButtonLink("Settings"),
                            ],
                          ),
                        )
                      ],
                    )
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
              child: GreyButton(logOutLogic, 'Log out')),
        ],
      ),
    );
  }
}
