import 'package:flutter/material.dart';

import 'dayandtime.dart';

class DateColumn extends StatelessWidget {
  final Function _showDatePickerFrom;
  final Function _showDatePickerTo;
  final String _dayFrom;
  final String _dayTo;

  final Function _showTimePickerFrom;
  final Function _showTimePickerTo;
  final String _timeFrom;
  final String _timeTo;

  DateColumn(
      this._showDatePickerFrom,
      this._showDatePickerTo,
      this._dayFrom,
      this._dayTo,
      this._showTimePickerFrom,
      this._showTimePickerTo,
      this._timeFrom,
      this._timeTo,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "From:",
          style: TextStyle(
            fontFamily: 'Neue Plak Extended',
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        DayandTime(
            _showDatePickerFrom, _dayFrom, _showTimePickerFrom, _timeFrom),
        SizedBox(
          height: 10,
        ),
        Text(
          "To:",
          style: TextStyle(
            fontFamily: 'Neue Plak Extended',
            fontSize: 25,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        DayandTime(_showDatePickerTo, _dayTo, _showTimePickerTo, _timeTo),
      ],
    );
  }
}
