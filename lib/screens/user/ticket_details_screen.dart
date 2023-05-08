import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/ticket_details.dart';
import 'package:flutter/material.dart';

class TicketsDetailsScreen extends StatefulWidget {
  const TicketsDetailsScreen({super.key});

  @override
  State<TicketsDetailsScreen> createState() => _TicketsDetailsScreenState();
}

class _TicketsDetailsScreenState extends State<TicketsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const AppBarText('Ticket Details'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const TicketDetailsCard();
                  }),
            ),
          ],
        ));
  }
}
