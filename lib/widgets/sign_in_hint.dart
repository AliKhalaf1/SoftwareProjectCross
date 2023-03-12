import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SingInHint extends StatelessWidget {
  const SingInHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: const ShapeDecoration(
              shadows: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  offset: Offset(-2, 5),
                ),
              ],
              shape: CircleBorder(),
              color: Color.fromARGB(255, 67, 96, 244),
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: Icon(
                CommunityMaterialIcons.ticket_confirmation_outline,
                fill: 0,
                weight: 800,
                color: Color.fromARGB(255, 69, 68, 68),
                size: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: FittedBox(
              child: Text(
                'Sign in with the same email\naddress you used to get your\ntickets.',
                style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 103, 108, 135),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
