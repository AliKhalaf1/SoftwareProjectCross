import 'package:flutter/material.dart';

DateTime? showDatePickerr(BuildContext context) {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2015),
    lastDate: DateTime(2035),
  ).then((value) {
    return value;
  });
}

TimeOfDay? showTimePickerr(BuildContext context) {
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
    return value;
  });
}
