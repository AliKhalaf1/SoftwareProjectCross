library RadioButton;

import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget {
  //-----------------------------------------------------------//
  //                   status variable                        //
  // to be obtained from local data-base                     //
  int _selectedValue;
  //-----------------------------------------------------------//

  RadioButton(this._selectedValue,{super.key});

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {

  /**They must be here, so that we can change  (_selectedValue) by setstate*/
  List<Map<String, dynamic>> radioList = [
    {'id': 0, 'text': 'Relevance'},
    {'id': 1, 'text': 'Date'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> buildRadioList() {
      List<Widget> list = [];
      for (var i = 0; i < radioList.length; i++) {
        list.add(
          RadioListTile(
            activeColor: const Color.fromARGB(255, 29, 82, 215),
            controlAffinity: ListTileControlAffinity.trailing,
            contentPadding: EdgeInsets.zero,
            title: Text(
              radioList[i]['text'],
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(17, 3, 59, 1)),
            ),
            value: radioList[i]['id'],
            groupValue: widget._selectedValue,
            onChanged: (value) {
              setState(() {
                widget._selectedValue = value;
              });
            },
          ),
        );
      }
      return list;
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sort by',
            style: TextStyle(
                color: Color.fromARGB(255, 122, 121, 121),
                fontSize: 12,
                fontWeight: FontWeight.w500),
          ),
          Column(
            children: buildRadioList(),
          ),
        ],
      ),
    );
  }
}
