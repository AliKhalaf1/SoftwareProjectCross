import 'package:flutter/material.dart';

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
            child: Ink.image(
              image: Image.network(link).image,
              fit: BoxFit.cover,
              width: 92,
              height: 92,
            ),
          ),
        ),
      ),
    );
  }
}
