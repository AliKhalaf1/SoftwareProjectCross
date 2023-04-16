library CategoreyModel;

import 'package:flutter/material.dart';

/// {@category Model}
///## Categorey class that stores each Categorey information and its sub-categories

class Categorey with ChangeNotifier {
  //parameters of the categorey Widget
  final String title;
  final List<String> subCategories;

  ///Constructor
  Categorey(this.title, this.subCategories);
}
