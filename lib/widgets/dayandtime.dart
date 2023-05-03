import 'package:flutter/material.dart';

class DayandTime extends StatelessWidget {
  final Function _showDatePicker;
  final Function _showTimePicker;
  final String _day;
  final String _time;
  DayandTime(this._showDatePicker, this._day, this._showTimePicker, this._time,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            _showDatePicker();
          },
          child: Row(
            children: [
              const Icon(Icons.calendar_month_outlined),
              const SizedBox(
                width: 5,
              ),
              Text(
                _day,
                style: TextStyle(
                  fontFamily: 'Neue Plak Extended',
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                _showTimePicker();
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    _time,
                    style: TextStyle(
                      fontFamily: 'Neue Plak Extended',
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
