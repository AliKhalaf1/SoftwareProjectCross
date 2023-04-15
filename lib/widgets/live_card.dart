import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class LiveCard extends StatelessWidget {
  final String liveDescription;
  final String dateString;
  final int ticketsNumber;
  final int ticketsTaken;
  final int ticketPrice;
  LiveCard(
    this.dateString,
    this.liveDescription,
    this.ticketsNumber,
    this.ticketsTaken,
    this.ticketPrice,
  );

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('EEE, MMM d, h:mm a')
        .format(dateTime); // format the DateTime object
    double percentageTickets = ticketsTaken / ticketsNumber;

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
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
          liveDescription,
          style: TextStyle(
            color: Theme.of(context).cardColor,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: TextStyle(
                color: Theme.of(context).cardColor,
              ),
            ),
            Text(
              '$ticketsTaken / $ticketsNumber',
              style: TextStyle(
                color: Theme.of(context).cardColor,
              ),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text('\$$ticketPrice'),
        ),
      ),
    );
  }
}
