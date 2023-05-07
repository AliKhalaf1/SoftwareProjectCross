/// {@nodoc}
/// nodoc
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:objectbox/objectbox.dart';
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
///   • status: private / public
///
///   • organization: organization that organize the event
///
///   • isFav: boolean variable check if user mark this event to its favourites or not
///

// enum EventState { online, offline }

// enum EventStatus { private, public }

@Entity()
class Event with ChangeNotifier {
  //parameters of the EventCard Widget
  @Id()
  int mockId = 0;

  final String eventImg; /*event card image */
  final DateTime startDate; /*start event date*/
  final DateTime endDate; /*end event date*/
  final String description; /*event dscription*/
  final bool state; /*event state (online/onsite)*/
  final bool status; /*event status (private/public) */
  bool isFav;
  final String categ;
  final List<String> tags;
  final String id;
  final String title;
  final String organization;

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
      this.title,
      this.organization,
      this.status);

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
