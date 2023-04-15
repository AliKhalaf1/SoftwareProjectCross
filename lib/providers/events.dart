library Events;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/event.dart';

class Events with ChangeNotifier {
  List<Event> _events = [
    Event(
        123,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://cdn.evbstatic.com/s3-build/fe/build/images/7240401618ed7526be7cec3b43684583-2_tablet_1067x470.jpg',
        EventState.online,
        false),
    Event(
        42976,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F443314829%2F303007241545%2F1%2Foriginal.20230210-003309?w=940&auto=format%2Ccompress&q=75&sharp=10&rect=0%2C0%2C2160%2C1080&s=62411bb8f70beab0809515357bae1186',
        EventState.offline,
        false),
    Event(
        426,
        DateTime.now(),
        'We The Medicine- Healing Our Inner Child 2023.Guid...',
        'https://img.evbuc.com/https%3A%2F%2Fcdn.evbuc.com%2Fimages%2F472700089%2F456764372736%2F1%2Foriginal.20230319-231940?w=940&auto=format%2Ccompress&q=75&sharp=10&rect=0%2C0%2C1066%2C533&s=69e30ecc338952ba84e9cb36439a78d9',
        EventState.offline,
        false),
  ];

  ///Get events
  List<Event> get events {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._events];
  }

  ///Add event to Fav
  List<Event> get favoriteEvents {
    return _events.where((eventItem) => eventItem.isFav).toList();
  }

  // Product findById(String id) {
  //   return _items.firstWhere((prod) => prod.id == id);
  // }

  ///Add event
  void addEvent() {
    // _events.add(value);
    //notify application that I add an event
    notifyListeners();
  }

  ///Get Favourites
}
