library TagsModel;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'tag.dart';

/// {@category Providers}
///## Tags class that has tag lists
///
///   • tagIsSelected: count of selected tags
///
///   • _datetags: tags related to date
///
///   • _categoreytags: tags related to categorey
///
///   • _tagsToShow: tags to show when select tags

class Tags with ChangeNotifier {
  int tagIsSelected = 0;

  final List<Tag> _datetags = [
    Tag('Today', false, 'date'),
    Tag('Tomorrow', false, 'date'),
    Tag('This weekend', false, 'date'),
    Tag('This month', false, 'date'),
    Tag('past', false, 'date')
  ];

  final List<Tag> _fieldtags = [
    Tag('Learn', false, 'field'),
    Tag('Business', false, 'field'),
    Tag('Health & Wellness', false, 'field'),
    Tag('Parenting', false, 'field'),
    Tag('Tech', false, 'field'),
    Tag('Culture', false, 'field')
  ];

  List<Tag> _tagsToShow = [
    Tag('Today', false, 'date'),
    Tag('Tomorrow', false, 'date'),
    Tag('This weekend', false, 'date'),
    Tag('This month', false, 'date'),
    Tag('past', false, 'date'),
    Tag('Learn', false, 'field'),
    Tag('Business', false, 'field'),
    Tag('Health & Wellness', false, 'field'),
    Tag('Parenting', false, 'field'),
    Tag('Tech', false, 'field'),
    Tag('Culture', false, 'field')
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

  ///Select a tag function
  void tagSelect(Tag selectedTag) {
    tagIsSelected++;
    selectedTag.selected = true;
    if (tagIsSelected == 1) {
      if (selectedTag.categ == 'date') {
        _tagsToShow.clear();
        _tagsToShow.add(selectedTag);
        _tagsToShow += _fieldtags;
      } else {
        _tagsToShow.clear();
        _tagsToShow.add(selectedTag);
        _tagsToShow += _datetags;
      }
    } else {
      _tagsToShow = [_tagsToShow[0]] + [selectedTag];
    }
  }

  ///Remove a tag function
  void tagRemove(Tag selectedTag) {
    tagIsSelected--;
    _tagsToShow.remove(selectedTag);
    if (tagIsSelected == 0) {
      _tagsToShow = _datetags + _fieldtags;
    } else if (selectedTag.categ == 'date') {
      _tagsToShow += _datetags;
    } else {
      _tagsToShow += _fieldtags;
    }
    selectedTag.selected = false;
  }
}
