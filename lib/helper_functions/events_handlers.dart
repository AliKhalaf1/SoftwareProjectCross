library EventsHelperFunctions;

import 'package:flutter/material.dart';
import '../screens/event_page.dart';
import '../providers/events/event.dart';
import 'constants.dart';
import 'log_in.dart';
import 'package:http/http.dart' as http;

/// {@category Helper Functions}
/// Navigate to event page and render selected event
///
/// Used inside EventCard widget
///
/// Get token if logged user or not and event id then sent them as an arguments to naviated screen
Future<void> selectEvent(BuildContext ctx, Event event) async {
  checkLoggedUser().then((isLogged) {
    // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    //   return EventPage(event.id, isLogged);
    // }));

    Map<String, dynamic> args = {
      'eventId': event.id,
      'isLogged': isLogged == true ? "1" : "0",
      'eventIdMock': event.mockId,
    };

    Navigator.of(ctx).pushNamed(
      EventPage.eventPageRoute,
      arguments: args,
    );
  });
}

/// {@category Helper Functions}
/// Navigate to event page Using EventID and render selected event
///
///

Future<int> selectEventById(String eventId) async {
  ////////////////////////////////////////////////////////////////////////////////////////////////////
  if (Constants.MockServer == false) {
    var uri = Uri.parse('${Constants.host}/events/id/${eventId}');

    var response = await http.get(uri);

    return response.statusCode;
  } else {
    return 200;
  }
}

final fieldKey = GlobalKey<FormFieldState>();
void validateLogic() {
  print("I'm here");
  final isValid = fieldKey.currentState?.validate();
  print(isValid);
  if (!isValid!) {
    return;
  } else {
    fieldKey.currentState?.save();
  }
}

// void ShowModalBottomSheet(BuildContext ctx) {
//   TextEditingController controller = TextEditingController();
//   String error = "";
//   showModalBottomSheet(
//       context: ctx,
//       builder: (_) {
//         //------------------------ user input -------------------//
//         return GestureDetector(
//           onTap: () {},
//           behavior: HitTestBehavior.opaque,
//           child: Column(
//             children: [
//               Container(
//                 width: MediaQuery.of(ctx).size.width * 0.9,
//                 height: 80,
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Form(
//                   //key: fieldKey,
//                   child: TextFormField(
//                     controller: controller,
//                     key: fieldKey,
//                     //Validations

//                     validator: (valuesss) {
                      

//                       if (valuesss!.isEmpty) {
//                         return "Please enter event id";
//                       } else {
//                         String message = "";

//                         selectEventById(valuesss).then((value) {
//                           if (value == 200) {
//                             return null;
//                           } else if (value == 404) {
//                             message = "Event is not found";
//                           } else if (value == 400) {
//                             message = "Event Id is not valid";
//                           } else {
//                             message = "Something went wrong";
//                           }
//                         });
//                       }
//                     },

//                     /// Go to valid
//                     onSaved: (newValue) async {
//                       bool asd = await checkLoggedUser();
//                       Map<String, dynamic> args = {
//                         'eventId':
//                             Constants.MockServer == false ? newValue : "",
//                         'isLogged': asd == true ? "1" : "0",
//                         'eventIdMock':
//                             Constants.MockServer == true ? newValue : 0,
//                       };

//                       Navigator.of(ctx).pushNamed(
//                         EventPage.eventPageRoute,
//                         arguments: args,
//                       );
//                     },

//                     cursorColor: const Color.fromARGB(255, 50, 100, 237),
//                     // maxLength: 20,
//                     style: const TextStyle(),
//                     decoration: InputDecoration(
//                         suffixIcon: IconButton(
//                           key: const Key('privateEventBtn'),
//                           icon: const Icon(Icons.check_circle),
//                           onPressed: validateLogic,
//                           color: Color.fromARGB(255, 50, 100, 237),
//                         ),
//                         hintText: "Enter event pass",
//                         floatingLabelBehavior: FloatingLabelBehavior.always,
//                         floatingLabelStyle: const TextStyle(
//                             color: Color.fromARGB(255, 50, 100, 237)),
//                         labelText: 'event password',
//                         border: const OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(0)),
//                         ),
//                         focusedBorder: const OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: Color.fromARGB(255, 50, 100, 237),
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(0)),
//                         )),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 15,
//               ),
//               Text(
//                 error,
//                 style: const TextStyle(color: Colors.red),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         );
//       });
// }
