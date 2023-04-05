library NearbyEventsScreen;


import 'package:flutter/material.dart';

class NearbyEvents extends StatelessWidget {
  const NearbyEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        elevation: 0,
        ),
      body: Center(child: Text('Online events')),
      );
  }
}