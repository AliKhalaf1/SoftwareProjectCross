library TicketsPage;

import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/ticket_card.dart';
import 'package:flutter/material.dart';

/// {@category user}
/// {@category Screens}
///
/// This Page is used to display the user's tickets.
class TicketsPage extends StatefulWidget {
  const TicketsPage({super.key});

  @override
  State<TicketsPage> createState() => _TicketsPageState();
}

class _TicketsPageState extends State<TicketsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const AppBarText('Tickets'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                const TicketCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
