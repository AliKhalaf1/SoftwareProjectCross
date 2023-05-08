import 'package:Eventbrite/screens/creator/coupons_form.dart';
import 'package:Eventbrite/screens/creator/tickets_form.dart';
import 'package:Eventbrite/widgets/coupon_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/createevent/createevent.dart';
import '../../widgets/backgroud.dart';

class AllCoupons extends StatelessWidget {
  bool found = true;
  static const route = '/eventsAllCoupons';
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<TheEvent>(context, listen: true);
    final couponsItems = event.alltheCoupons;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(31, 10, 61, 1),
        title: const Text(
          "Coupons",
          style: TextStyle(
            fontFamily: "Neue Plak Extended",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: event.totalCouponsLength != 0
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                itemCount: event.totalCouponsLength,
                itemBuilder: (context, index) {
                  return CouponCard(
                    couponsItems[index].name,
                    couponsItems[index].limitedTo.toString(),
                    couponsItems[index].discountType,
                    couponsItems[index].discountValue.toString(),
                  );
                },
              ),
            )
          : Background("assets/images/tickets.jfif"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CouponForm.route);
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
