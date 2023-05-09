library CheckBox;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filters/filter_selection_values.dart';

/// {@category User}
/// {@category Widgets}
///
/// This widget is used to display a checkbox with a title and a paragraph.
class CheckBox extends StatefulWidget {
  final String title;
  final String parag;
  bool buttonState;

  CheckBox(this.title, this.parag, this.buttonState, {super.key});

  @override
  State<CheckBox> createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  /* =========================== Method to render the list ========================*/
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return const Color.fromARGB(255, 29, 82, 215);
    }
    return const Color.fromARGB(255, 122, 121, 121);
  }

  @override
  Widget build(BuildContext context) {
    //---------------- Variables ---------------//

    final filtersDataValues = Provider.of<FilterSelectionValues>(context);

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                color: Color.fromARGB(255, 122, 121, 121),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.parag,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(17, 3, 59, 1)),
              ),
              Checkbox(
                key: Key("${widget.key}"),
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                // activeColor: const Color.fromARGB(255, 29, 82, 215),
                value: filtersDataValues.price,
                onChanged: (bool? value) {
                  setState(() {
                    if (widget.title == 'Price') {
                      filtersDataValues.setPrice(!filtersDataValues.price);
                      if (filtersDataValues.price) {
                        filtersDataValues.selectedFilterCount++;
                      } else {
                        filtersDataValues.selectedFilterCount--;
                      }
                    } else {
                      // filtersDataValues.setOrg(!filtersDataValues.organizer);
                      // if (filtersDataValues.organizer) {
                      //   filtersDataValues.selectedFilterCount++;
                      // } else {
                      //   filtersDataValues.selectedFilterCount--;
                      // }
                    }
                    widget.buttonState = true;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
