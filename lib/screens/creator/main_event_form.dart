import 'dart:io';

import 'package:Eventbrite/screens/creator/all_coupons.dart';
import 'package:Eventbrite/screens/creator/all_tickets.dart';
import 'package:Eventbrite/screens/creator/bar_location.dart';
import 'package:Eventbrite/screens/user/profile.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../helper_functions/upload_image.dart';
import '../../providers/createevent/createevent.dart';
import '../../widgets/drawer.dart';
import 'package:flutter/material.dart';

import '../../widgets/tab_bar_Events.dart';

enum eventPlace {
  Venue,
  Online,
}

enum eventCategories {
  Anything,
  Learn,
  Buisness,
  Health,
  SportsandFitness,
  Tech,
  Culture,
}

enum thePrivacy {
  Public,
  Private,
}

class EventForm extends StatefulWidget {
  const EventForm({super.key});
  static const route = '/maineventsform';

  @override
  State<EventForm> createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _form = GlobalKey<FormState>();

  DateTime? _dateFrom;
  DateTime? _dateTo;
  TimeOfDay? _timeFrom;
  TimeOfDay? _timeTo;
  final DateFormat formatter = DateFormat('EEE, dd MMM yyyy');

  String? address;
  eventCategories eventCategory = eventCategories.Anything;
  int ticketsNum = 0;

  thePrivacy eventPrivacy = thePrivacy.Public;

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

  late TextEditingController _ticketsController,
      _addressController,
      _couponController;
  void initState() {
    _ticketsController = TextEditingController(text: "0");
    _addressController = TextEditingController(text: " ");
    _couponController = TextEditingController(text: "0");
    super.initState();
  }

  eventPlace? thePlace;
  void dispose() {
    _ticketsController.dispose();
    _addressController.dispose();
    _couponController.dispose();
    event.reset();
  }

  XFile? image;
  String? url = null;
  Future pickImage() async {
    try {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (File(image!.path) == null) return;
      final String imageurl = await UploadImage.uploadImage(File(image!.path));
      setState(() {
        url = imageurl;
      });
    } on PlatformException catch (e) {
      print("error");
    }
  }

  late TheEvent event;
  void didChangeDependencies() {
    event = Provider.of<TheEvent>(context, listen: true);
    _dateFrom = event.startofEvent;
    _dateTo = event.endofEvent;
    _timeFrom = event.startofEventClock;
    _timeTo = event.endofEventClock;
    thePlace = event.isOnline ? eventPlace.Online : eventPlace.Venue;
    super.didChangeDependencies();
  }

  String saveForm() {
    //validataion

    if (url == null) {
      return "Error we need a photo";
    }
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
    dateTime1 = DateTime(0, 0, 0, _timeFrom!.hour, _timeFrom!.minute);
    dateTime2 = DateTime(0, 0, 0, _timeTo!.hour, _timeTo!.minute);
    if ((_dateFrom!.isAfter(_dateTo!)) ||
        ((_dateFrom?.day == _dateTo?.day) &&
            ((dateTime1.isAfter(dateTime2)))) ||
        ((_dateFrom?.day == _dateTo?.day) && (dateTime1 == dateTime2))) {
      return "Error in your date";
    }

    // if (event.totalTicketsLength < 1) return 'Error We need at least 1 Ticket';

    return "Done";
  }

