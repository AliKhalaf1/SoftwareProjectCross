library TicketsForm;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/createevent/createevent.dart';

/// {@category Creator}
/// {@category Screens}
/// 
/// 
/// 

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
  final _form = GlobalKey<FormState>();
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

  String name = '';
  int quantity = 0;
  double price = 0;

  String saveform() {
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

    return "Done";
  }

  Widget build(BuildContext context) {
    final event = Provider.of<TheEvent>(context, listen: false);
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
              onPressed: () {
                String check = saveform();
                if (check == 'Done') {
                  final isValid = _form.currentState?.validate();
                  if (!isValid!) {
                    return;
                  }
                  _form.currentState?.save();

                  event.addTicket(
                      name,
                      typeofTickets.toString().split('.').last,
                      quantity,
                      price,
                      _dateFrom!,
                      _dateTo!,
                      _timeFrom!,
                      _timeTo!);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Successfully Added'),
                        content:
                            const Text('Your Ticket is Successfully added'),
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
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(check),
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
                }
              },
              icon: Icon(
                Icons.add_task,
                color: Colors.green,
              ))
        ],
      ),
      body: Form(
        key: _form,
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
                onSaved: (value) {
                  name = value!;
                },
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
                  if (value != null || int.tryParse(value!) != null) {
                    if (value.isEmpty || int.tryParse(value) == 0) {
                      return "Quantity needed ";
                    } else if (value == "0") {
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
                  quantity = int.parse(value!);
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
                      final RegExp priceRegex = RegExp(r'^\d+(\.\d{1,3})?$');
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
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
                ],
                cursorColor: Colors.black,
                cursorHeight: 18,
                style: const TextStyle(
                  fontFamily: 'Neue Plak Extended',
                  fontWeight: FontWeight.w200,
                  fontSize: 15,
                ),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
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
                onSaved: (value) {
                  price = double.parse(value!);
                  print(price);
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
            ],
          ),
        ),
      ),
    );
  }
}
