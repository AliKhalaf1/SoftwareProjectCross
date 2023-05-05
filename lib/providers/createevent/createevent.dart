import 'package:flutter/material.dart';

class TheTicket {
  String name;
  String type;
  int maxquantity;
  int price;
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
  int discountValue;
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
      int price,
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
      String name, int limitedTo, String discountType, int discountValue) {
    allCoupon.add(TheCoupon(name, limitedTo, discountType, discountValue));
    notifyListeners();
  }
}
