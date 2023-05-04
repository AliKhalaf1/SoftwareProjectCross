import 'package:Eventbrite/screens/creator/description_event.dart';
import 'package:flutter/material.dart';

class EventTitle extends StatefulWidget {
  const EventTitle({super.key});
  static const route = '/eventsTitle';

  @override
  State<EventTitle> createState() => _EventTitleState();
}

class _EventTitleState extends State<EventTitle> {
  final _form = GlobalKey<FormState>();
  bool _showAnimation = true;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 1200), () {
      setState(() {
        _showAnimation = false;
      });
    });
  }

  bool _rightArrow = false;
  void enableRightArrow(var value) {
    if (value.isEmpty && _rightArrow == true) {
      setState(() {
        _rightArrow = false;
      });
    } else if (value.isNotEmpty && _rightArrow == false) {
      setState(() {
        _rightArrow = true;
      });
    } else {}
  }

  void _saveForm() {
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    Navigator.of(context).pushNamed(
      Event_Description.route,
    );
  }

  Widget build(BuildContext context) {
    return !_showAnimation
        ? Scaffold(
            body: Padding(
              padding: const EdgeInsets.only(top: 65, left: 15, right: 15),
              child: Column(
                children: [
                  const FittedBox(
                    child: Text(
                      "Give your event a title.",
                      style: TextStyle(
                        fontFamily: 'Neue Plak Extended',
                        fontSize: 32,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _form,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: TextFormField(
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
                        onChanged: (value) {
                          if (value.trim().isNotEmpty && value.isNotEmpty) {
                            enableRightArrow(value);
                          }
                        },
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
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) {},
                        autofocus: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: _rightArrow
                ? FloatingActionButton(
                    onPressed: () {
                      _saveForm();
                    },
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.arrow_circle_right_outlined,
                      color: Colors.black,
                    ),
                  )
                : null,
          )
        : const Scaffold(
            backgroundColor: Color.fromRGBO(209, 65, 12, 1),
          );
  }
}
