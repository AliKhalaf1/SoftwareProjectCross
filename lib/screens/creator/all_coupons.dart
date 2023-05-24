library AddCoupons;

import 'package:Eventbrite/screens/creator/coupons_form.dart';
import 'package:Eventbrite/widgets/coupon_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/createevent/createevent.dart';
import '../../widgets/backgroud.dart';
/// {@category creator}
/// {@category Screens}
/// 
/// 
/// class named AllCoupons that extends StatelessWidget. 
/// It represents a screen  that displays a list of coupons for an event to collect the coupon information.


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
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Theme.of(context).colorScheme.error,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 40,
                      ),
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 4,
                      ),
                    ),
                    confirmDismiss: (direction) {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text(
                            'Do you want to remove the Ticket?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                            ),
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      event.removeCoupon(index);
                    },
                    child: CouponCard(
                      couponsItems[index].name,
                      couponsItems[index].limitedTo.toString(),
                      couponsItems[index].discountType,
                      couponsItems[index].discountValue.toString(),
                    ),
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
