library DraftEventCard;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
/// {@category Widgets}
///
///DraftCard class is a stateless widget that displays a draft card with a description and a date. 
///
///

class DraftCard extends StatelessWidget {
  final String draftDescription;
  final String dateString;
  DraftCard(this.dateString, this.draftDescription, {super.key});

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(dateString);
    String formattedDate = DateFormat('EEE, MMM d, h:mm a')
        .format(dateTime); // format the DateTime object

    return ListTile(
      key: key,
      onTap: () {},
      leading: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(30),
        dashPattern: [3, 3],
        strokeWidth: 1,
        color: Colors.grey,
        child: Container(
          width: 50,
          height: 50,
          child: const Icon(
            Icons.edit,
            color: Colors.grey,
            size: 30.0,
          ),
        ),
      ),
      title: Text(
        draftDescription,
        style: TextStyle(
          color: Theme.of(context).cardColor,
        ),
      ),
      subtitle: Text(
        formattedDate,
        style: TextStyle(
          color: Theme.of(context).cardColor,
        ),
      ),
    );
  }
}
