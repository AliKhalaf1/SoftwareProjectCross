import 'package:flutter/material.dart';

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
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: ListTile(
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
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
