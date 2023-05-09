import 'dart:convert';

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class theEvent {
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

        final List<dynamic> extractedDataTickets = json.decode(response2.body);
        extractedDataTickets.forEach((ticket) {
          available += ticket["max_quantity"] as int;

          if (ticket["type"] == "regular") {
            regularmax += ticket["max_quantity"] as int;
            regulartaken +=
                (ticket["max_quantity"] - ticket["available_quantity"]) as int;
          } else {
            vipmax += ticket["max_quantity"] as int;
            viptaken +=
                (ticket["max_quantity"] - ticket["available_quantity"]) as int;
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
      throw error;
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
