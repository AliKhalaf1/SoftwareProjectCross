import 'package:Eventbrite/widgets/backgroud.dart';
import 'package:flutter/material.dart';

class LiveEvents extends StatelessWidget {
  const LiveEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background("assets/images/live_events.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
