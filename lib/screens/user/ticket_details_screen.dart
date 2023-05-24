library TicketDetailsScreen;

import 'dart:convert';

import 'package:Eventbrite/main.dart';
import 'package:Eventbrite/objectbox.dart';
import 'package:Eventbrite/objectbox.g.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:Eventbrite/widgets/loading_spinner.dart';
import 'package:Eventbrite/widgets/ticket_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../helper_functions/constants.dart';
import '../../models/Ticket_attendee.dart';

/// {@category user}
/// {@category Screens}
///
/// A screen that displays the details of a ticket.
/// This screen contains a list of [TicketDetailsCard] widgets that display
/// information about the ticket such as the seat number, section, and price.

class TicketsDetailsScreen extends StatefulWidget {
  final String orderId;
  final int orderMockID;
  List<TicketAttendee> ticketsList = [];
  bool isLoading = false;
  TicketsDetailsScreen(this.orderId, this.orderMockID, {super.key});

  @override
  State<TicketsDetailsScreen> createState() => _TicketsDetailsScreenState();
}

class _TicketsDetailsScreenState extends State<TicketsDetailsScreen> {
  @override
  void initState() {
    super.initState();
    getTicketsAttendess();
  }

  Future<void> getTicketsAttendess() async {
    setState(() {
      widget.isLoading = true;
    });

    if (Constants.MockServer == false) {
      var uri =
          Uri.parse('${Constants.host}/attendees/order/${widget.orderId}');
      print(uri);

      var response = await http.get(uri);

      var res = response.body;
      var resData = jsonDecode(res);
      if (res.length == 0) {
        widget.ticketsList = [];
      } else {
        widget.ticketsList = [];
        for (int i = 0; i < resData.length; i++) {
          TicketAttendee newticket = TicketAttendee(
            resData[i]['id'],
            resData[i]['type_of_reseved_ticket'] == "regular" ? false : true,
            resData[i]['first_name'],
            resData[i]['last_name'],
            resData[i]['email'],
            resData[i]['event_id'],
            resData[i]['order_id'],
          );
          newticket.typeOfReservedTicket = resData[i]['type_of_reseved_ticket'];
          widget.ticketsList.add(newticket);
        }
      }
    } else {
      var TicketAttendeeBox = ObjectBox.TicketAttendeeBox;
      var ticketAttendees = TicketAttendeeBox.query(
              TicketAttendee_.orderMockId.equals(widget.orderMockID))
          .build()
          .find();
      widget.ticketsList = ticketAttendees;
    }

    setState(() {
      widget.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const AppBarText('Ticket Details'),
        ),
        body: widget.isLoading == true
            ? const LoadingSpinner()
            : widget.ticketsList.length == 0
                ? Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.05,
                        right: MediaQuery.of(context).size.width * 0.05,
                        bottom: MediaQuery.of(context).size.height * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'This Order Has No Tickets',
                          style: TextStyle(
                            color: Colors.blueGrey[800],
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(
                          'You can buy tickets from the event page',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: widget.ticketsList.length,
                            itemBuilder: (context, index) {
                              return TicketDetailsCard(
                                  widget.ticketsList[index]);
                            }),
                      ),
                    ],
                  ));
  }
}