  Widget build(BuildContext context) {
    _ticketsController =
        TextEditingController(text: event.totalTicketsLength.toString());

    _addressController = TextEditingController(text: event.city);

    _couponController =
        TextEditingController(text: event.totalCouponsLength.toString());

    return WillPopScope(
      onWillPop: () async {
        int count = 0;
        Navigator.pushNamedAndRemoveUntil(
          context,
          TabBarEvents.route,
          (route) => count++ == 2 || route.isFirst,
        );
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(31, 10, 61, 1),
          title: const Text(
            "Events",
            style: TextStyle(
              fontFamily: "Neue Plak Extended",
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                int count = 0;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  TabBarEvents.route,
                  (route) => count++ == 2 || route.isFirst,
                );
              },
              icon: Icon(Icons.cancel_rounded),
            ),
            IconButton(
              onPressed: () {
                String check = saveForm();

                if (check == 'Done') {
                  final isValid = _form.currentState?.validate();
                  if (!isValid!) {
                    return;
                  }
                  _form.currentState?.save();

                  event.setImageUrl = url!;
                  event.setStartOfEvent = _dateFrom!;
                  event.setEndOfEvent = _dateTo!;
                  event.setStartOfEventClock = _timeFrom!;
                  event.setEndOfEventClock = _timeTo!;
                  event.setIsOnline =
                      thePlace == eventPlace.Online ? true : false;

                  if (event.isOnline) event.setCity = null;

                  event.setEventCategory =
                      eventCategory != eventCategories.SportsandFitness
                          ? eventCategory.toString().split('.').last
                          : "Sports & Fitness";
                  event.setIsPublic =
                      eventPrivacy == thePrivacy.Public ? true : false;
                  print(event.toString());
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
              icon: Icon(Icons.upload),
            )
          ],
        ),
        drawer: EventDrawer(),
        body: Form(
          key: _form,
          child: ListView(
            children: [
              // Image Insert
              url == null
                  ? GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                        width: double.maxFinite,
                        height: 200,
                        color: Color.fromRGBO(132, 128, 163, 1),
                        child: Center(
                            child: Icon(
                          Icons.photo_camera,
                          size: 45,
                          color: const Color.fromRGBO(31, 10, 61, 1),
                        )),
                      ),
                    )
                  : Container(
                      width: double.maxFinite,
                      height: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(url!),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Optional: add child widgets or other properties to the Container
                    ),
              //title , username ,description
              ListTile(
                leading: Icon(Icons.text_fields_outlined),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      initialValue: event.title,
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
                        return null;
                      },
                      cursorColor: Colors.black,
                      cursorHeight: 18,
                      style: const TextStyle(
                        fontFamily: 'Neue Plak Extended',
                        fontWeight: FontWeight.w200,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter a title',
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                          fontFamily: 'Neue Plak Extended',
                          fontWeight: FontWeight.w200,
                          fontSize: 22,
                          color: Colors.blueGrey.withOpacity(0.8),
                        ),
                      ),
                      onSaved: (value) {
                        event.setTitle = value!;
                      },
                    ),
                    Text(
                      event.nameOrganizer,
                      style: const TextStyle(
                        fontFamily: 'Neue Plak Extended',
                        fontWeight: FontWeight.w200,
                        fontSize: 12,
                      ),
                    ),
                    TextFormField(
                      initialValue: event.description,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return "Description needed ";
                          } else if (value.trim().isEmpty) {
                            return "Description needed no string spaces allowed ";
                          } else {
                            return null;
                          }
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      cursorHeight: 18,
                      style: const TextStyle(
                        fontFamily: 'Neue Plak Extended',
                        fontWeight: FontWeight.w200,
                        fontSize: 20,
                      ),
                      maxLines: 1,
                      decoration: InputDecoration(
                          hintText: 'Briefly describe your event',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Neue Plak Extended',
                            fontWeight: FontWeight.w200,
                            fontSize: 19,
                            color: Colors.blueGrey.withOpacity(0.8),
                          ),
                          counterText: ""),
                      onSaved: (value) {
                        event.setDescription = value!;
                      },
                      maxLength: 140,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Start&End
              ListTile(
                leading: Icon(Icons.calendar_month),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Event Starts"),
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
                    const Text("Event ends"),
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
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: thePlace == eventPlace.Venue
                    ? Icon((Icons.location_on_outlined))
                    : Icon((Icons.computer_outlined)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PopupMenuButton(
                      color: Colors.white,
                      initialValue: thePlace,
                      onSelected: (eventPlace item) {
                        setState(() {
                          thePlace = item;
                        });
                      },
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          child: Text('Venue'),
                          value: eventPlace.Venue,
                        ),
                        PopupMenuItem(
                          child: Text('Online event'),
                          value: eventPlace.Online,
                        ),
                      ],
                      child: Row(
                        children: [
                          Text(thePlace == eventPlace.Venue
                              ? 'Venue'
                              : 'Online event'),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    if (thePlace == eventPlace.Venue) Text("Address"),
                    if (thePlace == eventPlace.Venue)
                      TextFormField(
                        readOnly: true,
                        enabled: true,
                        onTap: () {
                          Navigator.of(context).pushNamed(BarLocation.route);
                        },
                        controller: _addressController,
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return "Address needed ";
                            } else if (value.trim().isEmpty) {
                              return "Address needed";
                            } else {
                              return null;
                            }
                          }
                          return 'null value';
                        },
                        style: const TextStyle(
                          fontFamily: 'Neue Plak Extended',
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add your address',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Neue Plak Extended',
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            color: Colors.blueGrey.withOpacity(0.8),
                          ),
                        ),
                        onSaved: (value) {
                          event.setCity = value;
                        },
                      ),
                    // else should put address = null before submit
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(Icons.sell_outlined),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Event category'),
                    PopupMenuButton(
                      color: Colors.white,
                      initialValue: eventCategory,
                      onSelected: (value) {
                        setState(() {
                          eventCategory = value;
                        });
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          enabled: false,
                          child: Text(
                            "Select Event Category",
                            style: TextStyle(
                              fontFamily: "Neue Plak Extended",
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(31, 10, 61, 1),
                            ),
                          ),
                        ),
                        const PopupMenuItem(
                          child: Text('Anything'),
                          value: eventCategories.Anything,
                        ),
                        const PopupMenuItem(
                          child: Text('Learn'),
                          value: eventCategories.Learn,
                        ),
                        const PopupMenuItem(
                          child: Text('Buisness'),
                          value: eventCategories.Buisness,
                        ),
                        const PopupMenuItem(
                          child: Text('Health'),
                          value: eventCategories.Health,
                        ),
                        const PopupMenuItem(
                          child: Text('Sports & Fitness'),
                          value: eventCategories.SportsandFitness,
                        ),
                        const PopupMenuItem(
                          child: Text('Tech'),
                          value: eventCategories.Tech,
                        ),
                        const PopupMenuItem(
                          value: eventCategories.Culture,
                          child: Text('Culture'),
                        ),
                      ],
                      child: Row(
                        children: [
                          Text(eventCategory != eventCategories.SportsandFitness
                              ? eventCategory.toString().split('.').last
                              : "Sports & Fitness"),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(All_Tickets.route);
                },
                child: ListTile(
                  leading: Icon(Icons.assignment_ind_outlined),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Tickets"),
                      TextFormField(
                        onTap: () {
                          Navigator.of(context).pushNamed(All_Tickets.route);
                          setState(() {
                            ticketsNum++;
                          });
                        },
                        readOnly: true,
                        controller: _ticketsController,
                        enabled: true,
                        validator: (value) {
                          if (value != null) {
                            if (value == '0') {
                              return "Add tickets ";
                            } else {
                              return null;
                            }
                          }
                          return 'null value';
                        },
                        style: const TextStyle(
                          fontFamily: 'Neue Plak Extended',
                          fontWeight: FontWeight.w200,
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add your Tickets',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Neue Plak Extended',
                            fontWeight: FontWeight.w200,
                            fontSize: 14,
                            color: Colors.blueGrey.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(AllCoupons.route);
                },
                child: ListTile(
                  leading: Icon(Icons.card_giftcard_sharp),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Coupons"),
                            TextFormField(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(AllCoupons.route);
                                // Navigate to add Tickets page;
                              },
                              readOnly: true,
                              controller: _couponController,
                              enabled: true,
                              style: const TextStyle(
                                fontFamily: 'Neue Plak Extended',
                                fontWeight: FontWeight.w200,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Add your Coupons',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontFamily: 'Neue Plak Extended',
                                  fontWeight: FontWeight.w200,
                                  fontSize: 14,
                                  color: Colors.blueGrey.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.lock),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Privacy"),
                    PopupMenuButton(
                      color: Colors.white,
                      initialValue: eventPrivacy,
                      onSelected: (item) {
                        setState(() {
                          eventPrivacy = item;
                        });
                      },
                      itemBuilder: (_) => [
                        const PopupMenuItem(
                          value: thePrivacy.Public,
                          child: Text('Public'),
                        ),
                        const PopupMenuItem(
                          value: thePrivacy.Private,
                          child: Text('Private'),
                        ),
                      ],
                      child: Row(
                        children: [
                          Text(eventPrivacy.toString().split('.').last),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
