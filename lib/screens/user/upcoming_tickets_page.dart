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
class UpcomingTicketsPage extends StatefulWidget {
  UpcomingTicketsPage({super.key});
  List<Ticket> tickets = [];

  @override
  State<UpcomingTicketsPage> createState() => _UpcomingTicketsPageState();
}

class _UpcomingTicketsPageState extends State<UpcomingTicketsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tickets_prov = Provider.of<Tickets>(context, listen: false);
    widget.tickets = tickets_prov.upcomingTickets;
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return TicketCard(
          widget.tickets[index],
          false,
        );
      },
      itemCount: widget.tickets.length,
    );
  }
}
