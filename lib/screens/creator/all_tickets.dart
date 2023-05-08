import 'package:Eventbrite/screens/creator/tickets_form.dart';
import 'package:Eventbrite/widgets/ticket_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/createevent/createevent.dart';
import '../../widgets/backgroud.dart';
import '../../widgets/tickets_list.dart';

class All_Tickets extends StatelessWidget {
  static const route = '/eventsAllTickets';

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<TheEvent>(context, listen: true);
    final ticketItems = event.alltheTickets;

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
      body: event.totalTicketsLength != 0
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: ListView.builder(
                itemCount: event.totalTicketsLength,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Theme.of(context).colorScheme.error,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 40,
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 4,
                      ),
                    ),
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text(
                            'Do you want to remove the Ticket?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                            ),
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      event.removeTicket(index);
                    },
                    child: TicketsCard(
                        '0',
                        ticketItems[index].name,
                        ticketItems[index].maxquantity.toString(),
                        ticketItems[index].type),
                  );
                },
              ),
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
