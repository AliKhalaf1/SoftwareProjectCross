library PlaceOrderWidget;

import 'dart:async';

import 'package:Eventbrite/widgets/buy_tickets.dart';
import 'package:Eventbrite/widgets/title_text_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/event_promocode.dart';
import 'transparent_button_no_icon.dart';
import '../models/event_ticket.dart';

class PlaceOrder extends StatefulWidget {
  final eventId;
  final List<EventTicketInfo> reservedFreeTickets;
  final List<EventTicketInfo> reservedVipTickets;
  final String? promocodetId;
  final double totalPrice = 0;
  const PlaceOrder(this.eventId, this.reservedFreeTickets,
      this.reservedVipTickets, this.promocodetId,
      {super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
//**************************************************************************************************************** */
//--========================================= Controllers of the form =========================================--
//--================================================== variables ==============================================--
//**************************************************************************************************************** */

  final _form = GlobalKey<FormState>();

//--================================================== Methods ==============================================--
//**************************************************************************************************************** */

  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Leave Checkout'),
          content: Text(
              'Are you sure you want to leave checkOut? The items you\'ve selected may not be available later.'),
          actions: [
            TextButton(
              child: const Text('Leave'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showSessionTimeoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Session Timeout'),
          content: Text(
              'Your reservation has been released. please re-start your purchase.'),
          actions: [
            TextButton(
              child: const Text('Back to Tickets'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      showSessionTimeoutDialog(context);
    });
    // Timer.run(() {
    //   setState(() {

    //   });
    //  });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("PlaceOrderModal"),
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 1,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
        shadowColor: const Color.fromARGB(255, 255, 255, 255),
        title: Padding(
          padding: const EdgeInsets.only(top: 30.0, bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Checkout',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  )),
              SizedBox(
                height: 10,
              ),
              Text('Session Timer',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 119, 118, 118))),
            ],
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => showConfirmationDialog(context),
            icon: const Icon(Icons.close, size: 15),
          ),
        ],
      ),
      body: GlowingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        color: const Color.fromARGB(255, 255, 72, 0),
        child: ListView(children: <Widget>[
          Card(
            color: Colors.white,
            elevation: 5,
            child: Form(
              key: _form,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
