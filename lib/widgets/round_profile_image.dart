library RoundProfileImage;

import 'package:flutter/material.dart';

/// {@category Widgets}
///
class ProfileImage extends StatelessWidget {
  final String link;
  const ProfileImage(this.link, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 40, bottom: 0),
      child: Center(
        child: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 40,
              backgroundImage:
                  const AssetImage("assets/images/no_user_found.jfif"),
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(link),
              ),
            ),
      
          ),
        ),
      ),
    );
  }
}
