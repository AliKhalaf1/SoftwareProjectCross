import 'package:Eventbrite/screens/creator/tickets_form.dart';
import 'package:Eventbrite/widgets/ticket_card.dart';
import 'package:flutter/material.dart';

import '../../widgets/backgroud.dart';
import '../../widgets/tickets_list.dart';

class All_Tickets extends StatelessWidget {
  bool found = true;
  static const route = '/eventsAllTickets';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(31, 10, 61, 1),
        title: const Text(
          "Tickets",
          style: TextStyle(
            fontFamily: "Neue Plak Extended",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: found
          ? ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TicketsCard('0', 'Platinium', '5', 'Free'),
              ],
            )
          : Background("assets/images/tickets.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(TicketForm.route);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
