library DraftEventCard;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketsCard extends StatelessWidget {
  final String ticketTitle;
  final String ticketsTaken;
  final String ticketsNumber;
  final String ticketsType;
  TicketsCard(
      this.ticketsTaken, this.ticketTitle, this.ticketsNumber, this.ticketsType,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: key,
      onTap: () {},
      leading: Icon(
        Icons.quick_contacts_mail_sharp,
        color: Colors.amber[700],
      ),
      title: Text(
        ticketTitle,
        style: TextStyle(
          color: Theme.of(context).cardColor,
        ),
      ),
      subtitle: Text(
        '$ticketsTaken / $ticketsNumber Sold',
        style: TextStyle(
          color: Theme.of(context).cardColor,
        ),
      ),
      trailing: Text(
        ticketsType,
        style: TextStyle(
          color: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
