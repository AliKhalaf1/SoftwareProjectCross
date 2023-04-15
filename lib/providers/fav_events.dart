library FavouriteEvents;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'event.dart';

class FavEvents with ChangeNotifier {
  final List<Event> _favs = [];

  ///Get events
  List<Event> get favs {
    return [..._favs];
  }

  ///Add event to Fav
  Future<void> addEventToFav(Event e) async {
    //============================ Add API ========================================

    //     final url = Uri.https('flutter-update.firebaseio.com', '/products.json');
    // try {
    //   final response = await http.post(
    //     url,
    //     body: json.encode({
    //       'title': product.title,
    //       'description': product.description,
    //       'imageUrl': product.imageUrl,
    //       'price': product.price,
    //       'isFavorite': product.isFavorite,
    //     }),
    //   );
    //   final newProduct = Product(
    //     title: product.title,
    //     description: product.description,
    //     price: product.price,
    //     imageUrl: product.imageUrl,
    //     id: json.decode(response.body)['name'],
    //   );
    e.toggleFavoriteStatus();       // add only if success from API
    _favs.add(e);
    notifyListeners();
    // } catch (error) {
    //   print(error);
    //   throw error;
    // }
  }

  ///Remove event to Fav
  Future<void> removeEventFromFav(Event e) async {
    e.toggleFavoriteStatus();

    //     final url = Uri.https('flutter-update.firebaseio.com', '/products/$id.json');
    final existingProductIndex = _favs.indexWhere((even) => even.id == e.id);
    Event? existingEvent = _favs[existingProductIndex];
    _favs.removeAt(existingProductIndex);
    //notify application that I add an event
    notifyListeners();
    //============================ Remove API ========================================

    // final response = await http.delete(url);
    // if (response.statusCode >= 400) {
    //   _items.insert(existingProductIndex, existingProduct);
        // e.toggleFavoriteStatus();  //remove again as API fails
    //   notifyListeners();
    //   throw HttpException('Could not delete product.');
    // }
    existingEvent = null;
  }
}
