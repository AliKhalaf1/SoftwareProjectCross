library DashBoard;

import 'package:Eventbrite/providers/getevent/getevent.dart';
import 'package:Eventbrite/screens/creator/Attendee_report.dart';
import 'package:Eventbrite/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

/// {@category Creator}
/// {@category Screens}
///
/// EventsDashboard that extends StatefulWidget.
/// The purpose of this widget is to display information about an event,
/// including the event title, gross sales,
/// and the number of available and taken tickets for different types of tickets.

class EventsDashboard extends StatefulWidget {
  const EventsDashboard({super.key});
  static const route = '/eventsDashboard';
  @override
  State<EventsDashboard> createState() => _EventsDashboardState();
}

class _EventsDashboardState extends State<EventsDashboard> {
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<totalEvents>(context, listen: false);
    final routearg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final theEvent Event = routearg['event'];

    print("inside");
    print(Event.maxTicketsRegular);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(31, 10, 61, 1),
        title: const Text(
          "Event DashBoard",
          style: TextStyle(
              fontFamily: "Neue Plak Extended",
              fontWeight: FontWeight.w600,
              color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 50,
              height: 50,
              child: Text(
                "${Event.title}",
                style: const TextStyle(
                    fontFamily: "Neue Plak",
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontSize: 25),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 50,
              height: 100,
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      "ID : ${Event.id}",
                      style: const TextStyle(
                          fontFamily: "Neue Plak Light",
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(31, 10, 61, 1),
                          fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: Event.id));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Copied to Clipboard'),
                          ),
                        );
                        // copied successfully
                      },
                      icon: const Icon(Icons.copy)),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              " Net sales",
              style: TextStyle(
                fontFamily: "Neue Plak",
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(31, 10, 61, 1),
                fontSize: 25,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              " \$${Event.price}",
              style: const TextStyle(
                  fontFamily: "Neue Plak Extended",
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(31, 10, 61, 1),
                  fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "AdmissionSales/ TotalAvailable",
              style: TextStyle(
                  fontFamily: "Neue Plak",
                  fontWeight: FontWeight.w800,
                  color: Color.fromRGBO(31, 10, 61, 1),
                  fontSize: 18),
            ),
            DashCard("VIP TICKETS", Event.maxTicketsVip, Event.takenTicketsVip),
            const SizedBox(
              height: 5,
            ),
            DashCard("REGULAR TICKETS", Event.maxTicketsRegular,
                Event.takenTicketsRegular),
            const SizedBox(
              height: 5,
            ),
            DashCard("ALL TICKETS", Event.maxTickets, Event.takenTickets),
            const SizedBox(
              height: 5,
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/add_Attendee', arguments: {
                    'eventID': Event.id,
                    'eventIDMock': Event.mockId
                  });
                },
                child: const Text("Add Attendee")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          AttendeeReport(Event.id, Event.mockId)));
                },
                child: const Text("Attendee Report")),
          ],
        ),
      ),
    );
  }
}
