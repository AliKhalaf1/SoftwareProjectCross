/// {@nodoc}
/// nodoc
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ticket.dart';

class Tickets with ChangeNotifier {
  final List<Ticket> _upcomingTickets = [
    Ticket(
      'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
      DateTime.parse('2023-09-15 05:00:00'),
      'EVENT 1 FOR A NEW TICKET',
    ),
    Ticket(
      'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
      DateTime.parse('2023-09-05 10:15:00'),
      'EVENT 2 FOR A NEW TICKET',
    ),
  ];
  final List<Ticket> _pastTickets = [
    Ticket(
      'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
      DateTime.parse('2021-10-29 16:15:00'),
      'EVENT FOR A PAST TICKET',
    ),
    Ticket(
      'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
      DateTime.parse('2022-11-15 19:45:00'),
      'EVENT FOR A PAST TICKET',
    ),
    Ticket(
      'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
      DateTime.parse('2020-12-20 10:00:00'),
      'EVENT FOR A PAST TICKET',
    ),
  ];

  ///Get upcoming tickets
  List<Ticket> get upcomingTickets {
    return [..._upcomingTickets];
  }

  ///Get past tickets
  List<Ticket> get pastTickets {
    return [..._pastTickets];
  }

  ///Fetch Events using API
  Future<void> fetchAndSetTickets() async {
    // final url = Uri.https('flutter-update.firebaseio.com', '/products.json');
    // try {
    //   final response = await http.get(url);
    //   final extractedData = json.decode(response.body) as Map<String, dynamic>;
    //   if (extractedData == null) {
    //     return;
    //   }
    //   final List<Event> loadedProducts = [];
    //   extractedData.forEach((prodId, prodData) {
    //     loadedProducts.add(Event(
    //       id: prodId,
    //       title: prodData['title'],
    //       description: prodData['description'],
    //       price: prodData['price'],
    //       isFavorite: prodData['isFavorite'],
    //       imageUrl: prodData['imageUrl'],
    //     ));
    //   });
    //   _events= loadedProducts;
    //   notifyListeners();
    // } catch (error) {
    //   throw (error);
    // }
  }
}
