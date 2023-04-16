library FiltersModel;

import 'package:flutter/material.dart';

import 'tag.dart';

/// {@category Providers}
///## FiltersData class that save Lists of filters possible values
///
///   • Date: List<Tag> (value of picked-up date converted to and its value will be at the categ)
///
///   • Location: It has no possible values so not included in the class
///
///   • Categorey: List<Tag>
///
///   • Price: Boolean It has no possible values so not included in the class
///
///   • Organizer: Boolean It has no possible values so not included in the class
///
///   • Sort by: int It has no possible values so not included in the class
///
///

class FiltersData with ChangeNotifier {
  final List<Tag> _dateValues = [
    Tag('Anytime', true, 'date'),
    Tag('Today', false, 'date'),
    Tag('Tomorrow', false, 'date'),
    Tag('This weekend', false, 'date'),
    Tag('This month', false, 'date'),
    Tag('In the next month', false, 'date'),
    Tag('Pick a date', false, 'date'),
  ];

  final List<Tag> _categoryValues = [
    Tag('Anything', true, 'field'),
    Tag('Music', false, 'field'),
    Tag('Food & Drink', false, 'field'),
    Tag('Active', false, 'field'),
    Tag('Learn', false, 'field'),
    Tag('Festival', false, 'field'),
    Tag('Arts', false, 'field'),
    Tag('Business', false, 'field'),
    Tag('Tech', false, 'field'),
    Tag('Culture', false, 'field'),
    Tag('Health & Wellness', false, 'field'),
    Tag('Tour', false, 'field'),
    Tag('Religion', false, 'field'),
    Tag('Sports', false, 'field'),
    Tag('Learn', false, 'field'),
    Tag('Parenting', false, 'field'),
  ];

  ///Get Possible data values
  List<Tag> get dateValues {
    return [..._dateValues];
  }

  ///Get Possible Categorey values
  List<Tag> get categoryValues {
    return [..._categoryValues];
  }

  ///Select a data value
  void selectDataValue(Tag selectedTag) {
    //Remove selected date
    for (var i = 0; i < _dateValues.length; i++) {
      if (_dateValues[i].selected == true) {
        _dateValues[i].selected = false;
        break;
      }
    }
    selectedTag.selected = true;
  }

  ///Select a categorey value
  void selectcategoreyValue(Tag selectedTag) {
    //Remove selected date
    for (var i = 0; i < _categoryValues.length; i++) {
      if (_categoryValues[i].selected == true) {
        _categoryValues[i].selected = false;
        break;
      }
    }
    selectedTag.selected = true;
  }
}
