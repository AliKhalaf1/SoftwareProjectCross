import 'package:flutter/material.dart';

import '../widgets/tab_bar_Events.dart';

/// {@category Navigation}
/// {@category Helper Functions}
///
/// <h1>This function is used to navigate to the Creator View.</h1>
///
/// It takes the context of the page as a parameter.
///
/// It then pushes the TabBarEvents page to the Navigator.
///
void eventNavigate(BuildContext ctx) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return TabBarEvents();
  }));
  // we use same string in main it’s a key
}
