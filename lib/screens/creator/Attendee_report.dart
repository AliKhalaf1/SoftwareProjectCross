library AttendeeReport;

import 'dart:convert';
import 'dart:io';

import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:Eventbrite/models/Ticket_attendee.dart';
import 'package:Eventbrite/models/ticket_class.dart';
import 'package:Eventbrite/widgets/app_bar_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:open_file/open_file.dart';
import '../../widgets/loading_spinner.dart';

/// {@category Creator}
/// {@category Screens}
///
///Flutter class called AttendeeReport that extends StatefulWidget.
/// It is used to display a list of ticket attendees for a particular event.

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

  Future<void> Refresh() async {
    setState(() {
      widget.isLoading = true;
    });
    if (Constants.MockServer == false) {
      print("I'm here");
      // string to uri
      var uri = Uri.parse(
          '${Constants.host}/attendees/${widget.eventID}/get_attendees');
      print(uri);
      //create multipart request

      var response = await http.get(uri);

      var res = response.body;
      var resData = jsonDecode(res);

      //Check Response
      if (response.statusCode == 200) {
        if (res.length == 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("No Tickets Found"),
          ));
        } else {
          widget.tickets = [];
          for (int i = 0; i < resData.length; i++) {
            TicketAttendee ticket = TicketAttendee(
              resData[i]['id'],
              resData[i]['type_of_reserved_ticket'] == "vip" ? true : false,
              resData[i]['first_name'],
              resData[i]['last_name'],
              resData[i]['email'],
              resData[i]['event_id'],
              resData[i]['order_id'],
            );
            widget.tickets.add(ticket);
          }
        }
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Event Not Found"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something Went Wrong"),
        ));
      }
    } else {
      // var authbox = ObjectBox.authBox;
      // var userbox = ObjectBox.userBox;

      // var authQuery =
      //     authbox.query(Auth_.email.equals(email)).build().findFirst();
      // if (authQuery != null) {
      //   var userQuery =
      //       userbox.query(User_.email.equals(email)).build().findFirst();

      //   User user = userQuery!;

      //   Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      //     return PasswordCheck(email, user.imageUrl);
      //   }));
      // } else {
      //   Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      //     return SignUpForm(email);
      //   }));
      // }
    }
    setState(() {
      widget.isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Refresh();
    // widget.tickets = [
    //   TicketAttendee("id1", true, "ahmed", "saad", "ahmedsaad_2009@live.com",
    //       "eventid1", "orderid1"),
    //   TicketAttendee("id2", true, "ahmed", "saad", "ahmedsaad_2009@live.com",
    //       "eventid1", "orderid1"),
    //   TicketAttendee("id3", false, "ahmedv", "saad", "ahmedsaad_2009@live.com",
    //       "eventid1", "orderid1"),
    //   TicketAttendee("id4", false, "ahmedv2", "saad", "ahmedsaad_2009@live.com",
    //       "eventid1", "orderid1"),
    //   TicketAttendee("id5", true, "ahmed", "saad", "ahmedsaad_2009@live.com",
    //       "eventid1", "orderid1"),
    //   TicketAttendee("id6", true, "ahmed", "saad", "ahmedsaad_2009@live.com",
    //       "eventid1", "orderid1"),
    // ];
  }

  Future<String> exportToCsv() async {
    final directory = await getExternalStorageDirectory();

    List<List<String>> csvData = [
      [
        'Order ID',
        'Ticket ID',
        'Ticket Type',
        'First Name',
        'Last Name',
        'Email'
      ]
    ];
    if (Constants.MockServer == true) {
      widget.tickets.forEach((element) {
        List<String> row = [
          element.orderMockId.toString(),
          element.mockId.toString(),
          element.isVip ? "VIP" : "Regular",
          element.firstName,
          element.lastName,
          element.email,
        ];
        csvData.add(row);
      });
    } else {
      for (var ticket in widget.tickets) {
        List<String> row = [
          ticket.orderid,
          ticket.id,
          ticket.isVip ? "VIP" : "Regular",
          ticket.firstName,
          ticket.lastName,
          ticket.email,
        ];
        csvData.add(row);
      }
    }
    print(csvData.length);

    String csv = const ListToCsvConverter().convert(csvData);

    String filename = '${directory!.path}/events.csv';

    final file = File(filename);
    await file.writeAsString(csv);
    OpenFile.open(filename);
    return filename;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.orange[800],
        ),
        child: IconButton(
          color: Colors.white,
          iconSize: 30,
          icon: Icon(Icons.save),
          onPressed: () async {
            String path = await exportToCsv();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('File saved to $path'),
              ),
            );
          },
        ),
      ),
      appBar: AppBar(
        title: AppBarText('Attendees Report'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: widget.isLoading
          ? LoadingSpinner()
          : Column(
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
