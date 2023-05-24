import 'dart:convert';
import 'dart:io';

import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/objectbox.g.dart';
import 'package:Eventbrite/providers/events/event.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import '../../models/event_promocode.dart';
import '../../models/ticket_class.dart';
import '../../objectbox.dart';

class theEvent {
  int mockId = 0;
  String id;
  String title;
  String startDate;
  String endDate;
  double price;
  int maxTickets;
  int takenTickets;
  int maxTicketsVip;
  int takenTicketsVip;
  int maxTicketsRegular;
  int takenTicketsRegular;

  theEvent({
    this.id = "",
    this.title = "",
    this.startDate = "",
    this.endDate = "",
    this.price = 0,
    this.maxTickets = 0,
    this.takenTickets = 0,
    this.maxTicketsVip = 0,
    this.takenTicketsVip = 0,
    this.maxTicketsRegular = 0,
    this.takenTicketsRegular = 0,
  });
}

class totalEvents with ChangeNotifier {
  List<theEvent> items = [];

  List<theEvent> get allitems {
    return [...items];
  }

  Future<void> fetchAndSetEvents() async {
    items = [];
    if (Constants.MockServer == false) {
      String token = await getToken();
      Map<String, String> reqHeaders = {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      };

      final url = Uri.parse(
          'https://eventbrite-995n.onrender.com/users/me/created/events');
      try {
        final response = await http.get(url, headers: reqHeaders);
        print(response.statusCode);
        if (response.statusCode != 200) {
          throw HttpException('Error fetching data: ${response.statusCode}');
        }

        print(
            "--------------------------------------------------------------------------------------------");
        // print(response.body);
        final List<dynamic> extractedData = json.decode(response.body);
        print(extractedData);

        if (extractedData == null) {
          return;
        }

        extractedData.forEach((element) {
          items.add(theEvent(
            id: element["id"],
            title: element["basic_info"]["title"],
            startDate: element["date_and_time"]["start_date_time"],
            endDate: element["date_and_time"]["end_date_time"],
          ));
        });
        for (var element in items) {
          int available = 0;
          int takenTickets = 0;
          double price = 0;
          int vipmax = 0;
          int viptaken = 0;
          int regularmax = 0;
          int regulartaken = 0;
          final uri = Uri.parse(
              'https://eventbrite-995n.onrender.com/tickets/event_id/${element.id}');

          final response2 = await http.get(uri, headers: reqHeaders);

          final List<dynamic> extractedDataTickets =
              json.decode(response2.body);
          extractedDataTickets.forEach((ticket) {
            available += ticket["max_quantity"] as int;

            if (ticket["type"] == "regular") {
              regularmax += ticket["max_quantity"] as int;
              regulartaken += (ticket["max_quantity"] -
                  ticket["available_quantity"]) as int;
            } else {
              vipmax += ticket["max_quantity"] as int;
              viptaken += (ticket["max_quantity"] -
                  ticket["available_quantity"]) as int;
            }

            price += (ticket["max_quantity"] - ticket["available_quantity"]) *
                ticket["price"];
            takenTickets +=
                (ticket["max_quantity"] - ticket["available_quantity"]) as int;
          });
          element.price = price;
          element.maxTickets = available;
          element.takenTickets = takenTickets;

          element.maxTicketsRegular = regularmax;
          element.maxTicketsVip = vipmax;
          element.takenTicketsRegular = regulartaken;
          element.takenTicketsVip = viptaken;
        }
      } catch (error) {
        print(error);

        throw HttpException('Error fetching data:');
      }
    } else {
      String email = await getEmail();
      var usersbox = ObjectBox.userBox;
      var user = usersbox.query(User_.email.equals(email)).build().findFirst();
      var eventsbox = ObjectBox.eventBox;

      var promocodesBox = ObjectBox.eventPromocodeBox;
      var ticketClassesBox = ObjectBox.ticketClassBox;

      List<Event> events =
          eventsbox.query(Event_.creatorId.equals(user!.mockId)).build().find();
      events.forEach((element) {
        List<TicketClass> tickets = ticketClassesBox
            .query(TicketClass_.eventId.equals(element.mockId))
            .build()
            .find();

        double price = 0;
        int maxTickets = 0;
        int takenTickets = 0;
        int maxTicketsVip = 0;
        int takenTicketsVip = 0;
        int maxTicketsRegular = 0;
        int takenTicketsRegular = 0;
        tickets.forEach((ticket) {
          price +=
              ticket.price * (ticket.maxQuantity - ticket.availableQuantity);
          maxTickets += ticket.maxQuantity;
          takenTickets += ticket.maxQuantity - ticket.availableQuantity;
          if (ticket.isVip == false) {
            maxTicketsRegular += ticket.maxQuantity;
            takenTicketsRegular +=
                ticket.maxQuantity - ticket.availableQuantity;
          } else {
            maxTicketsVip += ticket.maxQuantity;
            takenTicketsVip += ticket.maxQuantity - ticket.availableQuantity;
          }
        });
        theEvent newevent = theEvent(
          id: element.id,
          title: element.title,
          startDate:
              DateFormat("yyyy-MM-ddTHH:mm:ss").format(element.startDate),
          endDate: DateFormat("yyyy-MM-ddTHH:mm:ss").format(element.endDate),
          price: price,
          maxTickets: maxTickets,
          takenTickets: takenTickets,
          maxTicketsRegular: maxTicketsRegular,
          takenTicketsRegular: takenTicketsRegular,
          maxTicketsVip: maxTicketsVip,
          takenTicketsVip: takenTicketsVip,
        );
        newevent.mockId = element.mockId;
        items.add(newevent);
      });
    }
  }

