// library RadioButton;

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../providers/filters/filter_selection_values.dart';

// class RadioButton extends StatefulWidget {
//   bool buttonState;

//   RadioButton(this.buttonState, {super.key});

//   @override
//   State<RadioButton> createState() => _RadioButtonState();
// }

// class _RadioButtonState extends State<RadioButton> {
//   /* They must be here, so that we can change  (_selectedValue) by setstate */
//   List<Map<String, dynamic>> radioList = [
//     {'id': 0, 'text': 'Relevance'},
//     {'id': 1, 'text': 'Date'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     //---------------- Variables ---------------//

//     final filtersDataValues = Provider.of<FilterSelectionValues>(context);

//     /* =========================== Method to render the list ========================*/
//     List<Widget> buildRadioList() {
//       List<Widget> list = [];
//       for (var i = 0; i < radioList.length; i++) {
//         list.add(
//           RadioListTile(
//             key: Key("${radioList[i]['text']}RadioBtn"),
//             activeColor: const Color.fromARGB(255, 29, 82, 215),
//             controlAffinity: ListTileControlAffinity.trailing,
//             contentPadding: EdgeInsets.zero,
//             title: Text(
//               radioList[i]['text'],
//               style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                   color: Color.fromRGBO(17, 3, 59, 1)),
//             ),
//             value: radioList[i]['id'],
//             groupValue: filtersDataValues.sortBy,
//             onChanged: (value) {
//               setState(() {
//                 filtersDataValues.setSortingBy(value);
//                 widget.buttonState = true;
//                 if (value == 0) {
//                   filtersDataValues.selectedFilterCount--;
//                 } else {
//                   filtersDataValues.selectedFilterCount++;
//                 }
//               });
//             },
//           ),
//         );
//       }
//       return list;
//     }

//     return Padding(
//       padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Sort by',
//             style: TextStyle(
//                 color: Color.fromARGB(255, 122, 121, 121),
//                 fontSize: 12,
//                 fontWeight: FontWeight.w500),
//           ),
//           Column(
//             children: buildRadioList(),
//           ),
//         ],
//       ),
//     );
//   }
// }
