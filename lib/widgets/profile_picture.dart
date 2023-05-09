library ProfilePicture;

import 'package:flutter/material.dart';

/// {@category Widgets}
///  A widget that displays a user's profile picture.
///
/// The profile picture is displayed as a circular avatar with a transparent
///

class ProfilePicture extends StatelessWidget {
  final String imageurl;
  final String defaultimage;
  const ProfilePicture(this.imageurl, this.defaultimage, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 40,
        backgroundImage: AssetImage(defaultimage),
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.transparent,
          backgroundImage: imageurl.isNotEmpty ? NetworkImage(imageurl) : null,
        ),
      ),
    );
  }
}
