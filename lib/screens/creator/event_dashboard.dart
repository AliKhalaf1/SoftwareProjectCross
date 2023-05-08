import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';

class EventsDashboard extends StatefulWidget {
  const EventsDashboard({super.key});

  @override
  State<EventsDashboard> createState() => _EventsDashboardState();
}

class _EventsDashboardState extends State<EventsDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('Event Dashboard'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CircleProgressBar(
              foregroundColor: Colors.orange,
              value: 0.5,
              backgroundColor: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
