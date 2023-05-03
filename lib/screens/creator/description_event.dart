import 'package:Eventbrite/widgets/arc_painter.dart';
import 'package:flutter/material.dart';

import 'event_start_end_date.dart';

class Event_Description extends StatefulWidget {
  const Event_Description({super.key});
  static const route = '/eventsDescription';

  @override
  State<Event_Description> createState() => _EventTitleState();
}

class _EventTitleState extends State<Event_Description> {
  final _form = GlobalKey<FormState>();

  String stringInputCounter = "140";
  void _countStringInput(value) {
    setState(() {
      stringInputCounter = (140 - value.length).toString();
    });
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    Navigator.of(context).pushNamed(
      EventDate.route,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 65, left: 15, right: 15),
        child: Column(
          children: [
            const FittedBox(
              child: Text(
                "Describe your event.",
                style: TextStyle(
                  fontFamily: 'Neue Plak Extended',
                  fontSize: 32,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _form,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextFormField(
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
                      onChanged: (value) {
                        _countStringInput(value);
                      },
                      cursorColor: Colors.black,
                      cursorHeight: 18,
                      style: const TextStyle(
                        fontFamily: 'Neue Plak Extended',
                        fontWeight: FontWeight.w200,
                        fontSize: 20,
                      ),
                      maxLines: 10,
                      decoration: InputDecoration(
                          hintText:
                              'Enter a brief summary of your event so guests know what to expect',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: 'Neue Plak Extended',
                            fontWeight: FontWeight.w200,
                            fontSize: 19,
                            color: Colors.blueGrey.withOpacity(0.8),
                          ),
                          counterText: ""),
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onSaved: (value) {},
                      maxLength: 140,
                      autofocus: true,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(stringInputCounter),
          ),
          GestureDetector(
            onTap: () {
              _saveForm();
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    _saveForm();
                  },
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.arrow_circle_right_outlined,
                    color: Colors.black,
                  ),
                ),
                CustomPaint(
                  painter: ArcPainter(
                    startAngle: -90,
                    sweepAngle: 90,
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
          )
        ],
      ),
    );
  }
}
