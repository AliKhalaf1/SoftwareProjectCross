/// {@nodoc}
/// nodoc
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../filters/tag.dart';

/// {@category Providers}
///## Event class that stores each event information inside following attributes
///
///   • eventImg: cover image for the event
///
///   • date: date when the event held
///
///   • description: short description on the event and activities that will take place
///
///   • state: Online / Offline
///
///   • creatorFollowers: number of followers who follow the event organizer
///
///   • isFav: boolean variable check if user mark this event to its favourites or not
///

enum EventState { online, offline }

class Event with ChangeNotifier {
  //parameters of the EventCard Widget
  final String eventImg; /*event card image */
  final DateTime startDate; /*start event date*/
  final DateTime endDate; /*end event date*/
  final String description; /*event dscription*/
  final EventState state; /*event state (online/onsite)*/
  bool isFav;
  final String categ;
  final List<String> tags;
  final String id;
  final String title;

  ///Constructor
  Event(
    this.startDate,
    this.endDate,
    this.description,
    this.eventImg,
    this.state,
    this.isFav,
    this.categ,
    this.tags,
    this.id,
    this.title
  );

  /// Set isFav Value by true or false
  void _setFavValue(bool newValue) {
    isFav = newValue;
    notifyListeners();
  }

  /// Get is the event favourited or not
  bool isFavourite() {
    return isFav;
  }

  /// Toogle isFav value depending on action (Add/Remove) from fav list
  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFav;
    isFav = !isFav;
    notifyListeners();
    // --------------- Send toggeled isFav value to API ----------------

    //   final url = Uri.https('flutter-update.firebaseio.com', '/products/$id.json');
    //   try {
    //     final response = await http.patch(
    //       url,
    //       body: json.encode({
    //         'isFavorite': isFav,
    //       }),
    //     );
    //     if (response.statusCode >= 400) {
    //       _setFavValue(oldStatus);
    //     }
    //   } catch (error) {
    //     _setFavValue(oldStatus);
    //   }
  }
}
