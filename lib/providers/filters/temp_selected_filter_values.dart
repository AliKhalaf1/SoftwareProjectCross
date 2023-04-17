library TemporaryFilterSelectionValuesModel;

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'filter_selection_values.dart';
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

class TempFilterSelectionValues with ChangeNotifier {
  Tag _date = Tag('Anytime', true, 'date', 'Anytime');
  Tag _cat = Tag('Anything', true, 'field', 'Anything');
  String _location = "Online events";
  bool _price = false;
  bool _organizer = false;
  int _sortBy = 0;
  int selectedFilterCount = 0;

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

  ///Set All Values by values of passed FilterSelectionValues temp
  void setAll(FilterSelectionValues temp) {
    _date = temp.date;
    _cat = temp.cat;
    _location = temp.location;
    _price = temp.price;
    _organizer = temp.organizer;
    _sortBy = temp.sortBy;
    selectedFilterCount = temp.selectedFilterCount;
    notifyListeners();
  }
}
