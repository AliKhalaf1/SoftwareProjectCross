import 'dart:convert';

import 'package:Eventbrite/helper_functions/log_in.dart';
import 'package:Eventbrite/widgets/loading_spinner.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../helper_functions/constants.dart';

enum ticketType {
  regular,
  vip,
}

class AttendeeForm extends StatefulWidget {
  static const route = '/add_Attendee';

  AttendeeForm({super.key});
  bool isLoading = false;
  String orderID = "";
  String eventImage = "";

  @override
  State<AttendeeForm> createState() => _AttendeeFormState();
}

class _AttendeeFormState extends State<AttendeeForm> {
  void getData(String email, String fname, String lname, String type,
      String eventid, int eventidmock) async {
    setState(() {
      widget.isLoading = true;
    });
    if (Constants.MockServer == false) {
      print("I'm here1");
      // string to uri
      var uri = Uri.parse('${Constants.host}/events/id/${eventid}');
      print(uri);
      //create multipart request

      var response = await http.get(uri);

      var res = response.body;
      var resData = jsonDecode(res);

      print(response.statusCode);
      //Check Response
      if (response.statusCode == 200) {
        widget.eventImage = resData['image_link'];
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Event Not Found"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something wet wrong"),
        ));
      }

//////////////////////////////////getorder///////////////////////////////////////////
      uri = Uri.parse('${Constants.host}/orders/${eventid}/add_order');
      print(uri);
      String token = await getToken();
      //create multipart request
      Map<String, String> reqHeaders = {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Map<String, dynamic> reqBody = {
        "first_name": fname,
        "last_name": lname,
        "email": email,
        "event_id": eventid,
        "created_date":
            DateFormat('yyyy-MM-ddTHH:mm:ss').format(DateTime.now()),
        "price": 0,
        "image_link": widget.eventImage,
      };

      response = await http.post(
        uri,
        headers: reqHeaders,
        body: jsonEncode(reqBody),
      );

      res = response.body;
      resData = jsonDecode(res);

      //Check Response
      if (response.statusCode == 200) {
        widget.orderID = resData['id'];
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Event Not Found"),
        ));
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something wet wrong"),
        ));
      }

////////////////////////////Add Attendee///////////////////////////////////////
      ///
      ///
      uri = Uri.parse('${Constants.host}/attendees/${eventid}/add_attendee');
      print(uri);
      //create multipart request

      reqBody = {
        "first_name": fname,
        "last_name": lname,
        "email": email,
        "type_of_reseved_ticket": type,
        "order_id": widget.orderID,
        "event_id": eventid,
      };

      response = await http.post(
        uri,
        headers: reqHeaders,
        body: jsonEncode(reqBody),
      );

      res = response.body;
      resData = jsonDecode(res);

      //Check Response
      if (response.statusCode == 200) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Attendee Added Succefully"),
        ));
      } else if (response.statusCode == 404) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Event Not Found"),
        ));
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something wet wrong"),
        ));
      }
    } else {
      // var authbox = ObjectBox.authBox;
      // var userbox = ObjectBox.userBox;

      // var authQuery =
      //     authbox.query(Auth_.email.equals(email)).build().findFirst();
      // if (authQuery != null) {
      //   var userQuery =
      //       userbox.query(User_.email.equals(email)).build().findFirst();

      //   User user = userQuery!;

      //   Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      //     return PasswordCheck(email, user.imageUrl);
      //   }));
      // } else {
      //   Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      //     return SignUpForm(email);
      //   }));
      // }
    }
    setState(() {
      widget.isLoading = false;
    });
  }

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
      getData(
          email,
          fname,
          lname,
          typeofTickets == ticketType.vip ? "vip" : "regular",
          eventid!,
          eventidmock!);
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
      body: widget.isLoading
          ? LoadingSpinner()
          : Form(
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
