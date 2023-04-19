library FindTicketsScreen;

import 'package:flutter/material.dart';

/// {@category User}
/// {@category Screens}
///
/// This Page is used to display the user's tickets.
///
class FindTickets extends StatelessWidget {
  const FindTickets({super.key});

  static const findTicketsRoute = '/Find-Tickets';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(child: Text('Find Tickets')),
    );
  }
}
