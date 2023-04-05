library CheckBox;

import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  //-----------------------------------------------------------//
  //                   status variable                        //
  // to be obtained from local data-base                     //
  bool _isChecked;
  //-----------------------------------------------------------//
  final String title;
  final String parag;

  CheckBox(this.title, this.parag, this._isChecked, {super.key});

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
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.resolveWith(getColor),
                // activeColor: const Color.fromARGB(255, 29, 82, 215),
                value: widget._isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    widget._isChecked = value!;
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
