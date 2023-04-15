library TagModel;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// {@category Models}
///## Tags class that stores each tag info
///
///   • selected: boolean is true only if the tag is selected
///
///   • title: tag title
///
///
class Tag with ChangeNotifier {
  final String title;
  bool selected;

  ///Constructor
  Tag(this.title, this.selected);

  /// Get is the event favourited or not
  bool isSelected() {
    return selected;  
  }

  
}
