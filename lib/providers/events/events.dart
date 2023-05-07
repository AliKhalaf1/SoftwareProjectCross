/// {@nodoc}
/// nodoc
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'event.dart';

class Events with ChangeNotifier {
  final List<Event> _events = [
    Event(
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(hours: 4)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.1edb438b3f510aa9f4ea42a306507e35?rik=22xbsX8Xr5Z1KQ&pid=ImgRaw&r=0',
        true,
        false,
        "Learn",
        ['smart', 'wellness', 'aykalam'],
        '0',
        'Ancara messi ancara messi',
        'Amin',
        false),
    Event(
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(days: 16)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        false,
        false,
        "Health",
        ['smart', 'wellness', 'aykalam'],
        '1',
        'Ancara messi ancara messi',
        'Megs',
        false),
    Event(
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(days: 9)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.we5keYDOBq6j9Dm-pOGIKgHaD1?pid=ImgDet&rs=1',
        false,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        '2',
        'Ancara messi ancara messi',
        'Saad',
        false),
    Event(
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(days: 6)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://i1.wp.com/www.skeptical-science.com/wp-content/uploads/2012/02/Egyptian-actor-Adel-Imam-007-1.jpg?resize=300%2C180&ssl=1',
        false,
        false,
        "Sports & Fitness",
        ['smart', 'wellness', 'aykalam'],
        '8',
        'Ancara messi ancara messi',
        'Gilany',
        false),
    Event(
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(days: 33)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.anXdkkvjnHH-Fjm_LnX52gHaEK?pid=ImgDet&w=1600&h=900&rs=1',
        false,
        false,
        "Business",
        ['smart', 'wellness', 'aykalam'],
        '6',
        'Ancara messi ancara messi',
        'Amaar',
        false),
    Event(
        DateTime.now().add(const Duration(hours: 3)),
        DateTime.now().add(const Duration(minutes: 30, hours: 5)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.we5keYDOBq6j9Dm-pOGIKgHaD1?pid=ImgDet&rs=1',
        true,
        false,
        "Business",
        ['smart', 'wellness', 'aykalam'],
        '12',
        'Ancara messi ancara messi',
        'Hazem',
        false),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 7)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.1edb438b3f510aa9f4ea42a306507e35?rik=22xbsX8Xr5Z1KQ&pid=ImgRaw&r=0',
        true,
        false,
        "Culture",
        ['smart', 'wellness', 'aykalam'],
        '20',
        'Ancara messi ancara messi',
        'Mahmoud',
        false),
    Event(
        DateTime.now().add(const Duration(days: 1)),
        DateTime.now().add(const Duration(days: 4)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.anXdkkvjnHH-Fjm_LnX52gHaEK?pid=ImgDet&w=1600&h=900&rs=1',
        false,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        '21',
        'Ancara messi ancara messi',
        'Ali',
        false),
    Event(
        DateTime.now().add(const Duration(hours: 2)),
        DateTime.now().add(const Duration(minutes: 30, hours: 4)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        false,
        false,
        "Sports & Fitness",
        ['smart', 'wellness', 'aykalam'],
        '11',
        'Ancara messi ancara messi',
        'Ziad',
        false),
    Event(
        DateTime.now().add(const Duration(hours: 1)),
        DateTime.now().add(const Duration(hours: 2)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        false,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        '10',
        'Ancara messi ancara messi',
        'Abdelhameed',
        false),
  ];

  ///Get events
  List<Event> get events {
    return [..._events];
  }

  ///Get Fav events (Better to use _fav class list)
  List<Event> get favoriteEvents {
    return _events.where((eventItem) => eventItem.isFav).toList();
  }

  /// Get event By ID
  Event findById(String id) {
    return _events.firstWhere((prod) => prod.id == id);
  }

  void unFavouriteAll() {
    _events.forEach((element) {
      element.isFav = false;
    });
    notifyListeners();
  }

  ///Fetch Events using API
  Future<void> fetchAndSetEvents() async {
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

  ///Add event
  void addEvent(Event e) {
    _events.add(e);
    //notify application that I add an event
    notifyListeners();
  }
}
