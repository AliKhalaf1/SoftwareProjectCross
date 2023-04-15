library Categories;

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './categorey.dart';

class Categories {
  List<Categorey> _categories =[];

  ///Get All Categories
  List<Categorey> get categories {
    return [..._categories];
  }

  /// Get Category title
  Categorey getCatTitle(String theTitle) {
    return _categories.firstWhere((cat) => cat.title == theTitle);
  }

  ///Fetch Events using API  
  Future<void> fetchCategories() async {
    final url = Uri.https('http://127.0.0.1:8000', '/categories/');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, List<String>>;
      if (extractedData == null) {
        return;
      }
      final List<Categorey> loadedcategories = [];
      extractedData.forEach((catTitle, subCats) {
        loadedcategories.add(Categorey(
          catTitle,subCats
        ));
      });
      _categories= loadedcategories;
    } catch (error) {
      throw (error);
    }
  }
}