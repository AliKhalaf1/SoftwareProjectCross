/// {@nodoc}
/// nodoc
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:objectbox/objectbox.dart';
import '../filters/tag.dart';

/// {@category Providers}
///## Ticket class that stores each ticket information inside following attributes
///
///   • eventImgUrl: cover image for the ticket
///
///   • date: date when the event held
///
///   • title: title of the event

@Entity()
class Ticket with ChangeNotifier {
  //parameters of the EventCard Widget
  @Id()
  int mockId = 0;

  String OrderId = "";
  final String eventImgUrl; /*event card image */
  final DateTime date; /*event date*/
  final String title; /*event dscription*/
  final double price;

  ///Ticket Constructor
  Ticket(
    this.eventImgUrl,
    this.date,
    this.title,
    this.price,
  );
}
