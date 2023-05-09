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
    widget.tickets = [];
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
                        'Sr.No',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Sr.No',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Sr.No',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Website',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Tutorial',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Review',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  rows: const <DataRow>[
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('1'),
                        ),
                        DataCell(
                          Text('https://flutterr.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('2'),
                        ),
                        DataCell(
                          Text('https://dart.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Dart'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                    DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text('3'),
                        ),
                        DataCell(
                          Text('https://pub.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('https://flutter.dev/'),
                        ),
                        DataCell(
                          Text('Flutter Packages'),
                        ),
                        DataCell(
                          Text('5*'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
