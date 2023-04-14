import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/round_profile_image.dart';
import 'package:Eventbrite/widgets/text_link.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final imageurl;
  const MyWidget({this.imageurl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarText('Account Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          ProfileImage(imageurl),
          TextLink('Update Picture', 1, () {})
        ],
      ),
    );
  }
}
