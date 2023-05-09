import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ticketType {
  regular,
  vip,
}

class AttendeeForm extends StatefulWidget {
  static const route = '/add_Attendee';

  AttendeeForm({super.key});

  @override
  State<AttendeeForm> createState() => _AttendeeFormState();
}

class _AttendeeFormState extends State<AttendeeForm> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String email = "";
    String fname = "";
    String lname = "";
    ticketType typeofTickets = ticketType.regular;
    final routearg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    String? eventid = routearg['eventID'];
    int? eventidmock = routearg['eventIDMock'];

    print(eventid);
    print(eventidmock);

    void submit() {
      final isValid = _form.currentState?.validate();
      if (!isValid!) {
        return;
      }
      _form.currentState?.save();
      print(email);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(31, 10, 61, 1),
        title: const Text(
          "Attendee Data",
          style: TextStyle(
              fontFamily: "Neue Plak Extended",
              fontWeight: FontWeight.w600,
              color: Colors.white),
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
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Text(
                "Email",
                style: TextStyle(color: Colors.blue[700]),
              ),
              TextFormField(
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "Title needed ";
                    } else if (value.trim().isEmpty) {
                      return "Title needed no string spaces allowed ";
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
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
                  hintText: 'Enter your email',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontFamily: 'Neue Plak Extended',
                    fontWeight: FontWeight.w200,
                    fontSize: 22,
                    color: Colors.blueGrey.withOpacity(0.8),
                  ),
                ),
                onSaved: (value) {
                  email = value!;
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
                "firstname",
                style: TextStyle(color: Colors.blue[700]),
              ),
              TextFormField(
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "first name needed ";
                    } else if (value.trim().isEmpty) {
                      return "first name needed no string spaces allowed ";
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
                  hintText: 'Enter your firstname',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontFamily: 'Neue Plak Extended',
                    fontWeight: FontWeight.w200,
                    fontSize: 22,
                    color: Colors.blueGrey.withOpacity(0.8),
                  ),
                ),
                onSaved: (value) {
                  fname = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "LastName",
                style: TextStyle(color: Colors.blue[700]),
              ),
              TextFormField(
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) {
                      return "lastname name needed ";
                    } else if (value.trim().isEmpty) {
                      return "lastname needed no string spaces allowed ";
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
                  hintText: 'Enter your lastname',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    fontFamily: 'Neue Plak Extended',
                    fontWeight: FontWeight.w200,
                    fontSize: 22,
                    color: Colors.blueGrey.withOpacity(0.8),
                  ),
                ),
                onSaved: (value) {
                  lname = value!;
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
