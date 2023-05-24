library CouponsForm;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/createevent/createevent.dart';

/// {@category Creator}
/// {@category Screens}
///
///  A form that allows the user to create a new coupon with a name, type (percentage or amount), a limit, and a discount value.
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
  DateTime? _dateFrom = DateTime.now();
  DateTime? _dateTo = DateTime.now();
  TimeOfDay? _timeFrom = TimeOfDay.now();
  TimeOfDay? _timeTo = TimeOfDay.now();
  final DateFormat formatter = DateFormat('EEE, dd MMM yyyy');

  void _showDatePickerfrom() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    ).then((value) {
      setState(() {
        _dateFrom = value!;
      });
    });
  }

  void _showDatePickerto() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2035),
    ).then((value) {
      setState(() {
        _dateTo = value!;
      });
    });
  }

  void _showTimePickerFrom() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            backgroundColor: Colors.grey,
          ),
          child: child!,
        );
      },
    ).then((value) {
      setState(() {
        _timeFrom = value!;
      });
    });
  }

  void _showTimePickerTo() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            backgroundColor: Colors.grey,
          ),
          child: child!,
        );
      },
    ).then((value) {
      setState(() {
        _timeTo = value!;
      });
    });
  }

  discountType couponType = discountType.percentage;
  final _focusNode1 = FocusNode();
  final _focusNode2 = FocusNode();
  final _focusNode3 = FocusNode();

  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();

    super.dispose();
  }

  String timeCheck() {
    DateTime dateTime1 = DateTime.now();
    DateTime dateTime2 = DateTime.now();

    if (_dateFrom == null ||
        _dateTo == null ||
        _timeFrom == null ||
        _timeTo == null) {
      // Display an error message if any of the values are null
      // ...
      return "Error in your date";
    }
    dateTime1 = DateTime(_dateFrom!.year, _dateFrom!.month, _dateFrom!.day,
        _timeFrom!.hour, _timeFrom!.minute);
    dateTime2 = DateTime(_dateTo!.year, _dateTo!.month, _dateTo!.day,
        _timeTo!.hour, _timeTo!.minute);

    if ((dateTime1.isAfter(dateTime2)) ||
        (dateTime1.isAtSameMomentAs(dateTime2)) ||
        DateTime.now().isAfter(dateTime1)) {
      return "Error in your date  ";
    }
    DateTime dateTime3 = DateTime(
        event.endofEvent!.year,
        event.endofEvent!.month,
        event.endofEvent!.day,
        event.endofEventClock!.hour,
        event.endofEventClock!.minute);

    if (dateTime2.isAfter(dateTime3)) {
      return "Error in your date";
    }

    return "Done";
  }

  late TheEvent event;
  void submit() {
    String checker;
    checker = timeCheck();
    if (checker != "Done") {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text("Error in your date"),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    event.addCoupon(
        couponName!,
        limitedTo!,
        couponType.toString().split('.').last,
        discountValue!,
        _dateFrom!,
        _dateTo!,
        _timeFrom!,
        _timeTo!);

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
  }

  Widget build(BuildContext context) {
    event = Provider.of<TheEvent>(context, listen: false);
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
                submit();
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
              focusNode: _focusNode1,
              onFieldSubmitted: (value) {
                _focusNode1.unfocus();
                FocusScope.of(context).requestFocus(_focusNode2);
              },
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
              focusNode: _focusNode2,
              onFieldSubmitted: (value) {
                _focusNode2.unfocus();
                FocusScope.of(context).requestFocus(_focusNode3);
              },
              onSaved: (value) {
                limitedTo = int.parse(value!);
              },
            ),
            const SizedBox(
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
                    if (couponType == discountType.percentage &&
                        double.tryParse(value)! > 100) {
                      return " range from 0 to 100";
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
              focusNode: _focusNode3,
              onFieldSubmitted: (value) {
                submit();
              },
              onSaved: (value) {
                discountValue = double.parse(value!);
                print(discountValue);
              },
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Sales date",
              style: TextStyle(color: Colors.blue[700]),
            ),
            ListTile(
              leading: Icon(
                Icons.calendar_month,
                color: Colors.blue[700],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Start of sale"),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showDatePickerfrom();
                        },
                        child: Text(
                          formatter.format(_dateFrom!),
                          style: const TextStyle(
                              fontFamily: 'Neue Plak Extended',
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showTimePickerFrom();
                        },
                        child: Text(
                          _timeFrom!.format(context).toString(),
                          style: const TextStyle(
                              fontFamily: 'Neue Plak Extended',
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("End of sale"),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showDatePickerto();
                        },
                        child: Text(
                          formatter.format(_dateTo!),
                          style: const TextStyle(
                              fontFamily: 'Neue Plak Extended',
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _showTimePickerTo();
                        },
                        child: Text(
                          _timeTo!.format(context).toString(),
                          style: const TextStyle(
                              fontFamily: 'Neue Plak Extended',
                              fontWeight: FontWeight.w100,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
