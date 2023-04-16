library FilterSelectionValues;

import 'package:flutter/material.dart';
import 'tag.dart';

/// {@category Providers}
///## FiltersData class that save selected tags along the app
///
///   • Date: Tag (even picked-up date converted to tag)
///
///   • Location: String
///
///   • Categorey: Tag
///
///   • Price: boolean of free/Not
///
///   • Organizer: boolean of from orgnzs I follow / Not
///
///   • Sort by: int (0: Relevance / 1: Date)
///
///

class FilterSelectionValues with ChangeNotifier {
  Tag _date = Tag('Anytime', true, 'date');
  Tag _cat = Tag('Anything', true, 'field');
  String _location = "Online events";
  bool _price = false;
  bool _organizer = false;
  int _sortBy = 0;

  ///Get data value
  Tag get date {
    return _date;
  }

  ///Get categorey value
  Tag get cat {
    return _cat;
  }

  ///Get location value
  String get location {
    return _location;
  }

  ///Get Price(free / not)
  bool get price {
    return _price;
  }

  ///Get organizer(From which I follow /  not)
  bool get organizer {
    return _organizer;
  }

  ///Get sort by
  int get sortBy {
    return _sortBy;
  }

  ///Set Date
  void setDate(Tag d) {
    _date = d;
    notifyListeners();
  }

  ///Set Categorey
  void setCat(Tag c) {
    _cat = c;
    notifyListeners();
  }

  ///Set location
  void setLoc(String loc) {
    _location = loc;
    notifyListeners();
  }

  ///Set Price
  void setPrice(bool p) {
    _price = p;
    notifyListeners();
  }

  ///Set organizer
  void setOrg(bool o) {
    _organizer = o;
    notifyListeners();
  }

  ///Set organizer
  void setSortingBy(int sb) {
    _sortBy = sb;
    notifyListeners();
  }
}
