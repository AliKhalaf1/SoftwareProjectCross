library TicketDetails;

import 'dart:convert';

import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

import '../helper_functions/log_in.dart';
import '../models/Ticket_attendee.dart';

/// {@category Widgets}
///
/// Code for displaying a ticket details card UI.

class TicketDetailsCard extends StatelessWidget {
  final TicketAttendee ticket;
  TicketDetailsCard(this.ticket, {super.key});

  @override
  Widget build(BuildContext context) {
    return MyTicketView(ticket);
  }
}

class MyTicketView extends StatefulWidget {
  final TicketAttendee ticket;
  const MyTicketView(this.ticket, {super.key});

  @override
  State<MyTicketView> createState() => _MyTicketViewState();
}

class _MyTicketViewState extends State<MyTicketView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey.shade300, width: 1.0, style: BorderStyle.solid),
      ),
      child: TicketWidget(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.height * 0.3
              : MediaQuery.of(context).size.height * 0.6,
          isCornerRounded: true,
          padding: EdgeInsets.all(20),
          child: TicketData(
            widget.ticket.firstName,
            widget.ticket.lastName,
            widget.ticket.email,
            widget.ticket.typeOfReservedTicket,
            Constants.MockServer == false
                ? widget.ticket.id
                : widget.ticket.mockId.toString(),
            Constants.MockServer == false
                ? widget.ticket.orderid
                : widget.ticket.orderMockId.toString(),
          )),
    );
  }
}

class TicketData extends StatelessWidget {
  String id;
  String firstName;
  String lastName;
  String email;
  String typeOfReservedTicket;
  String orderID;
  TicketData(this.firstName, this.lastName, this.email,
      this.typeOfReservedTicket, this.id, this.orderID,
      {super.key});

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
              child: Center(
                child: Text(
                  typeOfReservedTicket,
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
            SizedBox(
              width: 120.0,
              child: Text(
                'Ticket ID:  ${id}',
                overflow: TextOverflow.fade,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        // const Padding(
        //   padding: EdgeInsets.only(top: 20.0),
        //   child: Text(
        //     'Flight Ticket',
        //     style: TextStyle(
        //         color: Colors.black,
        //         fontSize: 20.0,
        //         fontWeight: FontWeight.bold),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ticketDetailsWidget(
                  'Name', '$firstName $lastName', 'OrderID', orderID),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: EmailWidget2('email', email),
                ),
              ),
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
      EmailWidget(firstTitle, firstDesc),
      EmailWidget(secondTitle, secondDesc),
    ],
  );
}

class EmailWidget2 extends StatelessWidget {
  final String secondTitle;
  final String secondDesc;
  const EmailWidget2(
    this.secondTitle,
    this.secondDesc, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
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
              //overflow: TextOverflow.fade,
              style: const TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}

class EmailWidget extends StatelessWidget {
  final String firstTitle;
  final String firstDesc;
  const EmailWidget(
    this.firstTitle,
    this.firstDesc, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
