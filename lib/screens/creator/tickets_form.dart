import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum ticketType {
  regular,
  vip,
}

class TicketForm extends StatefulWidget {
  const TicketForm({super.key});
  static const route = '/ticketsform';
  @override
  State<TicketForm> createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  @override
  ticketType typeofTickets = ticketType.regular;
  DateTime? _dateFrom = DateTime.now();
  DateTime? _dateTo = DateTime.now();
  TimeOfDay? _timeFrom = TimeOfDay.now();
  TimeOfDay? _timeTo = TimeOfDay.now();
  final DateFormat formatter = DateFormat('EEE, dd MMM yyyy');

  void _showDatePickerfrom() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
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
      firstDate: DateTime(2015),
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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(31, 10, 61, 1),
        title: const Text(
          " Ticket Data",
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
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              "Ticket name",
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
            const SizedBox(
              height: 15,
            ),
            Text(
              "Type of ticket",
              style: TextStyle(color: Colors.blue[700]),
            ),
            PopupMenuButton(
              color: Colors.white,
              initialValue: typeofTickets,
              onSelected: (item) {
                setState(() {
                  typeofTickets = item;
                });
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: ticketType.regular,
                  child: Text(
                    'regular',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                const PopupMenuItem(
                  value: ticketType.vip,
                  child: Text('vip'),
                ),
              ],
              child: Row(
                children: [
                  Text(typeofTickets.toString().split('.').last),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Quantity",
              style: TextStyle(color: Colors.blue[700]),
            ),
            TextFormField(
              validator: (value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return "Quantity needed ";
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
                hintText: 'Quantity',
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
            ),
            Text(
              "Price",
              style: TextStyle(color: Colors.blue[700]),
            ),
            TextFormField(
              validator: (value) {
                if (value != null) {
                  if (value.isEmpty) {
                    return "Price needed ";
                  } else {
                    final RegExp priceRegex = RegExp(r'^\d+(\.\d{1,2})?$');
                    if (!priceRegex.hasMatch(value)) {
                      return 'Invalid price format';
                    }
                    return null;
                  }
                }
                return 'null value';
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,1}')),
              ],
              cursorColor: Colors.black,
              cursorHeight: 18,
              style: const TextStyle(
                fontFamily: 'Neue Plak Extended',
                fontWeight: FontWeight.w200,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.attach_money,
                  size: 20,
                  color: Colors.black,
                ),
                hintText: 'Price',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontFamily: 'Neue Plak Extended',
                  fontWeight: FontWeight.w200,
                  fontSize: 20,
                  color: Colors.blueGrey.withOpacity(0.8),
                ),
              ),
              onSaved: (value) {},
              autofocus: true,
            ),
            SizedBox(
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
          ],
        ),
      )),
    );
  }
}
