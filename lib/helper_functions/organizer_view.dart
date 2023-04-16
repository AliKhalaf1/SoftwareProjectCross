import 'package:flutter/material.dart';

import '../widgets/tab_bar_Events.dart';

void eventNavigate(BuildContext ctx) {
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    return TabBarEvents();
  }));
  // we use same string in main it’s a key
}
