library PasswordCheckPhoto;

import '../widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// {@category Widgets}
///
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 40,
            backgroundImage:
                const AssetImage("assets/images/no_user_found.jfif"),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(imageurl),
            ),
          ),
        ),
        Text(email,
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 116, 123, 128),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),
        TextLink('Change', 1, _goBack),
      ],
    );
  }
}
