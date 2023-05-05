import 'package:Eventbrite/screens/creator/coupons_form.dart';
import 'package:Eventbrite/screens/creator/tickets_form.dart';
import 'package:Eventbrite/widgets/coupon_card.dart';
import 'package:flutter/material.dart';
import '../../widgets/backgroud.dart';

class AllCoupons extends StatelessWidget {
  bool found = true;
  static const route = '/eventsAllCoupons';
  @override
  Widget build(BuildContext context) {
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
      body: found
          ? ListView(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CouponCard('Coupon1', '50', 'amount', '5'),
              ],
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