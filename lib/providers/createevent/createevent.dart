import 'dart:convert';
import 'dart:io';

import 'package:Eventbrite/helper_functions/constants.dart';
import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/models/ticket_class.dart';
import 'package:Eventbrite/objectbox.dart';
import 'package:Eventbrite/screens/creator/all_tickets.dart';
import 'package:Eventbrite/screens/creator/event_location.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/event_promocode.dart';
import '../../objectbox.g.dart';
import '../events/event.dart';

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
  DateTime startDateCoupon;
  DateTime endDateCoupon;
  TimeOfDay startofEventClockCoupon;
  TimeOfDay endofEventClockCoupon;
  TheCoupon(
      this.name,
      this.limitedTo,
      this.discountType,
      this.discountValue,
      this.startDateCoupon,
      this.endDateCoupon,
      this.startofEventClockCoupon,
      this.endofEventClockCoupon);
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
    String name,
    int limitedTo,
    String discountType,
    double discountValue,
    DateTime startDate,
    DateTime endDate,
    TimeOfDay startDateClock,
    TimeOfDay endDateClock,
  ) {
    allCoupon.add(TheCoupon(
      name,
      limitedTo,
      discountType,
      discountValue,
      startDate,
      endDate,
      startDateClock,
      endDateClock,
    ));
    notifyListeners();
  }

  Future<void> addEvent() async {
    DateTime dateTime1 = DateTime(startofEvent!.year, startofEvent!.month,
        startofEvent!.day, startofEventClock!.hour, startofEventClock!.minute);
    DateTime dateTime2 = DateTime(endofEvent!.year, endofEvent!.month,
        endofEvent!.day, endofEventClock!.hour, endofEventClock!.minute);
    if (Constants.MockServer == false) {
      String formattedStart =
          DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime1);

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
        DateTime dateTime3 = DateTime(
            coupon.startDateCoupon.year,
            coupon.startDateCoupon.month,
            coupon.startDateCoupon.day,
            coupon.startofEventClockCoupon.hour,
            coupon.startofEventClockCoupon.minute);
        DateTime dateTime4 = DateTime(
            coupon.endDateCoupon.year,
            coupon.endDateCoupon.month,
            coupon.endDateCoupon.day,
            coupon.endofEventClockCoupon.hour,
            coupon.endofEventClockCoupon.minute);
        String formattedStart3 =
            DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime3);

        String formattedend4 =
            DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime4);
        return {
          "name": coupon.name,
          "is_limited": true,
          "limited_amount": coupon.limitedTo,
          "current_amount": coupon.limitedTo,
          "is_percentage": coupon.discountType == "percentage" ? true : false,
          "discount_amount": coupon.discountValue,
          "start_date_time": formattedStart3,
          "end_date_time": formattedend4,
        };
      }).toList();

      String token = await getToken();
      Map<String, String> reqHeaders = {
        'Authorization': 'Bearer $token',
        "Content-Type": "application/json"
      };

      final url =
          Uri.parse('https://eventbrite-995n.onrender.com/events/create');

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
        if (response.statusCode != 200) {
          throw HttpException('Error fetching data: ${response.statusCode}');
        }
      } catch (error) {
        print(error);
        throw HttpException('Error fetching data: ');
      }
    } else {
      String email = await getEmail();
      var userbox = ObjectBox.userBox;
      var user = userbox.query(User_.email.equals(email)).build().findFirst();

      Event newevent = Event(
        "",
        dateTime1,
        dateTime2,
        description,
        imageUrl,
        isOnline,
        false,
        eventCategory,
        [],
        title,
        nameOrganizer,
        !isPublic,
      );
      newevent.city = city!;
      newevent.creatorId = user!.mockId;

      var eventbox = ObjectBox.eventBox;
      int eventid = eventbox.put(newevent);

      for (int i = 0; i < allTickets.length; i++) {
        DateTime dateTime3 = DateTime(
            allTickets[i].startDate.year,
            allTickets[i].startDate.month,
            allTickets[i].startDate.day,
            allTickets[i].startofEventClock.hour,
            allTickets[i].startofEventClock.minute);
        DateTime dateTime4 = DateTime(
            allTickets[i].endDate.year,
            allTickets[i].endDate.month,
            allTickets[i].endDate.day,
            allTickets[i].endofEventClock.hour,
            allTickets[i].endofEventClock.minute);

        TicketClass newticket = TicketClass(
          "",
          allTickets[i].name,
          (allTickets[i].type == "vip"),
          allTickets[i].price,
          allTickets[i].maxquantity,
          dateTime3,
          dateTime4,
        );
        newticket.eventId = eventid;
        var ticketbox = ObjectBox.ticketClassBox;
        ticketbox.put(newticket);
      }
      for (int i = 0; i < allCoupon.length; i++) {
        EventPromocodeInfo newPromocode = EventPromocodeInfo(
          "",
          allCoupon[i].name,
          true,
          allCoupon[i].limitedTo,
          allCoupon[i].discountType == "percentage" ? true : false,
          allCoupon[i].discountValue,
          dateTime1,
          dateTime2,
        );
        newPromocode.eventIdMock = eventid;
        var promocodeBox = ObjectBox.eventPromocodeBox;
        promocodeBox.put(newPromocode);
      }
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
