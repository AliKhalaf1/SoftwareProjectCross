import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/createevent/createevent.dart';

enum discountType {
  percentage,
  amount,
}

class CouponForm extends StatefulWidget {
  const CouponForm({super.key});
  static const route = '/couponform';
  @override
  State<CouponForm> createState() => _CouponFormState();
}

String? couponName;
int? limitedTo;
double? discountValue;
final _form = GlobalKey<FormState>();

class _CouponFormState extends State<CouponForm> {
  @override
  discountType couponType = discountType.percentage;
  Widget build(BuildContext context) {
    final event = Provider.of<TheEvent>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(31, 10, 61, 1),
        title: const Text(
          " Coupon Data",
          style: TextStyle(
            fontFamily: "Neue Plak Extended",
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                final isValid = _form.currentState?.validate();
                if (!isValid!) {
                  return;
                }
                _form.currentState?.save();
                event.addCoupon(couponName!, limitedTo!,
                    couponType.toString().split('.').last, discountValue!);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Successfully Added'),
                      content: const Text('Your Coupon is Successfully added'),
                      actions: [
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            int count = 0;
                            Navigator.popUntil(
                              context,
                              (route) => count++ == 2 || route.isFirst,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.add_task,
                color: Colors.green,
              ))
        ],
      ),
      body: Form(
        key: _form,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              "Coupon name",
              style: TextStyle(color: Colors.blue[700]),
            ),
            TextFormField(
              validator: (value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return "Title needed ";
                  } else if (value.trim().isEmpty) {
                    return "Title needed no string spaces allowed ";
                  } else {
                    return null;
                  }
                }
                return 'null value';
              },
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              maxLength: 50,
              cursorColor: Colors.black,
              cursorHeight: 18,
              style: const TextStyle(
                fontFamily: 'Neue Plak Extended',
                fontWeight: FontWeight.w200,
                fontSize: 20,
              ),
              decoration: InputDecoration(
                hintText: 'Enter a coupon name',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'Neue Plak Extended',
                  fontWeight: FontWeight.w200,
                  fontSize: 22,
                  color: Colors.blueGrey.withOpacity(0.8),
                ),
              ),
              onSaved: (value) {
                couponName = value;
              },
              autofocus: true,
            ),
            Text(
              "Type of coupon",
              style: TextStyle(color: Colors.blue[700]),
            ),
            PopupMenuButton(
              color: Colors.white,
              initialValue: couponType,
              onSelected: (item) {
                setState(() {
                  couponType = item;
                });
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: discountType.percentage,
                  child: Text(
                    'percentage',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const PopupMenuItem(
                  value: discountType.amount,
                  child: Text('amount'),
                ),
              ],
              child: Row(
                children: [
                  Text(couponType.toString().split('.').last),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Limited to",
              style: TextStyle(color: Colors.blue[700]),
            ),
            TextFormField(
              validator: (value) {
                if (value != null || int.tryParse(value!) != null) {
                  if (value.isEmpty || int.tryParse(value) == 0) {
                    return "The limit is needed ";
                  } else {
                    return null;
                  }
                }
                return 'null value';
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly // Allow only digits
              ],
              cursorColor: Colors.black,
              cursorHeight: 18,
              style: const TextStyle(
                fontFamily: 'Neue Plak Extended',
                fontWeight: FontWeight.w200,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: 'Limited to',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'Neue Plak Extended',
                  fontWeight: FontWeight.w200,
                  fontSize: 20,
                  color: Colors.blueGrey.withOpacity(0.8),
                ),
              ),
              onSaved: (value) {
                limitedTo = int.parse(value!);
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Discount",
              style: TextStyle(color: Colors.blue[700]),
            ),
            TextFormField(
              validator: (value) {
                if (value != null || double.tryParse(value!) != null) {
                  if (value.isEmpty || double.tryParse(value) == 0) {
                    return "Discount needed ";
                  } else {
                    final RegExp priceRegex = RegExp(r'^\d+(\.\d{1,2})?$');
                    if (!priceRegex.hasMatch(value)) {
                      return 'Invalid format';
                    }
                    return null;
                  }
                }
                return 'null value';
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              cursorColor: Colors.black,
              cursorHeight: 18,
              style: const TextStyle(
                fontFamily: 'Neue Plak Extended',
                fontWeight: FontWeight.w200,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                hintText: 'Discount value',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'Neue Plak Extended',
                  fontWeight: FontWeight.w200,
                  fontSize: 20,
                  color: Colors.blueGrey.withOpacity(0.8),
                ),
              ),
              onSaved: (value) {
                discountValue = double.parse(value!);
                print(discountValue);
              },
            ),
            const SizedBox(
              height: 15,
            )
          ]),
        ),
      ),
    );
  }
}
