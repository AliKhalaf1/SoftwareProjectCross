library EventsModel;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'event.dart';

class Events with ChangeNotifier {
  final List<Event> _events = [
    Event(
        123,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://th.bing.com/th/id/R.1edb438b3f510aa9f4ea42a306507e35?rik=22xbsX8Xr5Z1KQ&pid=ImgRaw&r=0',
        EventState.online,
        false,
        "Arts",
        ['smart', 'wellness', 'aykalam'],
        '0'),
    Event(
        42976,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        EventState.offline,
        false,
        "Health & Wellness",
        ['smart', 'wellness', 'aykalam'],
        '1'),
    Event(
        426,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://th.bing.com/th/id/OIP.we5keYDOBq6j9Dm-pOGIKgHaD1?pid=ImgDet&rs=1',
        EventState.offline,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        '2'),
    Event(
        104824,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://i1.wp.com/www.skeptical-science.com/wp-content/uploads/2012/02/Egyptian-actor-Adel-Imam-007-1.jpg?resize=300%2C180&ssl=1',
        EventState.offline,
        false,
        "Sports",
        ['smart', 'wellness', 'aykalam'],
        '2'),
    Event(
        924,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://th.bing.com/th/id/OIP.anXdkkvjnHH-Fjm_LnX52gHaEK?pid=ImgDet&w=1600&h=900&rs=1',
        EventState.offline,
        false,
        "Business",
        ['smart', 'wellness', 'aykalam'],
        '2'),
    Event(
        1824,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://celebrity.tn/wp-content/uploads/2019/03/adel-imam-2-608x608.jpg',
        EventState.offline,
        false,
        "Family & Education",
        ['smart', 'wellness', 'aykalam'],
        '2'),
    Event(
        666,
        DateTime.now(),
        'Bortooan The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://th.bing.com/th/id/OIP.we5keYDOBq6j9Dm-pOGIKgHaD1?pid=ImgDet&rs=1',
        EventState.online,
        false,
        "Science",
        ['smart', 'wellness', 'aykalam'],
        '2'),
            Event(
        12323,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://th.bing.com/th/id/R.1edb438b3f510aa9f4ea42a306507e35?rik=22xbsX8Xr5Z1KQ&pid=ImgRaw&r=0',
        EventState.online,
        false,
        "Culture",
        ['smart', 'wellness', 'aykalam'],
        '0'),
            Event(
        91224,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://th.bing.com/th/id/OIP.anXdkkvjnHH-Fjm_LnX52gHaEK?pid=ImgDet&w=1600&h=900&rs=1',
        EventState.offline,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        '2'),
            Event(
        409000,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        EventState.offline,
        false,
        "Sports",
        ['smart', 'wellness', 'aykalam'],
        '1'),
                    Event(
        47654,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://th.bing.com/th/id/R.20e1ec01835b936b4912a85e9dbd241b?rik=REl2x5yuLqQ%2f4w&pid=ImgRaw&r=0&sres=1&sresct=1',
        EventState.offline,
        false,
        "Tech",
        ['smart', 'wellness', 'aykalam'],
        '1'),
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
