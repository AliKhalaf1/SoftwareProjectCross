library TagModel;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// {@category Providers}
///## Tag class that stores each tag info
///
///   • selected: boolean is true only if the tag is selected
///
///   • title: tag title
///
///
class Tag with ChangeNotifier {
  final String title;
  bool selected;
  final String categ;

  ///Constructor
  Tag(this.title, this.selected, this.categ);

  /// Get is the event favourited or not
  bool isSelected() {
    return selected;  
  }
  
}
