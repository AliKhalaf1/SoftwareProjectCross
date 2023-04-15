import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Events with ChangeNotifier {
  List<Events> _events = [];

  ///Get events
    List<Events> get events{
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._events];
  }
  
  ///add event
  void addEvent()
  {
    // _events.add(value);
    //notify application that I add an event
    notifyListeners();   
  }


  ///Get Favourites


}