import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DashCard extends StatelessWidget {
  final String ticketType;
  final int ticketsNumber;
  final int ticketsTaken;
  DashCard(this.ticketType, this.ticketsNumber, this.ticketsTaken, {super.key});

  @override
  Widget build(BuildContext context) {
    double percentageTickets =
        ticketsTaken / (ticketsNumber != 0 ? ticketsNumber : 1);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        key: key,
        leading: CircularPercentIndicator(
          radius: 55,
          lineWidth: 3,
          percent: percentageTickets,
          progressColor: Colors.deepPurple,
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
          center: FittedBox(
            child: Text('${(percentageTickets * 100).toInt()}%'),
          ),
        ),
        title: Text(
          ticketType,
          style: TextStyle(
            color: Theme.of(context).cardColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$ticketsTaken / $ticketsNumber',
              style: TextStyle(
                color: Theme.of(context).cardColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
