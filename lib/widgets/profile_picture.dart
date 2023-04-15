import 'package:flutter/material.dart';

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
          backgroundImage: NetworkImage(imageurl),
        ),
      ),
    );
  }
}
