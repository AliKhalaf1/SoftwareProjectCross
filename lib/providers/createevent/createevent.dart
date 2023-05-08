import 'dart:convert';

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TheTicket {
  String name;
  String type;
  int maxquantity;
  double price;
  DateTime startDate;
  DateTime endDate;
  TimeOfDay startofEventClock;
  TimeOfDay endofEventClock;
  TheTicket(this.name, this.type, this.maxquantity, this.price, this.startDate,
      this.endDate, this.startofEventClock, this.endofEventClock);
  String toString() {
    return 'TheTicket{name: $name, type: $type, maxquantity: $maxquantity, price: $price, startDate: $startDate, endDate: $endDate, startofEventClock: $startofEventClock, endofEventClock: $endofEventClock}';
  }
}

class TheCoupon {
  String name;
  int limitedTo;
  String discountType;
  double discountValue;
  TheCoupon(this.name, this.limitedTo, this.discountType, this.discountValue);
}

class TheEvent with ChangeNotifier {
  List<TheTicket> allTickets = [];
  List<TheCoupon> allCoupon = [];
  String title;
  String nameOrganizer;
  String eventCategory;
  String imageUrl;
  String description;
  bool isPublic;
  DateTime? startofEvent;
  DateTime? endofEvent;
  TimeOfDay? startofEventClock;
  TimeOfDay? endofEventClock;
  bool isOnline;
  String? city;

  TheEvent(
      {this.title = "",
      this.nameOrganizer = "",
      this.eventCategory = "",
      this.imageUrl = "",
      this.description = "",
      this.isPublic = true,
      this.isOnline = false,
      this.city,
      this.startofEvent,
      this.endofEvent,
      this.startofEventClock,
      this.endofEventClock});

  @override
  String toString() {
    return 'TheEvent(title: $title, nameOrganizer: $nameOrganizer, '
        'eventCategory: $eventCategory, imageUrl: $imageUrl, '
        'description: $description, isPublic: $isPublic, '
        'isOnline: $isOnline, city: $city, startofEvent: $startofEvent, '
        'endofEvent: $endofEvent, startofEventClock: $startofEventClock, '
        'endofEventClock: $endofEventClock)';
  }

  List<TheTicket> get alltheTickets {
    return [...allTickets];
  }

  List<TheCoupon> get alltheCoupons {
    return [...allCoupon];
  }

  set setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  set setNameOrganizer(String nameOrganizer) {
    this.nameOrganizer = nameOrganizer;
    notifyListeners();
  }

  set setEventCategory(String eventCategory) {
    this.eventCategory = eventCategory;
    notifyListeners();
  }

  set setImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
    notifyListeners();
  }

  set setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  set setIsPublic(bool isPublic) {
    this.isPublic = isPublic;
    notifyListeners();
  }

  set setStartOfEvent(DateTime startOfEvent) {
    this.startofEvent = startOfEvent;
    notifyListeners();
  }

  set setEndOfEvent(DateTime endOfEvent) {
    this.endofEvent = endOfEvent;
    notifyListeners();
  }

  set setStartOfEventClock(TimeOfDay startOfEventClock) {
    this.startofEventClock = startOfEventClock;
    notifyListeners();
  }

  set setEndOfEventClock(TimeOfDay endOfEventClock) {
    this.endofEventClock = endOfEventClock;
    notifyListeners();
  }

  set setIsOnline(bool isOnline) {
    this.isOnline = isOnline;
    notifyListeners();
  }

  set setCity(String? city) {
    this.city = city;
    notifyListeners();
  }

  int get totalTicketsLength {
    return allTickets.length;
  }

  int get totalCouponsLength {
    return allCoupon.length;
  }

  void addTicket(
      String name,
      String type,
      int maxQuantity,
      double price,
      DateTime startDate,
      DateTime endDate,
      TimeOfDay startDateClock,
      TimeOfDay endDateClock) {
    allTickets.add(
      TheTicket(name, type, maxQuantity, price, startDate, endDate,
          startDateClock, endDateClock),
    );
    notifyListeners();
  }

  void addCoupon(
      String name, int limitedTo, String discountType, double discountValue) {
    allCoupon.add(TheCoupon(name, limitedTo, discountType, discountValue));
    notifyListeners();
  }

  Future<void> addEvent() async {
    DateTime dateTime1 = DateTime(startofEvent!.year, startofEvent!.month,
        startofEvent!.day, startofEventClock!.hour, startofEventClock!.minute);
    DateTime dateTime2 = DateTime(endofEvent!.year, endofEvent!.month,
        endofEvent!.day, endofEventClock!.hour, endofEventClock!.minute);

    String formattedStart = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime1);

    String formattedend = DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime2);

    List<Map<String, dynamic>> mapsofTickets = allTickets.map((ticket) {
      DateTime dateTime3 = DateTime(
          ticket.startDate.year,
          ticket.startDate.month,
          ticket.startDate.day,
          ticket.startofEventClock.hour,
          ticket.startofEventClock.minute);
      DateTime dateTime4 = DateTime(
          ticket.endDate.year,
          ticket.endDate.month,
          ticket.endDate.day,
          ticket.endofEventClock.hour,
          ticket.endofEventClock.minute);
      String formattedStart3 =
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime3);

      String formattedend4 =
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime4);
      return {
        "type": ticket.type,
        "name": ticket.name,
        "max_quantity": ticket.maxquantity,
        'price': ticket.price,
        'sales_start_date_time': formattedStart3,
        'sales_end_date_time': formattedend4,
      };
    }).toList();

    List<Map<String, dynamic>> mapsofCoupons = allCoupon.map((coupon) {
      return {
        "name": coupon.name,
        "is_limited": true,
        "limited_amount": coupon.limitedTo,
        "current_amount": coupon.limitedTo,
        "is_percentage": coupon.discountType == "percentage" ? true : false,
        "discount_amount": coupon.discountValue,
        "start_date_time": formattedStart,
        "end_date_time": formattedend,
      };
    }).toList();

    String token = await getToken();
    Map<String, String> reqHeaders = {
      'Authorization': 'Bearer $token',
      "Content-Type": "application/json"
    };

    final url = Uri.parse('https://eventbrite-995n.onrender.com/events/create');

    var body = json.encode(
      {
        "basic_info": {
          "title": title,
          "organizer": nameOrganizer,
          "category": eventCategory,
          "sub_category": eventCategory,
        },
        "image_link": imageUrl,
        "summary": description,
        "description": description,
        "state": {"is_public": isPublic, "publish_date_time": formattedStart},
        "date_and_time": {
          "start_date_time": formattedStart,
          "end_date_time": formattedend,
          "is_display_start_date": false,
          "is_display_end_date": false,
          "time_zone": "US/Pacific",
          "event_page_language": "en-US"
        },
        "location": {"is_online": isOnline, "city": city},
        "tickets": mapsofTickets,
        "promocodes": mapsofCoupons,
      },
    ); //body

    try {
      final response = await http.post(url, headers: reqHeaders, body: body);
      print(response.statusCode);
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void removeTicket(int index) {
    allTickets.removeAt(index);
    notifyListeners();
  }

  void removeCoupon(int index) {
    allCoupon.removeAt(index);
    notifyListeners();
  }

  void reset() {
    title = "";
    nameOrganizer = "";
    eventCategory = "";
    imageUrl = "";
    description = "";
    isPublic = true;
    startofEvent = null;
    endofEvent = null;
    startofEventClock = null;
    endofEventClock = null;
    isOnline = false;
    city = null;
    allTickets = [];
    allCoupon = [];
    notifyListeners();
  }
}
