import 'package:eventbrite_replica/widgets/grey_area.dart';
import 'package:eventbrite_replica/widgets/profile_layer.dart';
import 'package:eventbrite_replica/widgets/round_profile_image.dart';
import 'package:eventbrite_replica/widgets/verticaldivider.dart';
import 'package:flutter/material.dart';
import '../widgets/button_find_things.dart';
import '../widgets/button_links.dart';
import '../widgets/counterbutton.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Stack(
                children: [
                  //uppergray
                  const GreyArea(),
                  //image
                  const ProfileImage("assets/images/yla.png"),
                  Column(
                    children: [
                      // two texts with icon&layerfortab
                      const ProfileLayer(
                          'Ahmed Magdy', 'ahmedfec2000@gmail.com'),

                      const SizedBox(
                        height: 5,
                      ),
                      Container(
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
                            children: const [
                              CounterButton("Likes", 0),
                              VDivider(),
                              CounterButton("My tickets", 0),
                              VDivider(),
                              CounterButton("Following", 0),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            SignUpButtonLink("Notification Centre"),
                            SignUpButtonLink("Linked Accounts"),
                            SignUpButtonLink("Following"),
                            SignUpButtonLink("Ticket Issues"),
                            SignUpButtonLink("Manage Events"),
                            SignUpButtonLink("Settings"),
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
            height: 70,
            padding: const EdgeInsetsDirectional.only(top: 15),
            width: double.infinity,
            child: GreyButton(() {}, 'Log out')),
      ],
    );
  }
}
