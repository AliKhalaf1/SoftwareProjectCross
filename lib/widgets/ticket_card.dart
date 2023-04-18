import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class TicketCard extends StatefulWidget {
  Function onTap;
  TicketCard(this.onTap, {super.key});

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  @override
  Widget build(BuildContext context) {
    return Text('TicketCard');
  }
}
