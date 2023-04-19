library past_events;

import 'package:flutter/material.dart';

import '../../widgets/backgroud.dart';

/// {@category Creator}
/// {@category Screens}
///
/// This Page is used to display the creator's past events.
///
class PastEvents extends StatelessWidget {
  const PastEvents({super.key});
  static const route = '/Pastevents';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background("assets/images/past_events.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(
          Icons.add,
          key: Key("AddPastEvent"),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
