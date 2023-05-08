library liveCard;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../screens/creator/live_events.dart';

/// {@category Creator}
/// {@category Widgets}
///
/// This widget is used to display the live events in the creator's home page.
///
/// It is used in [LiveEvents].
///

class LiveCard extends StatelessWidget {
  final String liveDescription;
  final String dateString;
  final int ticketsNumber;
  final int ticketsTaken;
  final double ticketPrice;
  LiveCard(this.dateString, this.liveDescription, this.ticketsNumber,
      this.ticketsTaken, this.ticketPrice,
      {required Key key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('EEE, MMM d, h:mm a')
        .format(dateTime); // format the DateTime object
    double percentageTickets =
        ticketsTaken / (ticketsNumber != 0 ? ticketsNumber : 1);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        key: key,
        onTap: () {},
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
