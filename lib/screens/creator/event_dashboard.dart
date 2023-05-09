import 'package:Eventbrite/providers/getevent/getevent.dart';
import 'package:Eventbrite/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    color: Color.fromRGBO(31, 10, 61, 1),
                    fontSize: 25),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              " Gross sales",
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
                child: const Text("Add Attendee"))
          ],
        ),
      ),
    );
  }
}
