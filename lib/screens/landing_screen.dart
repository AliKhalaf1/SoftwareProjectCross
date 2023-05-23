library LandingScreen;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:splash_route/splash_route.dart';
import 'package:audioplayers/audioplayers.dart';
import 'tab_bar.dart';

/// {@category user}
/// {@category Screens}
///
///Flutter code for a landing screen that displays a logo for a certain duration before redirecting the user to a target page.

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});
  static const landingScreenRoute = '/';
  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () async {
      Navigator.of(context).pushReplacement(
        SplashRoute(
          targetPage: TabBarScreen(
            title: 'Eventbrite',
            tabBarIndex: 1,
          ),
          splashColor: Colors.white,
          startFractionalOffset: FractionalOffset.bottomRight,
          transitionDuration: const Duration(milliseconds: 2000),
        ),
      );

      final player = AudioPlayer();
      await player.play(AssetSource('sounds/welcome.mp4'));
      await player.onPlayerComplete.first;
      await player.stop();
    });
    return Scaffold(
      appBar: null,
      //get system main primary color
      backgroundColor: Theme.of(context).primaryColor,

      body: const Center(
        child: Image(
          image: AssetImage("assets/images/icon.png"),
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}
