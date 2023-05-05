import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:splash_route/splash_route.dart';

import 'tab_bar.dart';

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
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).pushReplacement(
        SplashRoute(
          targetPage: TabBarScreen(
            title: 'Eventbrite',
            tabBarIndex: 1,
          ),
          splashColor: Colors.white,
          startFractionalOffset: FractionalOffset.bottomRight,
          transitionDuration: const Duration(milliseconds: 2000),
        ),
      ),
    );
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
