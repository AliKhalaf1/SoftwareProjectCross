library FilterSelectionValues;

import 'dart:ffi';

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
///   • selectedFilterCount: integer represtents the count of selected filters
///
///

class FilterSelectionValues with ChangeNotifier {
  Tag _date = Tag('Anytime', true, 'date', 'Anytime');
  Tag _cat = Tag('Anything', true, 'field', 'Anything');
  String _location = "Online events";
  bool _price = false;
  bool _organizer = false;
  int _sortBy = 0;
  int selectedFilterCount = 0;

  ///Reset values to default
  void resetSelectionValues() {
    _date = Tag('Anytime', true, 'date', 'Anytime');
    _cat = Tag('Anything', true, 'field', 'Anything');
    _location = "Online events";
    _price = false;
    _organizer = false;
    _sortBy = 0;
    selectedFilterCount = 0;
  }

  ///Set All Values by values of passed FilterSelectionValues temp
  void setAll(FilterSelectionValues temp) {
    _date = temp.date;
    _cat = temp.cat;
    _location = temp.location;
    _price = temp.price;
    _organizer = temp.organizer;
    _sortBy = temp.sortBy;
    selectedFilterCount = temp.selectedFilterCount;
  }

  ///retrieve All Values and put on values of passed FilterSelectionValues temp
  void retrieveAll(FilterSelectionValues temp) {
    temp._date = _date;
    temp._cat = _cat;
    temp._location = _location;
    temp._price = _price;
    temp._organizer = _organizer;
    temp._sortBy = _sortBy;
    temp.selectedFilterCount = selectedFilterCount;
  }

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

  ///Increment filter count
  void incSelecFiltersCount() {
    selectedFilterCount++;
  }

  ///Decrement filter count
  void decSelecFiltersCount() {
    selectedFilterCount--;
  }
}
