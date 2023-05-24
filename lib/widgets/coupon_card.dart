library CouponCard;

import 'package:flutter/material.dart';

/// {@category Widgets}
/// A card widget that displays information about a coupon.
///
/// The CouponCard widget can be used to display the following information:
///
/// Coupon name Limited usage Discount type Discount value

class CouponCard extends StatelessWidget {
  final String couponName;
  final String limitedTo;
  final String discountType;
  final String discountValue;
  CouponCard(
      this.couponName, this.limitedTo, this.discountType, this.discountValue,
      {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          child: ListTile(
            key: key,
            onTap: () {},
            leading: Icon(
              Icons.wallet_giftcard_outlined,
              color: Colors.amber[700],
            ),
            title: Text(
              couponName,
              style: TextStyle(
                color: Theme.of(context).cardColor,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Limited to: $limitedTo',
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                  ),
                ),
                Text(
                  'Discount value: $discountValue',
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ],
            ),
            trailing: Text(
              'Discount type:$discountType',
              style: TextStyle(
                color: Theme.of(context).cardColor,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
