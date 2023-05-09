import 'package:Eventbrite/screens/creator/event_location.dart';
import 'package:Eventbrite/widgets/from_to_date.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/createevent/createevent.dart';
import '../../widgets/arc_painter.dart';

class EventDate extends StatefulWidget {
  const EventDate({Key? key});
  static const route = '/eventDate';
  @override
  State<EventDate> createState() => _EventDateState();
}

class _EventDateState extends State<EventDate> {
  DateTime? _dateFrom = null;
  DateTime? _dateTo = null;
  TimeOfDay? _timeFrom = null;
  TimeOfDay? _timeTo = null;
  final DateFormat formatter = DateFormat('d-MMM');

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
            // Change the background color
            // Add other properties as needed to change other colors
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

  bool _handleSubmit() {
    DateTime dateTime1 = DateTime.now();
    DateTime dateTime2 = DateTime.now();

    if (_dateFrom == null ||
        _dateTo == null ||
        _timeFrom == null ||
        _timeTo == null) {
      // Display an error message if any of the values are null
      // ...
      return false;
    }
    dateTime1 = DateTime(_dateFrom!.year, _dateFrom!.month, _dateFrom!.day,
        _timeFrom!.hour, _timeFrom!.minute);
    dateTime2 = DateTime(_dateTo!.year, _dateTo!.month, _dateTo!.day,
        _timeTo!.hour, _timeTo!.minute);
    if ((dateTime1.isAfter(dateTime2)) ||
        (dateTime1.isAtSameMomentAs(dateTime2)) ||
        DateTime.now().isAfter(dateTime1)) {
      return false;
    } else {
      // All values are valid, submit
      // ...
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<TheEvent>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 65, left: 15, right: 15),
        child: Container(
          width: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Set the date of your event.",
                style: TextStyle(
                  fontFamily: 'Neue Plak Extended',
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DateColumn(
                _showDatePickerfrom,
                _showDatePickerto,
                (_dateFrom == null ? "Day" : formatter.format(_dateFrom!)),
                (_dateTo == null ? "Day" : formatter.format(_dateTo!)),
                _showTimePickerFrom,
                _showTimePickerTo,
                (_timeFrom == null
                    ? "Day"
                    : _timeFrom!.format(context).toString()),
                (_timeTo == null ? "Day" : _timeTo!.format(context).toString()),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          bool check = _handleSubmit();
          if (check) {
            event.setStartOfEvent = _dateFrom!;
            event.setEndOfEvent = _dateTo!;
            event.setStartOfEventClock = _timeFrom!;
            event.setEndOfEventClock = _timeTo!;

            Navigator.of(context).pushNamed(
              EventLocation.route,
            );
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Error in your date'),
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.arrow_circle_right_outlined,
                color: Colors.black,
              ),
            ),
            CustomPaint(
              painter: ArcPainter(
                startAngle: -90,
                sweepAngle: 180,
                color: Colors.lightGreen,
                strokeWidth: 4,
              ),
              child: const SizedBox(
                height: 65,
                width: 65,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