  List<theEvent> get allitemslive {
    List<theEvent> liveItems = [];
    items.forEach((element) {
      print("s");
      print(element.price);
      DateTime end = DateTime.parse(element.endDate);
      if (end.isAfter(DateTime.now())) {
        liveItems.add(element);
      }
    });

    return liveItems;
  }

  List<theEvent> get allitemsended {
    List<theEvent> endItems = [];
    items.forEach((element) {
      DateTime end = DateTime.parse(element.endDate);
      if (end.isBefore(DateTime.now())) {
        endItems.add(element);
      }
    });

    return endItems;
  }

  Future<void> exportToCsv() async {
    print("ss");
    final directory = await getExternalStorageDirectory();

    List<List<String>> csvData = [
      [
        'Event Title',
        'Start Date',
        'End Date',
        'Price',
        'Max Tickets',
        'Taken Tickets'
      ],
    ];
    int index = 1;
    items.forEach((element) {
      csvData[index][0] = element.title;
      csvData[index][1] = element.startDate;
      csvData[index][2] = element.endDate;
      csvData[index][3] = element.price.toString();
      csvData[index][4] = element.maxTickets.toString();
      csvData[index][5] = element.takenTickets.toString();
      index++;
    });
    String csv = const ListToCsvConverter().convert(csvData);

    String filename = '${directory!.path}/events.csv';
    final File file = File(filename);
    await file.writeAsString(csv);
    print("directionnnn");
    print(filename);
  }

  // Future<void> deleteEvent(String id) async {
  //   final url = Uri.parse('https://eventbrite-995n.onrender.com/events/id/$id');
  //   String token = await getToken();
  //   Map<String, String> reqHeaders = {
  //     'Authorization': 'Bearer $token',
  //     "Content-Type": "application/json"
  //   };
  //   items.removeWhere((element) => element.id == id);
  //   notifyListeners();
  //   try {
  //     final response = await http.delete(url, headers: reqHeaders);
  //     print("delete respone");
  //     print(response.statusCode);
  //   } catch (error) {}
  //   notifyListeners();
  // }
}
