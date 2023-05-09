library TicketDetails;

import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

/// {@category Widgets}
///
/// Code for displaying a ticket details card UI.

class TicketDetailsCard extends StatelessWidget {
  const TicketDetailsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyTicketView();
  }
}

class MyTicketView extends StatelessWidget {
  const MyTicketView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey.shade300, width: 1.0, style: BorderStyle.solid),
      ),
      child: TicketWidget(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 350,
        isCornerRounded: true,
        padding: EdgeInsets.all(20),
        child: TicketData(),
      ),
    );
  }
}

class TicketData extends StatelessWidget {
  const TicketData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120.0,
              height: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(width: 1.0, color: Colors.green),
              ),
              child: const Center(
                child: Text(
                  'Regular',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
            const SizedBox(
              width: 120.0,
              child: Text(
                "#123456789797asfkmaskfmr8",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            'Flight Ticket',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ticketDetailsWidget(
                  'Name', 'Hafiz M Mujahid', 'Date', '28-08-2022'),
              Padding(
                padding: const EdgeInsets.only(top: 12.0, right: 52.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ticketDetailsWidget(
                      'Email', 'ahmed.moh.saad.hussein.ali@gmail.com', '', ''),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 12.0, right: 53.0),
              //   child: ticketDetailsWidget('', 'Business', 'Seat', '21B'),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget ticketDetailsWidget(String firstTitle, String firstDesc,
    String secondTitle, String secondDesc) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              firstTitle,
              style: const TextStyle(color: Colors.grey),
              overflow: TextOverflow.fade,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: SizedBox(
                width: 100.0,
                child: Text(
                  firstDesc,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              secondTitle,
              overflow: TextOverflow.fade,
              style: const TextStyle(color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                secondDesc,
                overflow: TextOverflow.fade,
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      )
    ],
  );
}
