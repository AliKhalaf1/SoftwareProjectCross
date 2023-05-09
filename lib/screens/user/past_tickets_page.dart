library UpcomingTicketsPage;

import 'package:Eventbrite/providers/tickets/tickets.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/db_mock.dart';
import '../../providers/tickets/ticket.dart';

/// {@category user}
/// {@category Screens}
///
/// This Page is used to display the user's tickets.
class PastTicketsPage extends StatefulWidget {
  PastTicketsPage(this.tickets, {super.key});
  List<Ticket> tickets;

  @override
  State<PastTicketsPage> createState() => _PastTicketsPageState();
}

class _PastTicketsPageState extends State<PastTicketsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return TicketCard(
          widget.tickets[index],
          true,
        );
      },
      itemCount: widget.tickets.length,
    );
  }
}
