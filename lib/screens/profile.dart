import 'package:eventbrite_replica/widgets/grey_area.dart';
import 'package:eventbrite_replica/widgets/profile_layer.dart';
import 'package:eventbrite_replica/widgets/round_profile_image.dart';
import 'package:eventbrite_replica/widgets/verticaldivider.dart';
import 'package:flutter/material.dart';
import '../widgets/button_find_things.dart';
import '../widgets/button_link.dart';
import '../widgets/counterbutton.dart';

class Profile extends StatelessWidget {
  String firstName;
  String lastName;
  String email;
  String imageUrl;
  int likesCount;
  int myTicketsCount;
  int followingCount;
  Profile(this.firstName, this.lastName, this.imageUrl, this.email,
      this.likesCount, this.myTicketsCount, this.followingCount,
      {super.key});
  static const emailCheckRoute = '/profile';

  void logOut(BuildContext ctx) {
    Navigator.of(ctx).popUntil((route) => route.isFirst);
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
                              colors: [
                                Colors.white,
                                Color.fromRGBO(246, 246, 248, 1)
                              ],
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
              child: GreyButton(logOut, 'Log out')),
        ],
      ),
    );
  }
}
