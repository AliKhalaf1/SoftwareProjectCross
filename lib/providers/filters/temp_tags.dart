library TemporaryTagsModel;

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

import 'tag.dart';
import 'tags.dart';

/// {@category Providers}
///## TemporaryTags class that has temp tag Values to retrieve it if no filters applied
///
///   • selectedTagsCount: count of selected tags
///
///   • _datetags: tags related to date
///
///   • _categoreytags: tags related to categorey
///
///   • _tagsToShow: tags to show when select tags

class TemporaryTags with ChangeNotifier {
  int selectedTagsCount = 0;

  final List<Tag> _datetags = [
    Tag('Anytime', true, 'date', 'Anytime'),
    Tag('Today', false, 'date', 'Today'),
    Tag('Tomorrow', false, 'date', 'Tomorrow'),
    Tag('This weekend', false, 'date', 'This weekend'),
    Tag('This month', false, 'date', 'This month'),
    Tag('In the next month', false, 'date', 'In the next month'),
    Tag('Pick a date...', false, 'date', 'Pick a date...')
  ];

  final List<Tag> _fieldtags = [
    Tag('Anything', true, 'field', 'Anything'),
    Tag('Learn', false, 'field', 'Learn'),
    Tag('Business', false, 'field', 'Business'),
    Tag('Health & Wellness', false, 'field', 'Health & Wellness'),
    Tag('Parenting', false, 'field', 'Parenting'),
    Tag('Tech', false, 'field', 'Tech'),
    Tag('Culture', false, 'field', 'Culture')
  ];

  List<Tag> _tagsToShow = [
    Tag('Today', false, 'date', 'Today'),
    Tag('Tomorrow', false, 'date', 'Tomorrow'),
    Tag('This weekend', false, 'date', 'This weekend'),
    Tag('This month', false, 'date', 'This month'),
    Tag('In the next month', false, 'date', 'In the next month'),
    Tag('Learn', false, 'field', 'Learn'),
    Tag('Business', false, 'field', 'Business'),
    Tag('Health & Wellness', false, 'field', 'Health & Wellness'),
    Tag('Parenting', false, 'field', 'Parenting'),
    Tag('Tech', false, 'field', 'Tech'),
    Tag('Culture', false, 'field', 'Culture')
  ];

  ///Get tags to show when select tags
  List<Tag> get tagsToShow {
    return [..._tagsToShow];
  }

  ///Get tags related to categorey
  List<Tag> get fieldtags {
    return [..._fieldtags];
  }

  ///tags related to date
  List<Tag> get datetags {
    return [..._datetags];
  }

  
  ///Set all values by passed Tags temp
  void setAll(Tags temp) {
    selectedTagsCount = temp.selectedTagsCount;
    _tagsToShow = temp.tagsToShow;
    for (var i = 0; i < _fieldtags.length; i++) {
      _fieldtags[i].selected = temp.fieldtags[i].selected;
    }
    for (var i = 0; i < _datetags.length; i++) {
      _datetags[i].selected = temp.datetags[i].selected;
      _datetags[i].value = temp.datetags[i].value;
    }
    notifyListeners();
  }
}