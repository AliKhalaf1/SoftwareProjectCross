import 'package:flutter/material.dart';

import '../../widgets/backgroud.dart';

class DraftEvents extends StatelessWidget {
  const DraftEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background("assets/images/draft_events.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
