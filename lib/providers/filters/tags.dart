library TagsModel;

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

import 'tag.dart';

/// {@category Providers}
///## Tags class that has tag lists
///
///   • selectedTagsCount: count of selected tags
///
///   • _datetags: tags related to date
///
///   • _categoreytags: tags related to categorey
///
///   • _tagsToShow: tags to show when select tags

class Tags with ChangeNotifier {
  int selectedTagsCount = 0;

  final List<Tag> _datetags = [
    Tag('Anytime', true, 'date'),
    Tag('Today', false, 'date'),
    Tag('Tomorrow', false, 'date'),
    Tag('This weekend', false, 'date'),
    Tag('This month', false, 'date'),
    Tag('In the next month', false, 'date'),
    Tag('Pick a date...', false, 'date')
  ];

  final List<Tag> _fieldtags = [
    Tag('Anything', true, 'field'),
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
    Tag('In the next month', false, 'date'),
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
    selectedTagsCount++;
    if (selectedTagsCount == 1) {
      if (selectedTag.categ == 'date') {
        _tagsToShow.clear();
        _tagsToShow.add(selectedTag);
        _tagsToShow += _fieldtags;
        _tagsToShow.remove(_fieldtags[0]);
        _datetags[0].selected = false;
        for (var i = 0; i < _datetags.length; i++) {
          if (_datetags[i].title == selectedTag.title) {
            _datetags[i].selected = true;
          }
        }
      } else {
        _tagsToShow.clear();
        _tagsToShow.add(selectedTag);
        _tagsToShow += _datetags;
        _tagsToShow.remove(_datetags[0]);
        _tagsToShow.remove(_datetags[_datetags.length - 1]);
        _fieldtags[0].selected = false;
        for (var i = 0; i < _fieldtags.length; i++) {
          if (_fieldtags[i].title == selectedTag.title) {
            _fieldtags[i].selected = true;
          }
        }
      }
    } else {
      _tagsToShow = [_tagsToShow[0]] + [selectedTag];
      _tagsToShow.remove(_datetags[0]);
      _tagsToShow.remove(_datetags[_datetags.length - 1]);
      _tagsToShow.remove(_fieldtags[0]);
      _fieldtags[0].selected = false;
      _datetags[0].selected = false;
      for (var i = 0; i < _fieldtags.length; i++) {
        if (_fieldtags[i].title == selectedTag.title) {
          _fieldtags[i].selected = true;
        }
      }
      for (var i = 0; i < _datetags.length; i++) {
        if (_datetags[i].title == selectedTag.title) {
          _datetags[i].selected = true;
        }
      }
    }
    selectedTag.selected = true;
    notifyListeners();
  }

  ///Remove a tag function
  void tagRemove(Tag selectedTag) {
    selectedTagsCount--;
    _tagsToShow.remove(selectedTag);
    if (selectedTagsCount == 0) {
      _tagsToShow = _datetags + _fieldtags;
      _tagsToShow.remove(_fieldtags[0]);
      _tagsToShow.remove(_datetags[0]);
      _tagsToShow.remove(_datetags[_datetags.length - 1]);
      _fieldtags[0].selected = true;
      _datetags[0].selected = true;
      for (var i = 0; i < _fieldtags.length; i++) {
        if (_fieldtags[i].title == selectedTag.title) {
          _fieldtags[i].selected = false;
        }
      }
      for (var i = 0; i < _datetags.length; i++) {
        if (_datetags[i].title == selectedTag.title) {
          _datetags[i].selected = false;
        }
      }
    } else if (selectedTag.categ == 'date') {
      _tagsToShow += _datetags;
      _datetags[0].selected = true;
      _tagsToShow.remove(_datetags[0]);
      _tagsToShow.remove(_datetags[_datetags.length - 1]);
      for (var i = 0; i < _datetags.length; i++) {
        if (_datetags[i].title == selectedTag.title) {
          _datetags[i].selected = false;
        }
      }
    } else {
      _tagsToShow += _fieldtags;
      _fieldtags[0].selected = true;
      _tagsToShow.remove(_fieldtags[0]);
      for (var i = 0; i < _fieldtags.length; i++) {
        if (_fieldtags[i].title == selectedTag.title) {
          _fieldtags[i].selected = false;
        }
      }
    }
    selectedTag.selected = false;
    notifyListeners();
  }
}
