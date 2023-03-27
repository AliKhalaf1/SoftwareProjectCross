import 'package:flutter/material.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key});

  static const eventPageRoute = '/Event-Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Edit app-bar to be as application
      appBar: AppBar(
        backgroundColor: Colors.white38,
        foregroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
        elevation: 0,
      ),
      body: const Center(
        child: Text("Event Page"),
      ),
    );
  }
}
