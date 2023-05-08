import 'dart:convert';

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class theEvent {
  String id;
  String title;
  String date;
  double price;
  int maxTickets;
  int takenTickets;
  theEvent(
      {this.id = "",
      this.title = "",
      this.date = " ",
      this.price = 0,
      this.maxTickets = 0,
      this.takenTickets = 0});
}

class totalEvents {
  List<theEvent> items = [];

  List<theEvent> get allitems {
    return [...items];
  }

  Future<void> fetchAndSetProducts() async {
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

      if (extractedData == null) {
        return;
      }

      extractedData.forEach((element) {
        items.add(theEvent(
          id: element["id"],
          title: element["basic_info"]["title"],
          date: element["date_and_time"]["start_date_time"],
        ));
      });
      print("-----------------ticket dataa-------------------");

      items.forEach((element) async {
        int available = 0;
        double price = 0;
        final uri = Uri.parse(
            'https://eventbrite-995n.onrender.com/tickets/event_id/${element.id}');

        final response2 = await http.get(uri, headers: reqHeaders);

        final List<dynamic> extractedDataTickets = json.decode(response2.body);

        print(extractedDataTickets);
      });
    } catch (error) {
      print(error);
    }
  }
}
