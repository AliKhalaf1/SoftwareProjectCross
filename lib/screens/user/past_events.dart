import 'package:flutter/material.dart';

import '../../widgets/backgroud.dart';

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
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
