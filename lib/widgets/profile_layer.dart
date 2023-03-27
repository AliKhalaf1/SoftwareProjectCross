library ProfileLayer;

import 'package:flutter/material.dart';

/// {@category Widgets}
/// # The ProfileLayer  is StatelessWidget designed to display user profile information.
///
/// The widget is wrapped in a GestureDetector widget that listens for taps.
/// When the widget is tapped, it should navigate the user to a page where they can edit their profile data.
///
/// The widget is designed with a transparent background color and a Column widget to organize its child widgets.
/// The upper of widget is transparent to cover profileimage for tap.
///
/// The main content of the widget is made up of a SizedBox widget and a Column widget.
/// The SizedBox widget is used to create some vertical spacing between the top of the widget and the user's name and email address.
/// The Column widget contains two Text widgets that display the user's name and email address.
///
/// The user's name is displayed using a Row widget that contains a Text widget and an Icon widget.
/// The Text widget displays the user's first and last name, while the Icon widget is used to indicate that the user can edit their profile data.
/// The email address is displayed using a simple Text widget.
///
/// The widget uses custom styles for the text, including a specific font size, weight, and family for the user's data.
class ProfileLayer extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  const ProfileLayer(this.firstName, this.lastName, this.email, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //should add link to page to edit user's data.
      },
      child: Container(
        margin: const EdgeInsetsDirectional.only(top: 40),
        width: double.infinity,
        color: Colors.transparent,
        child: Column(
          children: [
            const SizedBox(
              height: 125,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '$firstName $lastName',
                      style: const TextStyle(
                          fontSize: 32,
                          height: 0.9,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Neue Plak Extended',
                          color: Color.fromRGBO(40, 27, 67, 1)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: const Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: Color.fromRGBO(66, 94, 203, 1),
                      ),
                    ),
                  ],
                ),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
