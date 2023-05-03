library TagsModel;

import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

import 'tag.dart';
import 'temp_tags.dart';

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
    Tag('Sports', true, 'field', 'Sports'),
    Tag('Learn', false, 'field', 'Learn'),
    Tag('Business', false, 'field', 'Business'),
    Tag('Health & Wellness', false, 'field', 'Health & Wellness'),
    Tag('Tech', false, 'field', 'Tech'),
    Tag('Culture', false, 'field', 'Culture')
  ];

  List<Tag> _tagsToShow = [
    Tag('Today', false, 'date', 'Today'),
    Tag('Tomorrow', false, 'date', 'Tomorrow'),
    Tag('This weekend', false, 'date', 'This weekend'),
    Tag('This month', false, 'date', 'This month'),
    Tag('In the next month', false, 'date', 'In the next month'),
    Tag('Sports', true, 'field', 'Sports'),
    Tag('Learn', false, 'field', 'Learn'),
    Tag('Business', false, 'field', 'Business'),
    Tag('Health & Wellness', false, 'field', 'Health & Wellness'),
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

  ///Select a tag function
  ///
  ///   • Add to _tagsToShow and reflect in _datetags / _fieldtags.
  ///
  ///   • Used with Search screen.
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
        if (!_datetags[_datetags.length - 1].selected) {
          _tagsToShow.remove(_datetags[_datetags.length - 1]);
        }
        _fieldtags[0].selected = false;
        for (var i = 0; i < _fieldtags.length; i++) {
          if (_fieldtags[i].title == selectedTag.title) {
            _fieldtags[i].selected = true;
          }
        }
      }
    } else {
      _tagsToShow = [_tagsToShow[0]] + [selectedTag];
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
      //if selected tag is anytime / anything so remove
      _tagsToShow.remove(_datetags[0]);
      if (!_datetags[_datetags.length - 1].selected) {
        _tagsToShow.remove(_datetags[_datetags.length - 1]);
      }
      _tagsToShow.remove(_fieldtags[0]);
      _fieldtags[0].selected = false;
      _datetags[0].selected = false;
    }
    selectedTag.selected = true;
    notifyListeners();
  }

  ///Remove a tag function
  ///   • Remove from _tagsToShow and reflect in _datetags / _fieldtags.
  ///
  ///   • Used with Search screen.
  void tagRemove(Tag selectedTag) {
    selectedTagsCount--;

    for (var i = 0; i < tagsToShow.length; i++) {
      if (selectedTag.title == _tagsToShow[i].title) {
        _tagsToShow.remove(_tagsToShow[i]);
      }
    }
    if (selectedTagsCount == 0) {
      _tagsToShow = _datetags + _fieldtags;
      _tagsToShow.remove(_fieldtags[0]);
      _tagsToShow.remove(_datetags[0]);
      if (!_datetags[_datetags.length - 1].selected) {
        _tagsToShow.remove(_datetags[_datetags.length - 1]);
      }
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

  ///##Select a tag function
  ///
  ///   • Select a filter tag by using tagSelect / tagRemove functions
  ///
  ///   • Used with Filter_type_select screen.
  void tagSelectFilter(Tag selectedTag, Tag removedTag) {
    // if (Date and select anytime) or (cat and select anything) => remove only
    if ((selectedTag.categ == 'date' &&
            selectedTag.title == _datetags[0].title) ||
        (selectedTag.categ == 'field' &&
            selectedTag.title == _fieldtags[0].title)) {
      tagRemove(removedTag);
    }
    // if (Date and remove anytime) or (cat and remove anything)
    else if ((removedTag.categ == 'date' &&
            removedTag.title == _datetags[0].title) ||
        (removedTag.categ == 'field' &&
            removedTag.title == _fieldtags[0].title)) {
      tagSelect(selectedTag);
    } else {
      tagRemove(removedTag);

      tagSelect(selectedTag);
    }

    notifyListeners();
  }

  ///##Reset all selected tags
  ///
  ///   • Reset all values to thier default
  void resetTags() {
    selectedTagsCount = 0;
    _fieldtags[0].selected = true;
    _datetags[0].selected = true;
    for (var i = 1; i < _fieldtags.length; i++) {
      _fieldtags[i].selected = false;
    }
    for (var i = 1; i < _datetags.length; i++) {
      _datetags[i].selected = false;
    }
    _tagsToShow = _datetags + _fieldtags;
    _tagsToShow.remove(_fieldtags[0]);
    _tagsToShow.remove(_datetags[0]);
    _tagsToShow.remove(_datetags[_datetags.length - 1]);
    notifyListeners();
  }

  ///Set all values by passed Tags temp
  void setAll(TemporaryTags temp) {
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
