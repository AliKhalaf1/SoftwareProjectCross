library PasswordCheckPhoto;

import 'package:Eventbrite/widgets/profile_picture.dart';
import 'package:Eventbrite/widgets/round_profile_image.dart';

import '../widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@category Widgets}
///
/// Used to display the user's photo and email in [PasswordCheck] Screen .
class PhotoAndEmail extends StatelessWidget {
  final String imageurl;
  final String email;
  const PhotoAndEmail(this.email, this.imageurl, {super.key});

  void _goBack(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ProfilePicture(imageurl, 'assets/images/no_user_found.jfif'),
        ),
        Text(email,
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 116, 123, 128),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),
      ],
    );
  }
}
