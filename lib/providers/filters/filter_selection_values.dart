library FilterSelectionValues;

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'tag.dart';
import 'temp_selected_filter_values.dart';

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
  DateTime _startDatePick = DateTime.now();
  DateTime _endDatePick = DateTime.now();
  Tag _cat = Tag('Anything', true, 'field', 'Anything');
  String _location = "";
  bool _price = false;
  String _nameSearch = "";
  // bool _organizer = false;
  // int _sortBy = 0;
  int selectedFilterCount = 0;
  bool locSelectedBefore = false;

  ///Reset values to default
  void resetSelectionValues() {
    _date = Tag('Anytime', true, 'date', 'Anytime');
    _cat = Tag('Anything', true, 'field', 'Anything');
    _location = "";
    _price = false;
    _nameSearch = "";
    DateTime _startDatePick = DateTime.now();
    DateTime _endDatePick = DateTime.now();
    // _organizer = false;
    // _sortBy = 0;
    selectedFilterCount = 0;
    notifyListeners();
  }

  ///Set All Values by values of passed FilterSelectionValues temp
  void setAll(TempFilterSelectionValues temp) {
    _date = temp.date;
    _cat = temp.cat;
    _location = temp.location;
    _price = temp.price;
    // _organizer = temp.organizer;
    // _sortBy = temp.sortBy;
    selectedFilterCount = temp.selectedFilterCount;
    
    notifyListeners();
  }

  ///Get data value
  String get nameSearch {
    return _nameSearch;
  }

  ///Get data value
  DateTime get startDatePick {
    return _startDatePick;
  }

    ///Get data value
  DateTime get endDatePick {
    return _endDatePick;
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
  // bool get organizer {
  //   return _organizer;
  // }

  ///Get sort by
  // int get sortBy {
  //   return _sortBy;
  // }

  ///Set SearchByName
  void setSearchByName(String searchTitle) {
    _nameSearch = searchTitle;
    notifyListeners();
  }

  ///Set SearchByName
  void clearSearchByName() {
    _nameSearch = "";
    notifyListeners();
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
  // void setOrg(bool o) {
  //   _organizer = o;
  //   notifyListeners();
  // }

  ///Set organizer
  // void setSortingBy(int sb) {
  //   _sortBy = sb;
  //   notifyListeners();
  // }

  ///Increment filter count
  void incSelecFiltersCount() {
    selectedFilterCount++;
    notifyListeners();
  }

  ///Decrement filter count
  void decSelecFiltersCount() {
    selectedFilterCount--;
    notifyListeners();
  }
}
