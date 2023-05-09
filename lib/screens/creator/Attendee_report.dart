import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:Eventbrite/models/Ticket_attendee.dart';
import 'package:Eventbrite/models/ticket_class.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AttendeeReport extends StatefulWidget {
  final String eventID;
  final int eventMockId;
  bool isLoading = false;
  List<TicketAttendee> tickets = [];
  AttendeeReport(this.eventID, this.eventMockId, {super.key});

  @override
  State<AttendeeReport> createState() => _AttendeeReportState();
}

class _AttendeeReportState extends State<AttendeeReport> {
  List<DataRow> TicketsToDataRows() {
    List<DataRow> dataRows = [];
    if (Constants.MockServer == false) {
      for (var ticket in widget.tickets) {
        dataRows.add(DataRow(
          cells: <DataCell>[
            DataCell(
              Text(ticket.orderid),
            ),
            DataCell(
              Text(ticket.id),
            ),
            DataCell(
              Text(ticket.isVip ? "VIP" : "Regular"),
            ),
            DataCell(
              Text(ticket.firstName),
            ),
            DataCell(
              Text(ticket.lastName),
            ),
            DataCell(
              Text(ticket.email),
            ),
          ],
        ));
      }
    } else {
      for (var ticket in widget.tickets) {
        dataRows.add(DataRow(
          cells: <DataCell>[
            DataCell(
              Text(ticket.orderMockId.toString()),
            ),
            DataCell(
              Text(ticket.mockId.toString()),
            ),
            DataCell(
              Text(ticket.isVip ? "VIP" : "Regular"),
            ),
            DataCell(
              Text(ticket.firstName),
            ),
            DataCell(
              Text(ticket.lastName),
            ),
            DataCell(
              Text(ticket.email),
            ),
          ],
        ));
      }
    }
    return dataRows;
  }

  void Refresh() {
    setState(() {
      widget.isLoading = true;
    });

    setState(() {
      widget.isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    widget.tickets = [
      TicketAttendee("id1", true, "ahmed", "saad", "ahmedsaad_2009@live.com",
          "eventid1", "orderid1"),
      TicketAttendee("id2", true, "ahmed", "saad", "ahmedsaad_2009@live.com",
          "eventid1", "orderid1"),
      TicketAttendee("id3", false, "ahmedv", "saad", "ahmedsaad_2009@live.com",
          "eventid1", "orderid1"),
      TicketAttendee("id4", false, "ahmedv2", "saad", "ahmedsaad_2009@live.com",
          "eventid1", "orderid1"),
      TicketAttendee("id5", true, "ahmed", "saad", "ahmedsaad_2009@live.com",
          "eventid1", "orderid1"),
      TicketAttendee("id6", true, "ahmed", "saad", "ahmedsaad_2009@live.com",
          "eventid1", "orderid1"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText('Attendees Report'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'OrderId',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Ticket ID',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Ticket Type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'First Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Last Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Email',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: TicketsToDataRows(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
