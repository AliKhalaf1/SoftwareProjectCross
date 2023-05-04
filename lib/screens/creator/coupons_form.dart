import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class _CouponFormState extends State<CouponForm> {
  @override
  discountType couponType = discountType.percentage;
  Widget build(BuildContext context) {
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
              onPressed: () {},
              icon: Icon(
                Icons.add_task,
                color: Colors.green,
              ))
        ],
      ),
      body: Form(
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
                hintText: 'Enter a short distinct name',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'Neue Plak Extended',
                  fontWeight: FontWeight.w200,
                  fontSize: 22,
                  color: Colors.blueGrey.withOpacity(0.8),
                ),
              ),
              onSaved: (value) {},
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
                if (value != null) {
                  if (value.isEmpty) {
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
                // CAN BE NEEDED
//                              int inputValue = 00222; // Example input value
// String inputString = inputValue.toString(); // Convert to string
// inputString = inputString.replaceFirst(RegExp('^0+'), ''); // Remove leading zeros
// print(inputString); // Output: "222"
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
                if (value != null) {
                  if (value.isEmpty) {
                    return "We need Discount Value ";
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
                // CAN BE NEEDED
//                              int inputValue = 00222; // Example input value
// String inputString = inputValue.toString(); // Convert to string
// inputString = inputString.replaceFirst(RegExp('^0+'), ''); // Remove leading zeros
// print(inputString); // Output: "222"
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
