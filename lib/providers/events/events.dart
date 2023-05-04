/// {@nodoc}
/// nodoc
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'event.dart';

class Events with ChangeNotifier {
  final List<Event> _events = [
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(hours: 4)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.1edb438b3f510aa9f4ea42a306507e35?rik=22xbsX8Xr5Z1KQ&pid=ImgRaw&r=0',
        EventState.online,
        false,
        "Arts",
        ['smart', 'wellness', 'aykalam'],
        '0',
        'Ancara messi ancara messi',
        '1234'),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 16)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        EventState.offline,
        false,
        "Health & Wellness",
        ['smart', 'wellness', 'aykalam'],
        '1',
        'Ancara messi ancara messi',
        '1234'),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 9)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.we5keYDOBq6j9Dm-pOGIKgHaD1?pid=ImgDet&rs=1',
        EventState.offline,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        '2',
        'Ancara messi ancara messi',
        '1234'),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 6)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://i1.wp.com/www.skeptical-science.com/wp-content/uploads/2012/02/Egyptian-actor-Adel-Imam-007-1.jpg?resize=300%2C180&ssl=1',
        EventState.offline,
        false,
        "Sports",
        ['smart', 'wellness', 'aykalam'],
        '2',
        'Ancara messi ancara messi',
        '1234'),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 33)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.anXdkkvjnHH-Fjm_LnX52gHaEK?pid=ImgDet&w=1600&h=900&rs=1',
        EventState.offline,
        false,
        "Business",
        ['smart', 'wellness', 'aykalam'],
        '2',
        'Ancara messi ancara messi',
        '1234'),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(minutes: 30, hours: 5)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.we5keYDOBq6j9Dm-pOGIKgHaD1?pid=ImgDet&rs=1',
        EventState.online,
        false,
        "Science",
        ['smart', 'wellness', 'aykalam'],
        '2',
        'Ancara messi ancara messi',
        '1234'),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 7)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.1edb438b3f510aa9f4ea42a306507e35?rik=22xbsX8Xr5Z1KQ&pid=ImgRaw&r=0',
        EventState.online,
        false,
        "Culture",
        ['smart', 'wellness', 'aykalam'],
        '0',
        'Ancara messi ancara messi',
        '1234'),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(days: 4)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/OIP.anXdkkvjnHH-Fjm_LnX52gHaEK?pid=ImgDet&w=1600&h=900&rs=1',
        EventState.offline,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        '2',
        'Ancara messi ancara messi',
        '1234'),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(minutes: 30, hours: 1)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        EventState.offline,
        false,
        "Sports",
        ['smart', 'wellness', 'aykalam'],
        '1',
        'Ancara messi ancara messi',
        '1234'),
    Event(
        DateTime.now(),
        DateTime.now().add(const Duration(hours: 2)),
        'We The Medicine- Healing Our Inner Child 2023.Guide and here we go ramos is paris player',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        EventState.offline,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        '1',
        'Ancara messi ancara messi',
        '1234'),
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
