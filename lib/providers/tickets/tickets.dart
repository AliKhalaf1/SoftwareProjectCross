/// {@nodoc}
/// nodoc
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ticket.dart';

class Tickets with ChangeNotifier {
  final List<Ticket> _tickets = [
    Ticket(
      'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
      DateTime.parse('2023-09-15 05:00:00'),
      'EVENT FOR A NEW TICKET',
    ),
    Ticket(
      'https://th.bing.com/th/id/R.1edb438b3f510aa9f4ea42a306507e35?rik=22xbsX8Xr5Z1KQ&pid=ImgRaw&r=0',
      DateTime.parse('2021-09-15 19:00:00'),
      'We The Medicine- Healing Our Inner Child 2023.Guid...',
    )
  ];

  ///Get events
  List<Ticket> get tickets {
    return [..._tickets];
  }

  /// Get event By ID
  Ticket findBytitle(String giventitle) {
    return _tickets.firstWhere((prod) => prod.title == giventitle);
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
